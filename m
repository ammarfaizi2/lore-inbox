Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVCIOsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVCIOsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCIOqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:46:02 -0500
Received: from mail0.lsil.com ([147.145.40.20]:8337 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261856AbVCIOof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:44:35 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC1C@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod
	 ule  for LSI Logic's SAS based MegaRAID controllers
Date: Wed, 9 Mar 2005 09:43:47 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> I will make this an instance parameter if the idea to reduce as many
>> global variables as possible. But if the objection is because each
>> adapter
>> may have different value for variable, then it is indeed a global
>> value.
>> "is_dma64" - which is computed using the size of dma_addr_t - is
>> telling
>> something about the kernel rather than the controller feature.
>> 
>
>then having it as variable sounds really really wrong; the size of
>dma_addr_t is a compile time property...
>(and why do you care about it? you see high dma addresses when 
>they come
>in, right?)
>

During the module load time, I allocate 32 bit or 64 bit SGLs based on
whether I can receive 64 bit DMA addresses or not. If size of dma_addr_t
is 4, then I allocate only 32 bit SGLs. During the run time, I prepare 
32/64 bit SGLs based on this variable. And since this is compile time
system-wide property, I kept it as driver global.

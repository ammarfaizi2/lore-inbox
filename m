Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVCJAD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVCJAD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVCIX7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:59:36 -0500
Received: from mail0.lsil.com ([147.145.40.20]:3794 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262065AbVCIX4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:56:52 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC23@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod
	 ule  for LSI Logic's SAS based MegaRAID controllers
Date: Wed, 9 Mar 2005 18:56:02 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> >Even for kernels with a 64bit dma_addr_t you can get 32bit dma 
>> >addresses
>> >only.  As a start check whether the pci_set_dma_mask for 
>the 64bit mask
>> >failed - in that case you can always use 32bit SGLs.
>> >
>> 
>> Please help me understand: If dma_addr_t is 64 bit, I will get 64bit 
>> addresses in scatterlist regardless the outcome of pci_set_dma_mask, 
>> won't I? These addresses may have valid or null high 
>addresses. My idea
>> was to have 32(64) bit SGLs for 32(64) bit dma_addr_t.
>
>if pci_set_dma_mask for the 64bit mask fails the upper 32bit bit of
>dma_addr_t will guaranteed to be zero, so you don't need to take them
>into account for your hardware SGL.
>

Okay. I understood. Thanks. But please consider this also:

Arjan pointed out that by basing my 32/64 SGL decision solely on
#define IS_DMA64 sizeof(dma_addr_t)==8, I can rely on gcc to optimize the
unused portion of the code away. If I take pci_set_dma_mask also into
account, I can't do that, can I?

Thanks,
Sreenivas

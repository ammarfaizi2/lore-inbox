Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVCIXQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVCIXQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVCIXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:15:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262533AbVCIW7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:59:30 -0500
Date: Wed, 9 Mar 2005 22:59:27 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod ule  for LSI Logic's SAS based MegaRAID controllers
Message-ID: <20050309225927.GA10646@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	'Arjan van de Ven' <arjan@infradead.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
	Andrew Morton <akpm@osdl.org>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC22@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC22@exa-atlanta>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 05:47:27PM -0500, Bagalkote, Sreenivas wrote:
> >
> >Even for kernels with a 64bit dma_addr_t you can get 32bit dma 
> >addresses
> >only.  As a start check whether the pci_set_dma_mask for the 64bit mask
> >failed - in that case you can always use 32bit SGLs.
> >
> 
> Please help me understand: If dma_addr_t is 64 bit, I will get 64bit 
> addresses in scatterlist regardless the outcome of pci_set_dma_mask, 
> won't I? These addresses may have valid or null high addresses. My idea
> was to have 32(64) bit SGLs for 32(64) bit dma_addr_t.

if pci_set_dma_mask for the 64bit mask fails the upper 32bit bit of
dma_addr_t will guaranteed to be zero, so you don't need to take them
into account for your hardware SGL.


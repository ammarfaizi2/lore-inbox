Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTDYOUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTDYOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:20:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52109 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263245AbTDYOUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:20:15 -0400
Date: Fri, 25 Apr 2003 16:32:21 +0200
From: Jens Axboe <axboe@kernel.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: mikem@beardog.cca.cpqcorp.net, linux-kernel@vger.kernel.org,
       mike.miller@hp.com, steve.cameron@hp.com
Subject: Re: RE:cciss patches for 2.4.21-rc1, 4 of 4
Message-ID: <20030425143221.GQ1012@suse.de>
References: <200304242212.h3OMCgc01143@beardog.cca.cpqcorp.net> <1051279472.1391.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051279472.1391.15.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25 2003, Arjan van de Ven wrote:
> On Fri, 2003-04-25 at 00:12, mikem@beardog.cca.cpqcorp.net wrote:
> > 20030424
> > 
> > Changes:
> > 	1. Sets the DMA mask to 64 bits. Removes RH's code for the DMA mask.
> > 
> > diff -urN lx2421rc1-p3/drivers/block/cciss.c lx2421rc1/drivers/block/cciss.c
> > --- lx2421rc1-p3/drivers/block/cciss.c	Wed Apr 23 14:40:48 2003
> > +++ lx2421rc1/drivers/block/cciss.c	Wed Apr 23 14:51:55 2003
> > @@ -106,7 +106,7 @@
> >  #define NR_CMDS		 128 /* #commands that can be outstanding */
> >  #define MAX_CTLR 8
> >  
> > -#define CCISS_DMA_MASK	0xFFFFFFFF	/* 32 bit DMA */
> > +#define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFF /* 64 bit DMA */
> >  
> >  static ctlr_info_t *hba[MAX_CTLR];
> >  
> > @@ -2861,17 +2861,6 @@
> >  	hba[i]->ctlr = i;
> >  	hba[i]->pdev = pdev;
> >  
> > -	/* configure PCI DMA stuff */
> > -	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff))
> > -		printk("cciss: using DAC cycles\n");
> > -	else if (!pci_set_dma_mask(pdev, (u64) 0xffffffff))
> > -		printk("cciss: not using DAC cycles\n");
> > -	else {
> > -		printk("cciss: no suitable DMA available\n");
> > -		free_hba(i);
> > -		return -ENODEV;
> > -	}
> > -		
> 
> 
> this is wrong. The code there is EXACTLY what is needed as per
> Documentation/DMA-mapping.txt, removing it is a bug.

Agree, besides, it was never RH code, dunno where that idea came from?

-- 
Jens Axboe


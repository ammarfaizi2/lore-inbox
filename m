Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTI2R0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTI2R0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:26:00 -0400
Received: from havoc.gtf.org ([63.247.75.124]:57009 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263890AbTI2RZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:25:09 -0400
Date: Mon, 29 Sep 2003 13:23:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ULL fixes for qlogicfc
Message-ID: <20030929172329.GD6526@gtf.org>
References: <E1A41Rq-0000NJ-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A41Rq-0000NJ-00@hardwired>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/qlogicfc.c linux-2.5/drivers/scsi/qlogicfc.c
> --- bk-linus/drivers/scsi/qlogicfc.c	2003-09-08 00:47:00.000000000 +0100
> +++ linux-2.5/drivers/scsi/qlogicfc.c	2003-09-08 01:30:56.000000000 +0100
> @@ -718,8 +718,8 @@ int isp2x00_detect(Scsi_Host_Template * 
>  				continue;
>  
>  			/* Try to configure DMA attributes. */
> -			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff) &&
> -			    pci_set_dma_mask(pdev, (u64) 0xffffffff))
> +			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
> +			    pci_set_dma_mask(pdev, 0xffffffffULL))
>  					continue;

Looks great.

I wonder if you are motivated to create similar pci_set_dma_mask()
cleanups for other drivers?  ;-)  Several other drivers need this same
cleanup, too.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265163AbSIWHgn>; Mon, 23 Sep 2002 03:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSIWHgm>; Mon, 23 Sep 2002 03:36:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7147 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265163AbSIWHgm>;
	Mon, 23 Sep 2002 03:36:42 -0400
Date: Mon, 23 Sep 2002 09:41:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 oopses at boot in ide_toggle_bounce
Message-ID: <20020923074142.GB15479@suse.de>
References: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21 2002, Andries.Brouwer@cwi.nl wrote:
> 2.5.37 oopses at boot in ide_toggle_bounce().
> With
> 
> --- linux-2.5.37/linux/drivers/ide/ide-lib.c    Sat Sep 21 11:39:48 2002
> +++ linux-2.5.37a/linux/drivers/ide/ide-lib.c   Sat Sep 21 14:06:45 2002
> @@ -394,7 +394,7 @@
>         if (on && drive->media == ide_disk) {
>                 if (!PCI_DMA_BUS_IS_PHYS)
>                         addr = BLK_BOUNCE_ANY;
> -               else
> +               else if (HWIF(drive)->pci_dev)
>                         addr = HWIF(drive)->pci_dev->dma_mask;
>         }
> 
> it boots for me. I have not investigated a proper fix.

Patch is fine, thanks Andries.

-- 
Jens Axboe


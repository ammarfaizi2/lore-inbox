Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUJVSUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUJVSUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUJVSU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:20:27 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:25510 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267935AbUJVSRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:17:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FAgxRPGFI684pkmVAxs2R2kWmzAMI8NB/gDL6PhIQk5vuQrVEtxjJlTMk0oK5xp6FcR32tKmH/8HbYInIQJhQrFtHGnvHbv3FWbuW4e4gUfJZsqd//57+/7gVOxskBVUyvzA6DDTNGUYo0Gzy324rb7CG/e6TT/PuUpNGDfX+Tc=
Message-ID: <58cb370e0410221117102cf1f6@mail.gmail.com>
Date: Fri, 22 Oct 2004 20:17:09 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] ide-2.6 update
In-Reply-To: <20041022190715.B3459@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04102210385ca8b554@mail.gmail.com>
	 <20041022190715.B3459@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 19:07:15 +0100, Russell King
<rmk+lkml@arm.linux.org.uk> wrote:
> On Fri, Oct 22, 2004 at 07:38:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > @@ -498,14 +483,6 @@
> >                       ICS_ARCIN_V6_INTRSTAT_1)) & 1;
> >  }
> >
> > -static int icside_dma_verbose(ide_drive_t *drive)
> > -{
> > -     printk(", %s (peak %dMB/s)",
> > -             ide_xfer_verbose(drive->current_speed),
> > -             2000 / drive->drive_data);
> > -     return 1;
> > -}
> > -
> >  static int icside_dma_timeout(ide_drive_t *drive)
> >  {
> >       printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
> > @@ -554,7 +531,6 @@
> >       hwif->dma_start         = icside_dma_start;
> >       hwif->ide_dma_end       = icside_dma_end;
> >       hwif->ide_dma_test_irq  = icside_dma_test_irq;
> > -     hwif->ide_dma_verbose   = icside_dma_verbose;
> >       hwif->ide_dma_timeout   = icside_dma_timeout;
> >       hwif->ide_dma_lostirq   = icside_dma_lostirq;
> 
> Why are you denying me the ability to report detailed drive transfer
> speed information?  Would you prefer me to printk a separate line
> and further clutter up the message log instead?

>From the changelog:
> * icside.c version repeated info given by ->ide_dma_check()

If DMA is going to be used:
* ->ide_dma_check is always called
* icside_dma_check() always calls icside_set_speed()
* icside_set_speed() always does

	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);

so what am I missing?

Bartlomiej

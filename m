Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVE2TCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVE2TCv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVE2TCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:02:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51595 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261331AbVE2TCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:02:44 -0400
Date: Sun, 29 May 2005 21:03:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050529190259.GA29770@suse.de>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4299BD23.6010004@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Michael Thonke wrote:
> Jens Axboe wrote,
> 
> >
> >There's really nothing to be tuned. If NCQ is enabled for your drive, it
> >will be printed in dmesg after the lba48 flag, such as:
> >
> >ata1: dev 0 ATA, max UDMA/133, 488281250 sectors lba48 ncq
> >
> >If you don't see NCQ there, your drive/controller doesn't support it.
> >Likewise you will have a queueing depth of > 1 if NCQ is enabled, check
> >/sys/block/sdX/device/queue_depth to see what the configured queueing
> >depth is for that device.
> >
> >  
> >
> Hi Jens,
> 
> thanks for the short info now my next question how many queue depths
> are healty and wanted?
> 
> For my Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage
> Controllers cc=AHCI (rev 01)
> and Samsung Hd160JJ SATAII drive the default queue is 30
> 
>     ioGL64NX_MACH~# cat /sys/block/sda/device/{model,queue_depth}
>     SAMSUNG HD160JJ
>     30
> 
>     hdparm -Tt /dev/sda
> 
>     /dev/sda:
>     Timing cached reads: 4724 MB in 2.00 seconds = 2360.00 MB/sec
>     Timing buffered disk reads: 164 MB in 3.02 seconds = 54.28 MB/sec
> 
> On random access the drives is a bit noisy but the subjective feeling
> is great everything goes a bit faster.

You should see a nice performance improvement on random reads mainly,
with streamed threaded reads being a bit faster as well. Write
performance will be the same, if you had write back caching on before.
So the real win is random reads, and that can be a pretty big win.

Actually I would say that the drive should sound _less_ noisy if NCQ is
being really effective. Hard to judge of course, very subjective :)

> And whats about the option /sys/block/sdx/device/queue_type = simple
> what can be done here?

Nothing, unfortunately NCQ doesn't provided any way of doing ordered
tags. The only tunable is the queue_depth, you can set that anywhere
between 1 and 30.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVE2TIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVE2TIG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVE2THx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:07:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:653 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261404AbVE2TFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:05:55 -0400
Date: Sun, 29 May 2005 21:06:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050529190608.GC29770@suse.de>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <429A05AC.9020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429A05AC.9020805@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Michael Thonke wrote:
> Jens Axboe schrieb:
> 
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
> Hello again,
> 
> the queue_depth of 30 is okay? On boot the CFQ scheduler tells:

By default, the maximum depth is used. For desktop use, a depth of 2-4
is probably more appropriate until the io schedulers become a little
more intelligent wrt queueing.

>       cfq: depth 4 reached, tagging now on
> 
> This only appears with AHCI enabled what does that mean?

It only appears if AHCI is enabled, because tagged command queueing is
only working/enabled on AHCI. The message is informational only, CFQ
tells you that it has detected queueing hardware (driver maintains a
depth of >= 4).

> Also a question which options can be set in queue_type?

Nothing.

-- 
Jens Axboe


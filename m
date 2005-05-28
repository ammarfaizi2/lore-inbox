Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVE1MMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVE1MMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVE1MMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:12:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8611 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262714AbVE1MMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:12:45 -0400
Date: Sat, 28 May 2005 14:12:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050528121258.GA17869@suse.de>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42979FA3.1010106@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28 2005, Michael Thonke wrote:
> Jeff Garzik schrieb:
> 
> > Michael Thonke wrote:
> >
> >> Hello Jens,
> >>
> >> I tried to play with your patch on ICH6R and ICH7R chipset also on
> >> Sil3124R Controller
> >> with 2xSamsung HD160JJ SATAII drives. But the performance gain stay
> >> out..
> >> anything special to set to get it working? I used a vanilla-kernel
> >> 2.6.12-rc5-git2 for it.
> >
> >
> > SiI 3124 driver needs to be updated to support NCQ.
> >
> >     Jeff
> >
> >
> >
> >
> Hello Jeff,
> 
> thanks for the info, and whats about Intel ICH6R and ICH7R anything
> special there?
> I played a bit with the patch and tried to tune it a bit. But there is
> no Documentation
> for AHCI in kernel.with parameter I can handover or can be changed.
> Maybe I've missed them?
> If so can you please refer me to one?

There's really nothing to be tuned. If NCQ is enabled for your drive, it
will be printed in dmesg after the lba48 flag, such as:

ata1: dev 0 ATA, max UDMA/133, 488281250 sectors lba48 ncq

If you don't see NCQ there, your drive/controller doesn't support it.
Likewise you will have a queueing depth of > 1 if NCQ is enabled, check
/sys/block/sdX/device/queue_depth to see what the configured queueing
depth is for that device.

-- 
Jens Axboe


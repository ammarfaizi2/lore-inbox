Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbULBIID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbULBIID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbULBIID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:08:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42910 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261341AbULBIHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:07:37 -0500
Date: Thu, 2 Dec 2004 09:07:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
Message-ID: <20041202080709.GB10454@suse.de>
References: <1101763996l.13519l.0l@werewolf.able.es> <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr> <1101765555l.13519l.1l@werewolf.able.es> <20041130071638.GC10450@suse.de> <87eki9bs33.fsf@plailis.daheim.bs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eki9bs33.fsf@plailis.daheim.bs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01 2004, Markus Plail wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Mon, Nov 29 2004, J.A. Magallon wrote:
> >> dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:
> >> 
> >> > scsibus: -1 target: -1 lun: -1
> >> > Warning: Using ATA Packet interface.
> >> > Warning: The related Linux kernel interface code seems to be unmaintained.
> >> > Warning: There is absolutely NO DMA, operations thus are slow.
> >> 
> >> dev=ATA uses direct IDE burning. Try that as root. In my box, as root:
> >
> > Oh no, not this again... Please check the facts: the ATAPI method uses
> > the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> > /dev/sgX, unless you actually give /dev/sgX as the device name. It has
> > nothing to do with ide-scsi. Period.
> >
> > ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> > burning, it's a crippled interface from the CDROM layer that should not
> > be used for anything.  scsi-linux-ata.c should be ripped from the
> > cdrecord sources, or at least cdrecord should _never_ select that
> > transport for 2.6 kernels. For 2.4 you are far better off using
> > ide-scsi.
> 
> Are you sure you don't mix ATA with ATAPI? I think ATA is equivalent to
> dev=/dev/hdX. 

I did mix them up, my apologies til Magallon. As always you should just
use -dev=/dev/hdX and it will work the best, there's no need to give ATA
or ATAPI. They are too easy to mix up as the names don't really give you
any hints on what access method they will utilize. Using -dev also means
there's no reason to run -scanbus at all, since you know where the
device is. If you don't, then you probably should be using k3b or some
other helper to work out things for you.

-- 
Jens Axboe


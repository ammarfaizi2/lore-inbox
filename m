Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVAGOBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVAGOBB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVAGOBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:01:01 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:43026 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261415AbVAGOAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:00:53 -0500
Date: Fri, 7 Jan 2005 15:00:35 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Al Viro <viro@ftp.uk.linux.org>,
       Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20050107140035.GA5920@pclin040.win.tue.nl>
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk> <41D4253D.8070006@drzeus.cx> <20050107123947.B23665@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107123947.B23665@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 12:39:47PM +0000, Russell King wrote:
> On Thu, Dec 30, 2004 at 04:56:45PM +0100, Pierre Ossman wrote:
> > Russell King wrote:
> > >On Thu, Dec 30, 2004 at 03:14:07AM +0100, Pierre Ossman wrote:
> > >>A MMC card is a highly removable device. This patch makes the block 
> > >>layer part of the MMC layer set the removable flag.
> > >
> > >I have this patch also floating around, but I've decided it isn't needed.
> > >I believe this flag is to indicate that we have removable media for a
> > >block device rather than to indicate that the block device can be removed.
> > >
> > >However, when we insert and remove a MMC card, we create and destroy the
> > >block device itself.  Therefore, as far as the block layer is concerned,
> > >the device itself is being inserted and removed, so telling the block
> > >layer that the media is removable is just silly - you can't separate the
> > >flash media from the on-board MMC controller.
> > >
> > >(Note: any block device can be removed - you just rmmod the module
> > >supplying the block device driver, but this doesn't mean we mark all
> > >block devices with GENHD_FL_REMOVABLE.)
> >
> > I suspect that the removable flag might be used in different GUI:s to 
> > figure out with block devices should be presented to the user in a nice 
> > way. It's usually just the removable devices that need some form of 
> > special handling. So even though, as you point out, the entire device 
> > disappears it might be useful from a user interface perspective to have 
> > this hint set. From what I've found this flag doesn't seem to change any 
> > handling inside the kernel, just how the device should be perceived.
> 
> Can anyone comment on the purpose of this (GENHD_FL_REMOVABLE) flag?
> Al?  Jens?

GENHD_FL_REMOVABLE is set by a number of drivers (floppy, CDROM, ...).
It is used in two places:
(1) to fill the file /sys/block/*/removable
(2) in genhd to suppress listing a nonpartitioned removable device
in /proc/partitions.

In other words, it is for user space only, precisely as Pierre Ossman said.

Andries

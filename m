Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVAGMkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVAGMkD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVAGMkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:40:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7685 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261391AbVAGMjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:39:53 -0500
Date: Fri, 7 Jan 2005 12:39:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Al Viro <viro@ftp.uk.linux.org>,
       Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20050107123947.B23665@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk> <41D4253D.8070006@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41D4253D.8070006@drzeus.cx>; from drzeus-list@drzeus.cx on Thu, Dec 30, 2004 at 04:56:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 04:56:45PM +0100, Pierre Ossman wrote:
> Russell King wrote:
> >On Thu, Dec 30, 2004 at 03:14:07AM +0100, Pierre Ossman wrote:
> >>A MMC card is a highly removable device. This patch makes the block 
> >>layer part of the MMC layer set the removable flag.
> >
> >I have this patch also floating around, but I've decided it isn't needed.
> >I believe this flag is to indicate that we have removable media for a
> >block device rather than to indicate that the block device can be removed.
> >
> >However, when we insert and remove a MMC card, we create and destroy the
> >block device itself.  Therefore, as far as the block layer is concerned,
> >the device itself is being inserted and removed, so telling the block
> >layer that the media is removable is just silly - you can't separate the
> >flash media from the on-board MMC controller.
> >
> >(Note: any block device can be removed - you just rmmod the module
> >supplying the block device driver, but this doesn't mean we mark all
> >block devices with GENHD_FL_REMOVABLE.)
>
> I suspect that the removable flag might be used in different GUI:s to 
> figure out with block devices should be presented to the user in a nice 
> way. It's usually just the removable devices that need some form of 
> special handling. So even though, as you point out, the entire device 
> disappears it might be useful from a user interface perspective to have 
> this hint set. From what I've found this flag doesn't seem to change any 
> handling inside the kernel, just how the device should be perceived.

Can anyone comment on the purpose of this (GENHD_FL_REMOVABLE) flag?
Al?  Jens?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

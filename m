Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVAHLNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVAHLNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAHLML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 06:12:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41997 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261852AbVAHLKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 06:10:05 -0500
Date: Sat, 8 Jan 2005 11:09:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Al Viro <viro@ftp.uk.linux.org>,
       Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20050108110957.D7065@flint.arm.linux.org.uk>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk> <41D4253D.8070006@drzeus.cx> <20050107123947.B23665@flint.arm.linux.org.uk> <20050107140035.GA5920@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050107140035.GA5920@pclin040.win.tue.nl>; from aebr@win.tue.nl on Fri, Jan 07, 2005 at 03:00:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 03:00:35PM +0100, Andries Brouwer wrote:
> On Fri, Jan 07, 2005 at 12:39:47PM +0000, Russell King wrote:
> > Can anyone comment on the purpose of this (GENHD_FL_REMOVABLE) flag?
> > Al?  Jens?
> 
> GENHD_FL_REMOVABLE is set by a number of drivers (floppy, CDROM, ...).
> It is used in two places:
> (1) to fill the file /sys/block/*/removable
> (2) in genhd to suppress listing a nonpartitioned removable device
> in /proc/partitions.
> 
> In other words, it is for user space only, precisely as Pierre Ossman said.

Your point 2 isn't user space though.

Also, it's buggy.  Consider a SCSI PCMCIA card with SCSI disks attached.
When you eject that card, your SCSI disks disappear, yet they aren't
marked as removable.  If user space is relying on /sys/block/*/removable
to tell it if things may go away, then user space is buggy.

Maybe it's for devices which may be present (eg, floppy driver), but
which have removable media (eg, floppy disk), rather than removable
devices?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVGYMcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGYMcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 08:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGYMcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 08:32:25 -0400
Received: from thunk.org ([69.25.196.29]:47042 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261155AbVGYMcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 08:32:23 -0400
Date: Mon, 25 Jul 2005 08:32:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Amit S. Kale" <amitkale@linsyssoft.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Message-ID: <20050725123204.GB7925@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Amit S. Kale" <amitkale@linsyssoft.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200507231130.07208.amitkale@linsyssoft.com> <20050724142352.GB1778@elf.ucw.cz> <Pine.LNX.4.61.0507241713210.11580@yvahk01.tjqt.qr> <200507251124.43898.amitkale@linsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507251124.43898.amitkale@linsyssoft.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 11:24:43AM +0530, Amit S. Kale wrote:
> On Sunday 24 Jul 2005 8:44 pm, Jan Engelhardt wrote:
> > >Maybe you want to put your development machines on ext*2* while doing
> > >this ;-). Or perhaps reiserfs/xfs/something.
> >
> > Or perhaps into at the VFS level, so any fs can benefit from it.
> 
> We thought about that. While it's possible to do that, it would need
> hooks into all filesystems etc. Definitely worth trying once we get
> some more basic stuff working for ext3
> 
> After all the things that need to be saved at the time of taking a
> checkpoint for any filesystem would be the superblock and inode
> table (or their equivalents). Everything else is automatically taken
> care of.

You are aware of the block-device-level snapshot solutions, right?
They can be more painful to use, although that's mostly a UI issue,
and they have the added advantage that you can safely run e2fsck on
the snapshot image if you want to check the consistency of the
filesystem while it is mounted.  (If it is clean, you can then use
tune2fs to reset the max-mount-count and last-checked-time on the
original filesystem image; if it is not clean, you can send e-mail to
the system administrator suggesting that she schedule downtime ASAP
and do a e2fsck on the filesystem image.  This is a good thing that a
paranoid sysadmin might schedule via cron every Saturday morning at
3am, for example.)

							- Ted

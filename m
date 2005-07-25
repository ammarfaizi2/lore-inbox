Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVGYMxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVGYMxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVGYMxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 08:53:13 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:59021 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S261160AbVGYMxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 08:53:11 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Date: Mon, 25 Jul 2005 18:22:58 +0530
User-Agent: KMail/1.7
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200507231130.07208.amitkale@linsyssoft.com> <200507251124.43898.amitkale@linsyssoft.com> <20050725123204.GB7925@thunk.org>
In-Reply-To: <20050725123204.GB7925@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507251822.59114.amitkale@linsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 Jul 2005 6:02 pm, Theodore Ts'o wrote:
> On Mon, Jul 25, 2005 at 11:24:43AM +0530, Amit S. Kale wrote:
> > On Sunday 24 Jul 2005 8:44 pm, Jan Engelhardt wrote:
> > > >Maybe you want to put your development machines on ext*2* while doing
> > > >this ;-). Or perhaps reiserfs/xfs/something.
> > >
> > > Or perhaps into at the VFS level, so any fs can benefit from it.
> >
> > We thought about that. While it's possible to do that, it would need
> > hooks into all filesystems etc. Definitely worth trying once we get
> > some more basic stuff working for ext3
> >
> > After all the things that need to be saved at the time of taking a
> > checkpoint for any filesystem would be the superblock and inode
> > table (or their equivalents). Everything else is automatically taken
> > care of.
>
> You are aware of the block-device-level snapshot solutions, right?
> They can be more painful to use, although that's mostly a UI issue,
> and they have the added advantage that you can safely run e2fsck on
> the snapshot image if you want to check the consistency of the
> filesystem while it is mounted.

That would be a lesser advantage IMHO compared to the advantage of being able 
to manage disks in a better way.

Block-device level snapshots are simple to implement, though making them 
intelligent is quite difficult. Block device level snapshots can't detect 
which block are allocated and which are not (unless they look into a 
filesystem's block allocation map, which requires a device->fs interface). A 
snapshot may hence require an exhorbitant amount of space when it's not 
really needed.

The BLIB procedure to be used with checkfs is to create a checkpoint. Transfer 
it to disk as the first full backup. This operation uses the free space 
available within the filesystem till the time the data is transfered to a 
tape. A similar procedure used with block-level backup will require an 
auxilliary device.

Generally filesystem level snapshots/checkpoints can be more intelligent hence 
easier to use and requires fewer resources.

-Amit

> (If it is clean, you can then use 
> tune2fs to reset the max-mount-count and last-checked-time on the
> original filesystem image; if it is not clean, you can send e-mail to
> the system administrator suggesting that she schedule downtime ASAP
> and do a e2fsck on the filesystem image.  This is a good thing that a
> paranoid sysadmin might schedule via cron every Saturday morning at
> 3am, for example.)

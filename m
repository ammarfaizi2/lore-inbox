Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTJSSxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTJSSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:53:18 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:7301
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262040AbTJSSxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:53:17 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Mounting /dev/md0 as root in 2.6.0-test7 
Message-Id: <E1ABIg9-0003s2-00@penngrove.fdns.net>
Date: Sun, 19 Oct 2003 11:53:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > First, is it possible to mount an md device as root (superblock is
    > present)?

Yes, software RAID5 works for me on a PPC with 2.6.0-test7 (aside from other
video problems which make it hard for me to test adequately).  There is a
HOW-TO which explains how to do this (you want the >= 0.9 version, not the
0.4 version which is not relevant for modern kernels).

    > If so, I can't get it to work :(
    > I pass root=/dev/md0 to the kernl, but I get the "Kernel panic: VFS:
    > Unable to mount root fs on md0" error.

The basic problem here is that the kernel has no idea what disks comprise
your RAID when you just say "root=/dev/md0", e.g., it has no idea where to
start.  Here's an extract from my PPC's .config file:

    CONFIG_CMDLINE="root=/dev/md0 md=0,/dev/sda7,/dev/sdb7,/dev/sdc7"

Something like that could also be in /etc/lilo.conf if you use LILO (which
a PowerPC does not).

Thus the kernel has three disk to look at, to find out which partitions
make up /dev/md0.  Since i want the machine to work no matter which of my
three disk might fail, i have arranged my disks to have the root partition 
on the same partition number on each drive (even though they're not the 
same capacity or even organized in the same way otherwise).  If /dev/sda 
and /dev/sdb differ too much, then if /dev/sda fails sufficiently badly, 
then the drives get 'renumbered' (e.g. what was /dev/sdb because /dev/sda, 
/dev/sdc becomes /dev/sdb, etc.).

Write privately if you want to discuss this further (albeit i am hardly an
expert on this), as this mailing list is about maintaining the kernel rather
than about helping people get started with new configurations.  Yes, it can
work, and if it does with one recent kernel, but not another, then that's a
good hint that this may be an appropriate place to post (assuming a search 
of the archives doesn't already contain alot of discussion on your topic).
Good luck!
			         -- JM

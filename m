Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131494AbRCNSMI>; Wed, 14 Mar 2001 13:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCNSL7>; Wed, 14 Mar 2001 13:11:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48617 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131474AbRCNSLr>;
	Wed, 14 Mar 2001 13:11:47 -0500
Date: Wed, 14 Mar 2001 13:11:05 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103141726.f2EHQoj09856@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103141254000.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Andreas Dilger wrote:

> The AIX vgimport will not corrupt /etc/fstab with duplicate mounts, nor for
> that matter with duplicate LV names (AIX has a single namespace for all LVs).
> If a conflict is found with an LV name, a new name like "lv01" is used (the
> LV names are not that important anyways).  I'm not sure what would
> happen with a duplicate mount point (whether it would pick a new name, or
> simply leave it out of /etc/fstab), but it isn't too hard to think of
> easy ways to fix this (e.g. /home01 or /mnt/vgname/home or whatever).

[snip the rest of description]

Excuse me, but doesn't it scream "userland"? IOW, is there any reason to
do that in the kernel? If you want to spread /etc/fstab all over the
place storing bits in relevant filesystems - fine, you even don't
need to bother with superblocks. Just teach mount(8) to put the
mountpoint into /.last.mounted and be done with that...

	It's a policy question - if somebody wants to play with such
schemes he can do it in the place where policy stuff belongs.
I.e. in userland. Since the reading side contains a bunch of heuristics
(obviously depending on the local naming policy for temp. mountpoints,
for one thing) you don't need anything special on the writing side...

							Cheers,
								Al



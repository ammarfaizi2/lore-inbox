Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSGBWs7>; Tue, 2 Jul 2002 18:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSGBWs6>; Tue, 2 Jul 2002 18:48:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1966 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313867AbSGBWs6>;
	Tue, 2 Jul 2002 18:48:58 -0400
Date: Tue, 2 Jul 2002 18:51:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filter /proc/mounts based on process root dir
In-Reply-To: <E17PUOo-0003ol-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0207021848250.6472-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jul 2002, Paul Menage wrote:

> 
> This patch causes /proc/mounts to only display entries for mountpoints
> within the current process root. This makes df and friends behave more
> nicely in a chroot jail or with rootfs.
> 
> Most of the logic in proc_check_root() is moved to a new function,
> is_namespace_subdir(), which checks whether the given mount/dentry
> refers to a subdirectory of the process root directory in the current
> namespace. show_vfsmount() now returns without adding an output line if
> is_namespace_subdir() returns false for a given mountpoint.

That looks nice, but keep in mind that behaviour of getmntent(3) in chroot
jails is a traditional misfeature.  Hopefully nothing important relies on it,
but...

As far as I'm concerned patch (and behaviour change) are fine.  Let's do it
and see if anybody screams...


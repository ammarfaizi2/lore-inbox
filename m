Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTCVPZv>; Sat, 22 Mar 2003 10:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbTCVPZv>; Sat, 22 Mar 2003 10:25:51 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:34720 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S262038AbTCVPZu>; Sat, 22 Mar 2003 10:25:50 -0500
From: jordan.breeding@attbi.com
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: kpfleming@cox.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Date: Sat, 22 Mar 2003 15:36:48 +0000
X-Mailer: AT&T Message Center Version 1 (Nov  5 2002)
X-Authenticated-Sender: am9yZGFuLmJyZWVkaW5nQGF0dGJpLmNvbQ==
Message-Id: <20030322152550Z262038-25575+35093@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, 21 Mar 2003, Kevin P. Fleming wrote [lines rewrapped 
> to fit 80 columns]:
> >Adam J. Richter wrote:
> >
> >Are you still considering smalldevfs for 2.6 inclusion?
> 
> 	Yes.  Andrew Morton has been very supportive of it and
> just wants some more support for backward compatible names, perhaps
> something as simple as shipping devfs_helper with an optional tar file
> that could be unpacked in /dev as part of the boot process (along with
> some documentation on setting this up), or a sample /etc/devfs.conf
> for creating legacy names dynamically as needed.

  I would like the idea of a sample /etc/devfsd.conf much better for one reason, the whole point of devfs (at least to me) is to stop cluttering /dev with entries for devices which aren't even present, an /etc/devfsd.conf would still only create compatability file for nodes which are present, unless I am missing something an optional tar file would have to contain every possible compatible device name and would create the same mess which some distros have in /dev right now.  That said, I really like the idea of having compatible device names at least for a while so things like `cdrdao read-toc --device 2,4,0 toc_file` will stop complaining when the version of libscg it is using can't find a /dev/sg? device to play with.  Most boot time issues are easy to solve with smalldevfs, but it's the problems like cdrdao which are harder to solve, especially when the real problem is in a library it builds and uses and the library is at least fairly complex.

> 
> >If not, then
> >I'd like to discuss with you (and Greg KH) the possibility of just
> >eliminating devfs entirely, and moving to a userspace version that is
> >driven entirely by /sbin/hotplug.
> 
> 	Even though I expect small devfs to get into both 2.6 and 2.7,
> I would still be interested in discussing a userspace scheme.  When and
> if such a scheme became reasonably reliable working code, I might
> suppport removing devfs, depending on how it turned out.
> 
> >There are already adequate hotplug events generated in 2.5.65+
> 
> 	You need lookup events, so that you can, for example, load
> the floppy driver when the user looks up "/dev/floppy/0".
> 
> <some text cut to keep this short>
> 
> 	In fs/devfs, I split interface.c from fs.c for this reason.
> There is nothing specific to the devfs filesystem implemention in
> interface.c.  You could conceivably set devfs_vfsmnt to any valid
> vfsmnt, and device nodes would be created and deleted in that file
> system.  The only obstacle with doing that on a disk filesystem is the
> bootstrapping problem of mounting the filesystem in the first place.
> I can think of only three special properties that the ramfs variant
> in fs/defs/fs.c implements:
> 
> 	1. It calls /sbin/devfs_helper for certain events.
> 	2. It can be instantiated early.
> 	3. It implements a single instance filesystem, so that the
> 	   contents of devfs are remembered if you unmount devfs
> 	   and remount it somewhere else.
> 

  I would like to chime in on the issue of devfs (small or regular) versus doing everything in user-space.  It is nice that people are willing to try and shrink the kernel and get some things into user-space, but as long as Linux still has the possibility of build a completely monolithic, non-modular, no initramfs kernel I would like to see devfs hang around as an option for people who like /dev to only contain devices they have.  I for one always just build my kernels as monolithic and hate using initramfs (I think changing /etc/fstab and /boot/grub/grub.conf is much easier than also having to rebuild an initrd just to change what type of journaling ext3 is performing on /).  I am usually not a big believer in things _needing_ to stay in the kernel but I think that a case can be made that devfs should stay in the kernel so that people can have a choice of whether or not to use initramfs.  I think if we could have an in kernel version _and_ a userspace version and allow people to choose one or the other it would probably make the greatest number of people happy in the simplest way.  Anyway, just my two cents.

> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Jordan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285088AbRLUUFx>; Fri, 21 Dec 2001 15:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285089AbRLUUFn>; Fri, 21 Dec 2001 15:05:43 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:38583 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285088AbRLUUF0>; Fri, 21 Dec 2001 15:05:26 -0500
Date: Fri, 21 Dec 2001 13:05:23 -0700
Message-Id: <200112212005.fBLK5Nf15435@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Gregor Suhr <Gregor@Suhr.home.cs.tu-berlin.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: OOPS  at boot in 2.4.17-rc[12]  (kernel BUG at slab.c:815) maybe  devfs
In-Reply-To: <3C2392EC.6050306@Suhr.home.cs.tu-berlin.de>
In-Reply-To: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>
	<200112202338.fBKNcCI05673@vindaloo.ras.ucalgary.ca>
	<3C227F0E.E6A9CF76@zip.com.au>
	<3C23842A.20407@Suhr.home.cs.tu-berlin.de>
	<200112211926.fBLJQ7814544@vindaloo.ras.ucalgary.ca>
	<3C2392EC.6050306@Suhr.home.cs.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Suhr writes:
> Richard Gooch wrote:
> 
> >Gregor Suhr writes:
> >
> >>>>
> >>vgchange -- volume group "vg0" successfully activated
> >>
> >>kjournald starting.  Commit interval 5 seconds
> >>EXT3-fs: mounted filesystem with ordered data mode.
> >>VFS: Mounted root (ext3 filesystem) readonly.
> >>devfs: devfs_do_symlink(root): could not append to parent, err: -17
> >>change_root: old root has d_count=2
> >>kmem_cache_create: devfsd_event
> >>
> >
> >Now this is useful information! I see what's caused this: the second
> >mount of devfs (because you're using initrd) is creating the
> >devfsd_event slab cache again, which is a bug. I've appended a patch
> >which fixes this. Please test it out and let me know how it goes.
> >
> I will try the patch, but it seem to fit only on plain 2.4.17 and not on 
> my 2.4.17-rc2 (is it right??).

It will be fine on 2.4.17-rc2 as well. The patch is localised to
devfs, and there are no devfs changes between 2.4.17-rc2 and 2.4.17.

> >>Code: 0f 0b 5f 8b 13 5d 89 d3 8b 03 89 c2 0f 18 02 81 fb 08 dd 37
> >> <0>Kernel panic: Attempted to kill init!
> >>
> >
> >Where is the ksymoops decoding of this? It looks like you didn't run
> >ksymoops on each Oops trace.
> >
> It is the same trace as above (now in the last mail), but i thougt I is 
> better to append a part of the bootlog.
> As Andrew Morton pointed out the oops happens then devfs trys to create 
> an second slab cache.

Are you sure you mean "then devfs trys...", or perhaps you mean "when
devfs trys..."? If you actually mean "then", that implies that there
are two things trying to create a duplicate cache. One of them being
devfs (which is fixed in the patch I sent you), and the other is some
random driver. It would be good to know for sure.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285059AbRLUTUY>; Fri, 21 Dec 2001 14:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285007AbRLUTRl>; Fri, 21 Dec 2001 14:17:41 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27063 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285041AbRLUTQ1>; Fri, 21 Dec 2001 14:16:27 -0500
Date: Fri, 21 Dec 2001 12:16:24 -0700
Message-Id: <200112211916.fBLJGOu14312@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Gregor Suhr <Gregor@Suhr.home.cs.tu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS  at boot in 2.4.17-rc[12]  (kernel BUG at slab.c:815) maybe devfs
In-Reply-To: <3C23843A.3040904@Suhr.home.cs.tu-berlin.de>
In-Reply-To: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>
	<200112202338.fBKNcCI05673@vindaloo.ras.ucalgary.ca>
	<3C23843A.3040904@Suhr.home.cs.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Suhr writes:
>   Richard Gooch wrote:
> 
> >Gregor Suhr writes:
> >
> >>
> >>Trace; c0105000 <_stext+0/0>
> >>Trace; c010525e <init+e/140>
> >>Trace; c0105000 <_stext+0/0>
> >>Trace; c0105726 <kernel_thread+26/30>
> >>Trace; c0105250 <init+0/140>
> >>
> >
> >No mention of devfs in the traceback. It doesn't look like a devfs
> >problem. 
> >
> OK

However, on seeing your other message, I take that back. See my other
reply.

> >>mtab" and "/etc/devfs: devfs_register(mp3): could not append to parent, 
> >>err: -17
> >>lvmtab.d" succesdevfs: devfs_register(appdata): could not append to 
> >>parent, err: -17
> >>sfully created
> >>devfs: devfs_register(oracle): could not append to parent, err: -17
> >>
> >
> >These devfs-related messages are due to configuration problems
> >(i.e. boot scripts untarring a pile of crap into devfs), but they are
> >unlikely to be the cause of your Oops.
> >
> The linuxrc script  of the initrd include:
> 
>    #!/bin/sh
>    /bin/mount /proc
>    /sbin/vgscan
>    /sbin/vgchange -a y
>    /bin/umount /proc
> 
> But it is using a mountd devfs without runnig devfsd.
> I used this inird (without any change or rebuild) since 2.4 without any 
> problem, so something in the kernel must been changed.

Yes, something in the kernel has changed. New devfs core, which
doesn't work with broken drivers, and generates warning messages for
bad configurations. But those are warnings, and broken configurations
should continue to work (in 2.4, in 2.5 they won't). The problem you
are having is unrelated to a broken configuration. See other message.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

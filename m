Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284187AbRLASJ2>; Sat, 1 Dec 2001 13:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284188AbRLASJJ>; Sat, 1 Dec 2001 13:09:09 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:39101 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284186AbRLASIt>; Sat, 1 Dec 2001 13:08:49 -0500
Date: Sat, 1 Dec 2001 11:08:47 -0700
Message-Id: <200112011808.fB1I8lq31535@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de>
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@borntraeger.net writes:
> After upgrading from 2.4.16 to 2.4.17pre2 I got the following message in 
> dmesg:
> 
> .
> parport0: assign_addrs: aa5500ff(80)
> parport_pc: Via 686A parallel port: io=0x378
> devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
> lp0: using parport0 (polling).

Something other than drivers/char/lp.c is creating (implicitly or
explicitly) the "printers" directory in the devfs root dir. A
find+grep on the kernel sources does not reveal anything which would
do this. Either you are loading some other kernel module to which I
don't have the sources, or you have created /dev/printers from
user-space.

The new devfs core is less forgiving about these kinds of
bugs/misuses.

> devfs: devfs_register(nvidiactl): could not append to parent, err: -17
> devfs: devfs_register(nvidia0): could not append to parent, err: -17
>
> with 2.4.16 and before the message was:
> 
> devfs: devfs_register(): device already registered: "nvidia0"

Who knows what nvidia does? Talk to them. Could be a bug in their
driver where they create duplicate entries (the old devfs code would
often let you get away with this). Or again, perhaps something in
user-space is creating these entries.

> Why has this changed, and what is actually happen? My system runs
> fine.

You're lucky that the with way you use your system, it still works.

BTW: if it is something in user-space creating these entries (say some
vendor-provided boot script which populates devfs with "persistent"
entries), then I suggest you rip out whatever is doing it. Instead, if
you want permissions management, use devfsd-v1.3.20, which provides a
complete solution to this. The new sample devfsd.conf file shows you
how to configure devfsd to do this.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

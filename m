Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286472AbRLTXin>; Thu, 20 Dec 2001 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286471AbRLTXid>; Thu, 20 Dec 2001 18:38:33 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14261 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286478AbRLTXiS>; Thu, 20 Dec 2001 18:38:18 -0500
Date: Thu, 20 Dec 2001 16:38:12 -0700
Message-Id: <200112202338.fBKNcCI05673@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: gregor@suhr.home.cs.tu-berlin.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS  at boot in 2.4.17-rc[12]  (kernel BUG at slab.c:815) maybe devfs
In-Reply-To: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>
In-Reply-To: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Suhr writes:
> I tried to upgrade my system from 2.4.16 to 2.4.17-rc2 but I'am always 
> got the following OOPS:
> 
> kernel BUG at slab.c:815!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c012960a>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 0000001a   ebx: dfe38698   ecx: 00000001   edx: 00002a56
> esi: dfe38691   edi: c0324117   ebp: 00000000   esp: c181dee4
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=c181d000)
> Stack: c0316083 0000032f c181def4 dfe386b8 00000018 c180f368 c180f324 
> c180f324
>        c030c113 c03a7ad4 c032410a 0000001c 00000020 00000000 00000000 
> 00000000
>        c03a72f3 c0317020 00000002 00000000 00000000 dfe80e24 00003a00 
> 00000009
> Call Trace: [<c0118206>] [<c0118226>] [<c010522c>] [<c0105000>] [<c010525e>]
>    [<c0105000>] [<c0105726>] [<c0105250>]
> Code: 0f 0b 5f 8b 13 5d 89 d3 8b 03 89 c2 0f 18 02 81 fb c8 dc 37
> 
>  >>EIP; c012960a <kmem_cache_create+40a/470>   <=====
> Trace; c0118206 <sys_wait4+3a6/3b0>
> Trace; c0118226 <sys_waitpid+16/20>
> Trace; c010522c <prepare_namespace+11c/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c010525e <init+e/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105726 <kernel_thread+26/30>
> Trace; c0105250 <init+0/140>

No mention of devfs in the traceback. It doesn't look like a devfs
problem. 

> Before the kernel gives up i get the following error messages while 
> trying to find my LVM drives:
> 
> Mounted devfs on /dev
> modprobe: Can't open dependencies file 
> /lib/modules/2.4.17-rc2/modules.dep (No such file or directory)

You've got a problem with your modules configuration.

> devfs: devfs_mk_dir(vg0): using old entry in dir: c1808724 ""
> vgdevfs: devfs_register(group): could not append to parent, err: -17
> scan -- reading devfs: devfs_register(root): could not append to parent, 
> err: -17
> all physical voldevfs: devfs_register(tmp): could not append to parent, 
> err: -17
> umes (this may tdevfs: devfs_register(var): could not append to parent, 
> err: -17
> ake a while...)devfs: devfs_register(squid): could not append to parent, 
> err: -17
> 
> vgscan -- founddevfs: devfs_register(usr): could not append to parent, 
> err: -17
>  inactive volumedevfs: devfs_register(home): could not append to parent, 
> err: -17
>  group "vg0"
> vgdevfs: devfs_register(swap): could not append to parent, err: -17
> scan -- "/etc/lvdevfs: devfs_register(redhat): could not append to 
> parent, err: -17
> mtab" and "/etc/devfs: devfs_register(mp3): could not append to parent, 
> err: -17
> lvmtab.d" succesdevfs: devfs_register(appdata): could not append to 
> parent, err: -17
> sfully created
> devfs: devfs_register(oracle): could not append to parent, err: -17

These devfs-related messages are due to configuration problems
(i.e. boot scripts untarring a pile of crap into devfs), but they are
unlikely to be the cause of your Oops.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

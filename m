Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSJTRZj>; Sun, 20 Oct 2002 13:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSJTRZj>; Sun, 20 Oct 2002 13:25:39 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55255 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S263291AbSJTRZi>;
	Sun, 20 Oct 2002 13:25:38 -0400
Date: Sun, 20 Oct 2002 19:31:42 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Subject: nfsd/sunrpc boot on reboot in 2.5.44
Message-ID: <20021020173142.GA26384@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Debian sid machine oopses when I run 'sudo reboot'.

$ mount
/dev/hdb2 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hdb4 on /mnt type ext2 (rw,errors=remount-ro)
nodev on /dev/oprofile type oprofilefs (rw)
/dev/hda1 on /images type ext2 (rw)

No NFS activity involved.

By the way, can anybody tell me how to convert this:
Oct 20 19:21:32 hubert kernel:  [<c8831060>] auth_domain_drop+0x50/0x60 [sunrpc]

To a line in auth_domain_drop()?

I'm looking if I can reproduce this.

Oct 20 13:15:28 hubert kernel: EXT2-fs warning (device ide0(3,68)): ext2_fill_super: mounting ext3 filesystem as ext2
Oct 20 13:15:28 hubert kernel: 
Oct 20 13:15:30 hubert kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Oct 20 13:15:49 hubert kernel: MTRR: setting reg 1
(I mount my /images kernel images partition: )
Oct 20 19:21:01 hubert kernel: EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
(I entered reboot: )
Oct 20 19:21:28 hubert kernel: MTRR: setting reg 1
Oct 20 19:21:32 hubert kernel: nfsd: last server has exited
Oct 20 19:21:32 hubert kernel: nfsd: unexporting all filesystems
Oct 20 19:21:32 hubert kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 20 19:21:32 hubert kernel:  printing eip:
Oct 20 19:21:32 hubert kernel: 00000000
Oct 20 19:21:32 hubert kernel: *pde = 00000000
Oct 20 19:21:32 hubert kernel: Oops: 0000
Oct 20 19:21:32 hubert kernel: soundcore nfsd lockd sunrpc exportfs  
Oct 20 19:21:32 hubert kernel: CPU:    0
Oct 20 19:21:32 hubert kernel: EIP:    0060:[<00000000>]    Not tainted
Oct 20 19:21:32 hubert kernel: EFLAGS: 00010202
Oct 20 19:21:32 hubert kernel: eax: c88388b8   ebx: 7fffffff   ecx: 00000001   edx: c7643280
Oct 20 19:21:32 hubert kernel: esi: c8839c3c   edi: 00000001   ebp: c78c6000   esp: c78c7f7c
Oct 20 19:21:32 hubert kernel: ds: 0068   es: 0068   ss: 0068
Oct 20 19:21:32 hubert kernel: Process nfsd (pid: 231, threadinfo=c78c6000 task=c12826c0)
Oct 20 19:21:32 hubert kernel: Stack: c8831060 c7643280 c88330dd c7643280 c8838800 c78c6000 c77281e0 c1327e00 
Oct 20 19:21:32 hubert kernel:        c88330f5 c8862c84 c8831acb c8838800 c8859fe0 c8862c40 00000042 00000001 
Oct 20 19:21:32 hubert kernel:        c885137c c8861280 c1327e00 000493e0 c78c6000 c8862520 c8862520 c12826c0 
Oct 20 19:21:32 hubert kernel: Call Trace:
Oct 20 19:21:32 hubert kernel:  [<c8831060>] auth_domain_drop+0x50/0x60 [sunrpc]
Oct 20 19:21:32 hubert kernel:  [<c88330dd>] cache_clean+0x16d/0x170 [sunrpc]
Oct 20 19:21:32 hubert kernel:  [<c8838800>] auth_domain_cache+0x0/0x60 [sunrpc]
Oct 20 19:21:32 hubert kernel:  [<c88330f5>] cache_flush+0x15/0x50 [sunrpc]
Oct 20 19:21:32 hubert kernel:  [<c8862c84>] hash_sem+0x0/0x1c [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c8831acb>] svcauth_unix_purge+0x1b/0x20 [sunrpc]
Oct 20 19:21:32 hubert kernel:  [<c8838800>] auth_domain_cache+0x0/0x60 [sunrpc]
Oct 20 19:21:32 hubert kernel:  [<c8859fe0>] nfsd_export_shutdown+0x70/0xe0 [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c8862c40>] svc_export_cache+0x0/0x44 [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c885137c>] nfsd+0x19c/0x1f0 [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c8861280>] .rodata.str1.32+0x80/0x1320 [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c8862520>] nfsd_list+0x0/0x8 [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c8862520>] nfsd_list+0x0/0x8 [nfsd]
Oct 20 19:21:32 hubert kernel:  [<c88511e0>] nfsd+0x0/0x1f0 [nfsd]
Oct 20 19:21:32 hubert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct 20 19:21:32 hubert kernel: 
Oct 20 19:21:32 hubert kernel: Code:  Bad EIP value.


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

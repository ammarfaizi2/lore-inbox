Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTCES70>; Wed, 5 Mar 2003 13:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTCES70>; Wed, 5 Mar 2003 13:59:26 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:19695 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267459AbTCES7X>; Wed, 5 Mar 2003 13:59:23 -0500
Date: Wed, 5 Mar 2003 19:09:54 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <32979.4.64.238.61.1046569101.squirrel@www.osdl.org>
Message-ID: <Pine.SOL.3.96.1030305185900.17585B-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Could you try to turn on debugging in the NTFS driver (compile option in
the menus), then once ntfs module is loaded (or otherwise anytime) as root
do:

echo -1 > /proc/sys/fs/ntfs-debug

Then mount and to the directory changes. Assuming that you get the bug
again could you send me the captured kernel log output? (Note there will
be massive amounts of output.)

The code looks ok and I can't reproduce here so it would be helpful to see
if there are any oddities on your partition. Just to make sure it is not
the compiler, could you do a "make fs/ntfs/inode.S" and send me that as
well?

Thanks,

	Anton

On Sat, 1 Mar 2003, Randy.Dunlap wrote:
> This is plain vanilla 2.5.63.
> 
> The NTFS filesystem is mounted and I tried to cd several levels
> deep into it...and voila.
> 
> Mar  1 13:35:29 midway kernel: SysRq : Changing Loglevel
> Mar  1 13:35:29 midway kernel: Loglevel set to 9
> Mar  1 13:35:44 midway kernel: Unable to handle kernel paging request at
> virtual address 0001029a
> Mar  1 13:35:44 midway kernel:  printing eip:
> Mar  1 13:35:44 midway kernel: c01f40f9
> Mar  1 13:35:44 midway kernel: *pde = 00000000
> Mar  1 13:35:44 midway kernel: Oops: 0002
> Mar  1 13:35:44 midway kernel: CPU:    0
> Mar  1 13:35:44 midway kernel: EIP:    0060:[__ntfs_init_inode+169/400]    Not
> tainted
> Mar  1 13:35:44 midway kernel: EIP:    0060:[<c01f40f9>]    Not tainted
> Mar  1 13:35:44 midway kernel: EFLAGS: 00010282
> Mar  1 13:35:44 midway kernel: EIP is at __ntfs_init_inode+0xa9/0x190
> Mar  1 13:35:44 midway kernel: eax: f6c0f080   ebx: 0000416d   ecx: 00010282  
> edx: f6c0f0f8
> Mar  1 13:35:44 midway kernel: esi: c040b078   edi: f6c0f0f8   ebp: f6dd1dbc  
> esp: f6dd1db4
> Mar  1 13:35:44 midway su(pam_unix)[1839]: session closed for user root
> Mar  1 13:35:44 midway kernel: ds: 007b   es: 007b   ss: 0068
> Mar  1 13:35:44 midway kernel: Process bash (pid: 1840, threadinfo=f6dd0000
> task=f7fa4100)
> Mar  1 13:35:44 midway kernel: Stack: 00000000 f77dedec f6dd1df8 c01f4350
> f7854000 f6c0f080 c01409f2 f7db7c74
> Mar  1 13:35:44 midway kernel:        f6c1de00 00000000 0000416d 000e0000
> f77dedec f77dedec f6c0f178 00000000
> Mar  1 13:35:44 midway kernel:        f77dedec f6dd1e1c c01f3ec1 f6c0f178
> 0000416d 00000000 00000000 00000000
> Mar  1 13:35:44 midway kernel: Call Trace:
> Mar  1 13:35:44 midway kernel:  [ntfs_read_locked_inode+96/3344]
> ntfs_read_locked_inode+0x60/0xd10
> Mar  1 13:35:44 midway kernel:  [<c01f4350>] ntfs_read_locked_inode+0x60/0xd10
> Mar  1 13:35:44 midway kernel:  [kmem_cache_free+418/496]
> kmem_cache_free+0x1a2/0x1f0
> Mar  1 13:35:44 midway kernel:  [<c01409f2>] kmem_cache_free+0x1a2/0x1f0
> Mar  1 13:35:44 midway kernel:  [ntfs_iget+97/144] ntfs_iget+0x61/0x90
> Mar  1 13:35:44 midway kernel:  [<c01f3ec1>] ntfs_iget+0x61/0x90
> Mar  1 13:35:44 midway kernel:  [ntfs_lookup+158/1040] ntfs_lookup+0x9e/0x410
> Mar  1 13:35:44 midway kernel:  [<c01f6c3e>] ntfs_lookup+0x9e/0x410
> Mar  1 13:35:44 midway kernel:  [d_alloc+22/720] d_alloc+0x16/0x2d0
> Mar  1 13:35:44 midway kernel:  [<c0172c26>] d_alloc+0x16/0x2d0
> Mar  1 13:35:44 midway kernel:  [real_lookup+104/224] real_lookup+0x68/0xe0
> Mar  1 13:35:44 midway kernel:  [<c0168618>] real_lookup+0x68/0xe0
> Mar  1 13:35:44 midway kernel:  [do_lookup+78/144] do_lookup+0x4e/0x90
> Mar  1 13:35:44 midway kernel:  [<c0168d0e>] do_lookup+0x4e/0x90
> Mar  1 13:35:44 midway kernel:  [link_path_walk+2234/2928]
> link_path_walk+0x8ba/0xb70
> Mar  1 13:35:44 midway kernel:  [<c016960a>] link_path_walk+0x8ba/0xb70
> Mar  1 13:35:44 midway kernel:  [getname+99/176] getname+0x63/0xb0
> Mar  1 13:35:44 midway kernel:  [<c0168033>] getname+0x63/0xb0
> Mar  1 13:35:44 midway kernel:  [__user_walk+43/80] __user_walk+0x2b/0x50
> Mar  1 13:35:44 midway kernel:  [<c0169c5b>] __user_walk+0x2b/0x50
> Mar  1 13:35:44 midway kernel:  [vfs_stat+26/80] vfs_stat+0x1a/0x50
> Mar  1 13:35:44 midway kernel:  [<c0163ffa>] vfs_stat+0x1a/0x50
> Mar  1 13:35:44 midway kernel:  [sys_stat64+20/48] sys_stat64+0x14/0x30
> Mar  1 13:35:44 midway kernel:  [<c0164594>] sys_stat64+0x14/0x30
> Mar  1 13:35:44 midway kernel:  [grab_super+352/944] grab_super+0x160/0x3b0
> Mar  1 13:35:44 midway kernel:  [<c0160000>] grab_super+0x160/0x3b0
> Mar  1 13:35:44 midway kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Mar  1 13:35:44 midway kernel:  [<c0109a8b>] syscall_call+0x7/0xb
> Mar  1 13:35:44 midway kernel:
> Mar  1 13:35:44 midway kernel: Code: 89 51 18 89 51 1c 31 f6 31 c9 89 b0 80 00
> 00 00 31 f6 31 d2
> 
> ~Randy

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


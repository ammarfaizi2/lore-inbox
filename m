Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRFFJDN>; Wed, 6 Jun 2001 05:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbRFFJDD>; Wed, 6 Jun 2001 05:03:03 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:12292 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261173AbRFFJCq>;
	Wed, 6 Jun 2001 05:02:46 -0400
Message-ID: <20010605230526.A11485@bug.ucw.cz>
Date: Tue, 5 Jun 2001 23:05:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: NFS-related oops in 2.4.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got this while compiling kernel over NFS.

pavel@bug:/usr/src/linux-acpi$ time make bzImage
gcc -D__KERNEL__ -I/elf/big/linux-acpi/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i386  -DUTS_MACHINE='"i386"'
-c -o init/version.o init/version.c
gcc: Internal compiler error: program cpp got fatal signal 11
make: *** [init/version.o] Error 1
0.46user 0.23system 6.09 (0m6.092s) elapsed 11.32%CPU
pavel@bug:/usr/src/linux-acpi$

And signal 11 was because:

Jun  5 23:00:48 bug kernel: kernel BUG at inode.c:486!
Jun  5 23:00:48 bug kernel: invalid operand: 0000
Jun  5 23:00:48 bug kernel: CPU:    0
Jun  5 23:00:49 bug kernel: EIP:    0010:[clear_inode+51/244]
Jun  5 23:00:49 bug kernel: EFLAGS: 00010286
Jun  5 23:00:49 bug kernel: eax: 0000001b   ebx: c3c3f480   ecx:
c231e000   edx: c2f998a0
Jun  5 23:00:49 bug kernel: esi: c0304880   edi: c36a0f90   ebp:
c231ff84   esp: c231feb8
Jun  5 23:00:49 bug kernel: ds: 0018   es: 0018   ss: 0018
Jun  5 23:00:49 bug kernel: Process cpp (pid: 8457,
stackpage=c231f000)
Jun  5 23:00:49 bug kernel: Stack: c029b986 c029b9c5 000001e6 c3c3f480
c0140a37 c3c3f480 c13f6c80 c3c3f480
Jun  5 23:00:49 bug kernel:        c016c969 c3c3f480 c013e646 c13f6c80
c3c3f480 c13f6c80 00000000 c0136ed9
Jun  5 23:00:49 bug kernel:        c13f6c80 c231ff34 c0137619 c36a0f90
c231ff34 00000000 c3285000 00000000
Jun  5 23:00:49 bug kernel: Call Trace: [iput+327/348]
[nfs_dentry_iput+33/40] [dput+214/324] [cached_lookup+69/80]
[path_walk+1317/1916] [open_namei+115/1392] [nfs_file_release+28/36]
Jun  5 23:00:49 bug kernel:        [dput+81/324] [filp_open+46/76]
[sys_open+53/184] [system_call+51/56]
Jun  5 23:00:49 bug kernel:
Jun  5 23:00:49 bug kernel: Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10
75 19 68 e8 01 00 00 68

Retrying compilation, I get exactly same oops.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

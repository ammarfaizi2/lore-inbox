Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280192AbRJaMib>; Wed, 31 Oct 2001 07:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRJaMiV>; Wed, 31 Oct 2001 07:38:21 -0500
Received: from cauchy.eii.us.es ([150.214.141.179]:14976 "HELO
	cauchy.eii.us.es") by vger.kernel.org with SMTP id <S278450AbRJaMiO>;
	Wed, 31 Oct 2001 07:38:14 -0500
Date: Wed, 31 Oct 2001 13:38:30 +0100 (CET)
From: Manuel Cepedello Boiso <manuel@cauchy.eii.us.es>
To: <linux-kernel@vger.kernel.org>
Subject: Oops when unmounting a floppy (linux 2.4.13)
Message-ID: <Pine.LNX.4.33L2.0110311334210.902-100000@cauchy.eii.us.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've found a kernel oops when I tried to unmount a floppy under Linux
2.4.13. The disquette has an HFS filesystem (Macintosh) and the support
for the floppy was compiled as module.

The kernel log is the following:

Oct 31 12:59:43 cauchy kernel: inserting floppy driver for 2.4.13
Oct 31 12:59:43 cauchy kernel: Floppy drive(s): fd0 is 1.44M
Oct 31 12:59:43 cauchy kernel: FDC 0 is a post-1991 82077
Oct 31 12:59:43 cauchy kernel: VFS: Disk change detected on device fd(2,0)
Oct 31 13:01:34 cauchy kernel: kernel BUG at buffer.c:673!
Oct 31 13:01:34 cauchy kernel: invalid operand: 0000
Oct 31 13:01:34 cauchy kernel: CPU:    0
Oct 31 13:01:34 cauchy kernel: EIP:    0010:[invalidate_bdev+157/312]
Tainted: PF
Oct 31 13:01:34 cauchy kernel: EFLAGS: 00010282
Oct 31 13:01:34 cauchy kernel: eax: 0000001c   ebx: cd7025c0   ecx:
c01fe6a0   edx: 000028d7
Oct 31 13:01:34 cauchy kernel: esi: 00000001   edi: c0a295c0   ebp:
00000000   esp: cf561ef8
Oct 31 13:01:34 cauchy kernel: ds: 0018   es: 0018   ss: 0018
Oct 31 13:01:34 cauchy kernel: Process umount (pid: 2436,
stackpage=cf561000)
Oct 31 13:01:34 cauchy kernel: Stack: c01d48bc 000002a1 c194a1e0 c300b860
00000000 d4dd9244 02000000 00000000
Oct 31 13:01:34 cauchy kernel:        00000000 c0131b59 c194a1e0 00000001
c194a1e0 c013263a c194a1e0 d4dd9200
Oct 31 13:01:34 cauchy kernel:        c194a1e0 00000200 c0131816 c194a1e0
00000002 c180e460 d4dd9200 cf561f98
Oct 31 13:01:34 cauchy kernel: Call Trace: [kill_bdev+13/40]
[blkdev_put+78/144] [kill_super+250/316] [<e0995520>] [__mntput+30/36]
Oct 31 13:01:34 cauchy kernel:    [path_release+39/44]
[sys_umount+167/180] [sys_munmap+53/84] [sys_oldumount+12/16]
[system_call+51/56]
Oct 31 13:01:34 cauchy kernel:
Oct 31 13:01:34 cauchy kernel: Code: 0f 0b 83 c4 08 8d b6 00 00 00 00 f6
43 18 02 74 0d 68 c5 48



Manuel Cepedello


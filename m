Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271580AbRIBFx7>; Sun, 2 Sep 2001 01:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271581AbRIBFxu>; Sun, 2 Sep 2001 01:53:50 -0400
Received: from chmls20.mediaone.net ([24.147.1.156]:23184 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S271580AbRIBFxj>; Sun, 2 Sep 2001 01:53:39 -0400
Message-ID: <3B91C998.D669C94F@mediaone.net>
Date: Sun, 02 Sep 2001 01:54:32 -0400
From: Robert La Ferla <robertlaferla@mediaone.net>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serious system problems with 2.4.9 and 2.4.3 kernels
X-Priority: 2 (High)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: please personally CC me on replies...

I am experiencing serious problems with my system under both the
2.4.3-12 (RH 7.1) and 2.4.9 kernels.  I went back to the 2.4.3 kernel
and got some debugging information that should help pinpoint this
problem.  I'll try again with the 2.4.9 kernel as well but this should
get us started and will help me determine what to look for in the 2.4.9
kernel.

Problem:

Zombie processes.  I am doing very heavy network traffic through a
system running mysql 3.23.41 and iptables 1.2.2.  There is a single 36GB
partition for the database.  After running a custom app and mysql for
several minutes under 2.4.3, zombie processes start to appear (mysqld
for example.)  Under 2.4.9, the system gets into a state where I am
unable to run "ps" or "top" but am able to do a "ls -l" on /proc.

BTW - I ran memtest x86 for over three hours on my system (single pass)
so I don't think it's bad RAM.  However, these problems seem to have
started since I added extra RAM.  It's at it's max. capacity now.  As a
result, I think it's something in the Linux 2.4 VM.  BTW - I have only
392MB of swap but the processes never use more than the physical RAM so
I don't think this is a problem either.

Here's what "ps" reports:

mysql    10389  0.0  0.0     0    0 pts/0    Z    12:51   0:00
[mysqld<defunct>]

Here's the messages snippet which leads me to believe that it is a
kernel problem:

Sep  1 13:34:04 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000028
Sep  1 13:34:04 localhost kernel:  printing eip:
Sep  1 13:34:04 localhost kernel: c0145eea
Sep  1 13:34:04 localhost kernel: pgd entry eea69000: 0000000000000000
Sep  1 13:34:04 localhost kernel: pmd entry eea69000: 0000000000000000
Sep  1 13:34:04 localhost kernel: ... pmd not present!
Sep  1 13:34:04 localhost kernel: Oops: 0000
Sep  1 13:34:04 localhost kernel: CPU:    0
Sep  1 13:34:04 localhost kernel: EIP:    0010:[update_atime+10/80]
Sep  1 13:34:04 localhost kernel: EIP:    0010:[<c0145eea>]
Sep  1 13:34:04 localhost kernel: EFLAGS: 00010246
Sep  1 13:34:04 localhost kernel: eax: 00000000   ebx: 00000000   ecx:
e5c7c200   edx: e5c7c200
Sep  1 13:34:04 localhost kernel: esi: d8aedf8c   edi: 00000000   ebp:
00000000   esp: d8aedf04
Sep  1 13:34:04 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  1 13:34:04 localhost kernel: Process mysqld (pid: 10506,
stackpage=d8aed000)
Sep  1 13:34:04 localhost kernel: Stack: c0125a4f e5c7c200 00000000
00000002 00000001 00000000 00000000 e5c7c200
Sep  1 13:34:04 localhost kernel:        c01ca1d0 0000002c 00000001
0000001f d8aedf8c 00000000 00000000 482448d4
Sep  1 13:34:04 localhost kernel:        c0125b84 e7119960 d8aedf8c
d8aedf5c c0125a60 00000000 00000000 000000fc
Sep  1 13:34:04 localhost kernel: Call Trace:
[do_generic_file_read+1263/1280] [ip_rcv_finish+0/480] [generic_file_re
ad+100/128] [file_read_actor+0/192] [sys_pread+174/240]
Sep  1 13:34:04 localhost kernel: Call Trace: [<c0125a4f>] [<c01ca1d0>]
[<c0125b84>] [<c0125a60>] [<c01328ee>]
Sep  1 13:34:04 localhost kernel:    [do_softirq+91/128]
[do_IRQ+159/176] [system_call+51/56]
Sep  1 13:34:04 localhost kernel:    [<c01197eb>] [<c010824f>]
[<c0106d2b>]
Sep  1 13:34:04 localhost kernel:
Sep  1 13:34:04 localhost kernel: Code: 8b 50 28 f7 c2 00 04 00 00 75
37
f6 81 fc 00 00 00 02 75 2e


System:

Dell XPS T 800 (800 MHz P3, Intel SE440BX-3 Dell/OEM motherboard, Bios
A11) with 768MB RAM, Intel Pro 100 dual port ethernet, Adaptec 29160N
(Bios 3.10.0) SCSI controller, and Seagate 18GB + 36GB Cheetah SCSI
drives.

OS:

Linux localhost 2.4.3-12 #1 Fri Jun 8 15:05:56 EDT 2001 i686 unknown









Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTI1LHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 07:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTI1LHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 07:07:10 -0400
Received: from e39087.upc-e.chello.nl ([213.93.39.87]:33804 "EHLO
	hackaholic.org") by vger.kernel.org with ESMTP id S262409AbTI1LHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 07:07:00 -0400
Message-ID: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>
Date: Sun, 28 Sep 2003 13:04:33 +0200 (CEST)
Subject: PROBLEM: kernel 2.6-test5 rmmod: kernel NULL pointer dereference
From: "detach" <detach@hackaholic.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope I'm using the right method to reporting this problem, I'll send it
to the mailing list as this problem seems to be an overall kernel problem.
No flames please :).
Here's what happened,
I wrote a CD so I did a modprobe ide-scsi .. then wrote the CD, now I
wanted to check the contents of the CD, so i did rmmod ide-scsi first so
that i could load ide-cd. Well, rmmod hung, and I checked /proc/kern.log
on debian woody (with custom compiled linux 2.6-test5).Here's the output in /proc/kern.log:

Sep 28 12:49:32 debian kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000024Sep 28 12:49:32 debian kernel:  printing eip:
Sep 28 12:49:32 debian kernel: c0176546
Sep 28 12:49:32 debian kernel: *pde = 00000000
Sep 28 12:49:32 debian kernel: Oops: 0002 [#1]
Sep 28 12:49:32 debian kernel: CPU:    0
Sep 28 12:49:32 debian kernel: EIP:    0060:[<c0176546>]    Not tainted
Sep 28 12:49:32 debian kernel: EFLAGS: 00010202
Sep 28 12:49:32 debian kernel: EIP is at simple_rmdir+0x26/0x50
Sep 28 12:49:32 debian kernel: eax: 00000000   ebx: c2cb1480   ecx:
c2cb149c   edx: ffffffd9Sep 28 12:49:32 debian kernel: esi: cde97540   edi: c2cb10c0   ebp:
c542beac   esp: c542be9cSep 28 12:49:32 debian kernel: ds: 007b   es: 007b   ss: 0068
Sep 28 12:49:32 debian kernel: Process rmmod (pid: 2282,
threadinfo=c542a000 task=cbb6a650)Sep 28 12:49:32 debian kernel: Stack: c2cb1480 ca5e0c80 cde975a8 cde97540
c542becc c018bf9e cde97540 c2cb1480Sep 28 12:49:32 debian kernel:        c2cb1480 c2cb1600 c542a000 c2cb1480
c542beec c018c092 c2cb1480 c2cb1600Sep 28 12:49:32 debian kernel:        c2cb149c ce60c8c4 c03e9b68 cf8adec0
c542bf04 c021b223 ce60c8c4 c03e9b20Sep 28 12:49:32 debian kernel: Call Trace:
Sep 28 12:49:32 debian kernel:  [<c018bf9e>] remove_dir+0x6e/0x90
Sep 28 12:49:32 debian kernel:  [<c018c092>] sysfs_remove_dir+0xc2/0x130
Sep 28 12:49:32 debian kernel:  [<c021b223>] kobject_del+0x43/0x70
Sep 28 12:49:32 debian kernel:  [<c0274291>] device_del+0x81/0xb0
Sep 28 12:49:32 debian kernel:  [<cf8ac049>] idescsi_cleanup+0x49/0x60
[ide_scsi]Sep 28 12:49:32 debian kernel:  [<c0295944>] ide_unregister_driver+0x74/0xcb
Sep 28 12:49:32 debian kernel:  [<cf8acb7a>] exit_idescsi_module+0x2a/0x2c
[ide_scsi]Sep 28 12:49:32 debian kernel:  [<c013582f>] sys_delete_module+0x12f/0x150
Sep 28 12:49:32 debian kernel:  [<c014ae67>] sys_munmap+0x57/0x80
Sep 28 12:49:32 debian kernel:  [<c010a32f>] syscall_call+0x7/0xb
Sep 28 12:49:32 debian kernel:
Sep 28 12:49:32 debian kernel: Code: ff 48 24 89 34 24 89 5c 24 04 e8 ab
ff ff ff 31 d2 ff 4e 24
A uname -a:

Linux debian 2.6.0-test5 #6 Wed Sep 24 23:03:29 CEST 2003 i686 GNU/Linux

/proc/cpuinfo:


processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : mobile AMD Athlon(tm) XP 1800+
stepping        : 0
cpu MHz         : 1500.770
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnowbogomips        : 2957.31

/proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1100-110f : 0000:00:11.1
  1100-1107 : ide0
  1108-110f : ide1
1200-121f : 0000:00:11.2
  1200-121f : uhci-hcd
c000-dfff : PCI Bus #01
e000-e0ff : 0000:00:11.5
  e000-e0ff : via82cxxx_audio
e100-e103 : 0000:00:11.5
  e100-e103 : via82cxxx_audio
e104-e107 : 0000:00:11.5
  e104-e107 : via82cxxx_audio
e200-e2ff : 0000:00:11.6
e800-e8ff : 0000:00:12.0
  e800-e8ff : via-rhine

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0efeffff : System RAM
  00100000-0034ae73 : Kernel code
  0034ae74-0042e13f : Kernel data
0eff0000-0effffbf : ACPI Tables
0effffc0-0effffff : ACPI Non-volatile Storage
10000000-10000fff : 0000:00:0a.0
90000000-9fffffff : PCI Bus #01
  90000000-97ffffff : 0000:01:00.0
a0000000-a3ffffff : 0000:00:00.0
e0000000-efffffff : PCI Bus #01
  e0000000-e007ffff : 0000:01:00.0
f0000000-f00000ff : 0000:00:12.0
  f0000000-f00000ff : via-rhine
fff80000-ffffffff : reserved

I hope this is enough information..
Ohyeah, a killall -9 rmmod doesn't work..
I tried to do 'cat /proc/modules',
but this command hangs too.. it looks like the whole module system crashed..

If I reported this problem to the wrong address, please forgive me. If you
need any more information, just ask.
Rob.

-- 
]- detach \
]- The Hackaholic <http://hackaholic.org/> \
]- PGP KEY ID; 0X80FD4B50



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTLTQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 11:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbTLTQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 11:28:07 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:5308 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264917AbTLTQ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 11:28:01 -0500
Date: Sat, 20 Dec 2003 08:27:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1712] New: kswapd causes oops 
Message-ID: <53700000.1071937671@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1712

           Summary: kswapd causes oops
    Kernel Version: 2.6.0-test11
            Status: NEW
          Severity: normal
             Owner: other_other@kernel-bugs.osdl.org
         Submitter: daniel.schreiber@s1999.tu-chemnitz.de


Distribution: Debian/Woody with backports 
Hardware Environment: 
CPU: 
model name      : AMD Duron(tm) Processor 
stepping        : 1 
cpu MHz         : 1194.943 
 
lspci: 
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01) 
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP 
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 
PCI Audio Accelerator (rev a0) 
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 90) 
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02) 
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02) 
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02) 
00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22) 
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
a1) 
 
# fdisk -l /dev/hda 
 
Disk /dev/hda: 255 heads, 63 sectors, 9729 cylinders 
Units = cylinders of 16065 * 512 bytes 
 
   Device Boot    Start       End    Blocks   Id  System 
/dev/hda1             1        13    102784+  83  Linux 
Partition 1 does not end on cylinder boundary: 
     phys=(203, 15, 63) should be (203, 254, 63) 
/dev/hda2            13       141   1024128   83  Linux 
Partition 2 does not end on cylinder boundary: 
     phys=(1023, 15, 63) should be (1023, 254, 63) 
/dev/hda3           141      9730  77023800   8e  Linux LVM 
Partition 3 does not end on cylinder boundary: 
     phys=(1023, 15, 63) should be (1023, 254, 63) 
 
 
Software Environment:  
binutils            2.12.90.0.1-4 
e2fsprogs           1.34+1.35-WIP-2003 (backport) 
gcc                 2.95.4-14 
lvm2                2.00.07-1     (backport) 
module-init-tools   0.9.15-pre3-2 (backport) 
xawtv               3.90          (backport) 
xserver-xfree86     4.1.0-16woody1 
 
The System has a 2 GB swap volume on LVM.  
 
Problem Description: 
kswapd crashed.  
 
Dec 11 12:05:50 ws kernel: Unable to handle kernel paging request at virtual 
address 0ecf5408 
Dec 11 12:05:50 ws kernel:  printing eip: 
Dec 11 12:05:50 ws kernel: c0159602 
Dec 11 12:05:50 ws kernel: *pde = 00000000 
Dec 11 12:05:50 ws kernel: Oops: 0002 [#1] 
Dec 11 12:05:50 ws kernel: CPU:    0 
Dec 11 12:05:50 ws kernel: EIP:    0060:[<c0159602>]    Not tainted 
Dec 11 12:05:50 ws kernel: EFLAGS: 00010202 
Dec 11 12:05:50 ws kernel: EIP is at prune_icache+0x72/0x1b0 
Dec 11 12:05:50 ws kernel: eax: 0ecf5408   ebx: d1d5d170   ecx: 00000080   edx: 
c03012cc 
Dec 11 12:05:50 ws kernel: esi: d1d5d178   edi: 00000000   ebp: dfe47eac   esp: 
dfe47e8c 
Dec 11 12:05:50 ws kernel: ds: 007b   es: 007b   ss: 0068 
Dec 11 12:05:50 ws kernel: Process kswapd0 (pid: 9, threadinfo=dfe46000 
task=dfe5e6b0) 
Dec 11 12:05:50 ws kernel: Stack: 00000080 0000029a dfe46000 00000004 c03012d8 
00000004 df783cf8 df7834f8  
Dec 11 12:05:50 ws kernel:        00000000 c0159755 00000080 c0135e4c 00000080 
000000d0 000001b8 c02ffebc  
Dec 11 12:05:50 ws kernel:        ffffffdc 00000001 03ac65e0 00000000 c03004ec 
00012ed3 dfffeb20 c0136e68  
Dec 11 12:05:50 ws kernel: Call Trace: 
Dec 11 12:05:50 ws kernel:  [<c0159755>] shrink_icache_memory+0x15/0x20 
Dec 11 12:05:50 ws kernel:  [<c0135e4c>] shrink_slab+0x10c/0x170 
Dec 11 12:05:50 ws kernel:  [<c0136e68>] balance_pgdat+0x128/0x1d0 
Dec 11 12:05:50 ws kernel:  [<c0137014>] kswapd+0x104/0x110 
Dec 11 12:05:50 ws kernel:  [<c0136f10>] kswapd+0x0/0x110 
Dec 11 12:05:50 ws kernel:  [<c0117ba0>] autoremove_wake_function+0x0/0x40 
Dec 11 12:05:50 ws kernel:  [<c0117ba0>] autoremove_wake_function+0x0/0x40 
Dec 11 12:05:50 ws kernel:  [<c0106fad>] kernel_thread_helper+0x5/0x18 
Dec 11 12:05:50 ws kernel:  
Dec 11 12:05:50 ws kernel: Code: 89 10 a1 cc 12 30 c0 89 70 04 89 06 c7 46 04 
cc 12 30 c0 89  
 
 
Complete kernel.log at http://www-user.tu-chemnitz.de/~schrd/kernel.log 
 
Steps to reproduce:



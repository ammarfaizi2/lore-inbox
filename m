Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUBEGyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 01:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUBEGyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 01:54:19 -0500
Received: from [220.249.10.10] ([220.249.10.10]:49804 "EHLO
	mail.goldenhope.com.cn") by vger.kernel.org with ESMTP
	id S264233AbUBEGyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 01:54:09 -0500
Date: Thu, 5 Feb 2004 14:53:43 +0800
From: lepton <lepton@sina.com>
To: linux-kernel@vger.kernel.org
Subject: [bug] kernel 2.4.24+aic7xxx scsi+x86-64 oops
Message-ID: <20040205065342.GA7849@lepton.goldenhope.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.
	I have a smp AMD64 box with a adaptec 7892A scsi card, I want to
	run x86-64 kernel on it with a debian woody distribition .After 
	serveral hours work, I found something like this:

1. If I am using a 2.4.24 k7 kernel, everything is ok.
2. If I am using a 2.4.24 x86-64 kernel, system will panic when it
should init scsi devcice.
   It printed something like
   "CPU1 (swapd pid 1) ... panic"
( sorry for I have not a serial line at hand, so I cannot use the serial
console to capture the output now)

3. If I am using a 2.4.24 x86-64 kernel and without scsi support, system
will boot successful
4. If I am using a 2.4.22 x86-64 kernel, system will boot scucessful.
But I can't mount my partions in my scsi disk. mount report:
   No such directory

   dmesg shows:
   
Feb  4 13:43:20 lepton kernel: reiserfs: found format "3.6" with
standard journal
Feb  4 13:43:21 lepton kernel: reiserfs: checking transaction log
(device sd(8,1)) ...
Feb  4 13:43:21 lepton kernel: for (sd(8,1))
Feb  4 13:43:22 lepton kernel: is_tree_node: node level 0 does not
match to the expected one 1
Feb  4 13:43:22 lepton kernel: sd(8,1):vs-5150: search_by_key:
invalid format found in block 8211. Fsck?
Feb  4 13:43:22 lepton kernel: sd(8,1):vs-13070:
reiserfs_read_inode2: i/o failure occurred trying to find stat data
of [1 2 0x0 SD]
Feb  4 13:43:22 lepton kernel: sd(8,1):Using r5 hash to sort names
Feb  4 13:43:22 lepton kernel: is_tree_node: node level 0 does not
match to the expected one 1
Feb  4 13:43:22 lepton kernel: sd(8,1):vs-5150: search_by_key:
invalid format found in block 8211. Fsck?
Feb  4 13:43:22 lepton kernel: sd(8,1):vs-2140: finish_unfinished:
search_by_key returned -2a                                                                                                                       
    It seems the data read from scsi is corrupted?

5. If I am using  a 2.6.1 kernel with the aic7xxx driver (new),
everything is ok.

6. I have run a suse linux x86-64 distribition on this server serveral
months ago, I remember I have comile a linux 2.4.19 kernel on it and 
everyting is ok. But I can't confirm it if this kernel source is
patched by suse.

Because this server has been put in a IDC. I have no too many chances to
try other kernel...

Any idea about my problem?

The following is the output of lspci:

00:06.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7460
(rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7468
(rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7469
(rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD]: Unknown device 746a (rev
02)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 746b (rev
05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7450
(rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD]: Unknown device 7451 (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7450
(rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD]: Unknown device 7451 (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1100
00:18.1 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1101
00:18.2 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1102
00:18.3 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1103
00:19.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1100
00:19.1 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1101
00:19.2 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1102
00:19.3 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1103
01:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device
7464 (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD]: Unknown device
7464 (rev 0b)
01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:01.0 SCSI storage controller: Adaptec 7892A (rev 02)
02:03.0 Ethernet controller: BROADCOM Corporation: Unknown device 16a6
(rev 02)
02:04.0 Ethernet controller: BROADCOM Corporation: Unknown device 16a6
(rev 02)
02:05.0 RAID bus controller: Promise Technology, Inc.: Unknown device
3319 (rev 02)

The follwoing is the content of cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 8
cpu MHz         : 1804.120
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3547.13
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 8
cpu MHz         : 1804.120
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3137.53
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

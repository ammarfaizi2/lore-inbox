Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUF3UsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUF3UsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUF3UsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:48:13 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:35211 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262450AbUF3UsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:48:06 -0400
Message-ID: <40E0205A.8020508@cox.net>
Date: Mon, 28 Jun 2004 13:42:50 +0000
From: "Will S." <willgs00@cox.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040627)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SMP 2.6.7 with ECS P6LX2-A dual Pentium-II board -> TSC skew?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running Linux 2.6.7 on an ECS P6LX2-A motherboard, with a matched 
pair of Pentium II-333MHz CPUs. It seems that with kernels 2.6.x that 
the kernel detects a TSC skew of +- 6 usecs. Kernel 2.4.x shows the TSCs 
as being matched. With a 2.6.x kernel running, all the timers go bonkers 
every 15-60 seconds, and when they do, they count very fast or very slow 
for around a second. This quickly leads to system clock skew, and causes 
problems with many programs. With a 2.4.x kernel, the timers are perfect.

Any ideas on why this skew is being (mis)detected?

Some possibly relevant info:

from dmesg, kernel 2.6.7:
-------------------------------------------------------
Calibrating delay loop... 657.40 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium II (Deschutes) stepping 01
per-CPU timeslice cutoff: 1462.08 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 657.40 BogoMIPS
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 01
Total of 2 processors activated (1314.81 BogoMIPS).

[snip]

calibrating APIC timer ...
..... CPU clock speed is 334.0055 MHz.
..... host bus clock speed is 66.0811 MHz.
checking TSC synchronization across 2 CPUs:
BIOS BUG: CPU#0 improperly initialized, has -6 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 6 usecs TSC skew! FIXED.
-------------------------------------------------------

This board does have a buggy BIOS that doesn't seem to initialize the 
second CPU, as the MTRR settings for CPU1 generate complaints. But if 
2.4.x worked fine, why shouldn't 2.6.x also work fine? The CPUs are 
perfectly matched - the steppings are identical. I see no reason for the 
TSCs to be unsynced.

If you need any other info (kernel .config maybe?), just ask :-)

TIA.

-- Will S.
willgs00@cox.net

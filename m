Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUGSNOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUGSNOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUGSNOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:14:49 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:51473 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S265195AbUGSNOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:14:45 -0400
From: Erik Oomen <erik.oomen@ctc.nl>
Organization: ctc
To: linux-kernel@vger.kernel.org
Subject: Dell Inspiron with pentium-m dothan (APIC and cpufreq)
Date: Mon, 19 Jul 2004 15:14:23 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407191514.23367.erik.oomen@ctc.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This inspiron model does have a functional local APIC. By default the kernel 
refuses to enable the APIC, but when using the 'lapic' parameter it detects 
and uses the local APIC just fine, see 1) .  I guess 
arch/i386/kernel/dmi_scan.c should be updated, I'll try to make some 
adjustments and post the patches.

The cpufreq, using ACPI, displays duplicate entries for 1700Mhz (see 2).  
Futher more, on batteries the notebook runs at 600Mhz and I cannot switch it 
to 1700Mhz. /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor shows 
'performance' but the CPU is still running at 600Mhz. 

running kernel 2.6.8-rc2

1) dmesg snippet where local APIC is detected
Kernel command line: ro root=/dev/hda3 vga=791 elevator=cfq acpi_irq_balance 
lapic
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1694.927 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035044k/1048248k available (1887k kernel code, 12304k reserved, 838k 
data, 188k init, 130744k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3358.72 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  afe9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: After all inits, caps:        afe9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1694.0239 MHz.
..... host bus clock speed is 99.0661 MHz.

2) dmesg snippet for cpufreq
cpufreq: CPU0 - ACPI performance management activated.
cpufreq:  P0: 1700 MHz, 21000 mW, 250 uS
cpufreq:  P1: 1700 MHz, 21000 mW, 250 uS
cpufreq: *P2: 1700 MHz, 21000 mW, 250 uS
cpufreq:  P3: 1400 MHz, 17500 mW, 250 uS
cpufreq:  P4: 1200 MHz, 15000 mW, 250 uS
cpufreq:  P5: 1000 MHz, 12500 mW, 250 uS
cpufreq:  P6: 800 MHz, 10000 mW, 250 uS
cpufreq:  P7: 600 MHz, 7500 mW, 250 uS

Erik

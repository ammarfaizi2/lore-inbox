Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTE0Ped (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTE0Ped
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:34:33 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10684 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263847AbTE0Peb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:34:31 -0400
Date: Tue, 27 May 2003 08:47:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 749] New: Changing the CPU frequency using CPUFREQ hangs the kernel
Message-ID: <11950000.1054050457@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Changing the CPU frequency using CPUFREQ hangs the
                    kernel
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: harisri@bigpond.com


Distribution: Red Hat
Hardware Environment: Compaq EVO N1015v - AMD Athlon 1800+, 512 MB RAM, IDE
HDD/DVD etc..
Software Environment: 2.5.70, Gnc C 3.2.2, Linux C Library 2.3.2
Problem Description: Changing the CPU frequency hangs the kernel (except this
one time under X it just rebooted it :( )

Steps to reproduce:
Consider the following two shell scripts
1. powersave.sh
# !/bin/bash
echo 532000 > /sys/class/cpu/cpu0/cpufreq/scaling_max_freq
echo powersave > /sys/class/cpu/cpu0/cpufreq/scaling_governor

2. performance.sh
# !/bin/bash
echo 1529500 > /sys/class/cpu/cpu0/cpufreq/scaling_max_freq
echo performance > /sys/class/cpu/cpu0/cpufreq/scaling_governor

No problem while executing powersave.sh, but the kernel hangs after executing
performance.sh. No sysrq response. AFAIK cpufreq on this same machine worked
fine during 2.5.68 (although the sysfs cpufreq files were in a different
directory location back then).

Here is the /var/log/messages information relating to the Athlon 1800+:
May 28 19:57:57 laptop kernel: powernow: AMD K7 CPU detected.
May 28 19:57:57 laptop kernel: powernow: PowerNOW! Technology present. Can scale
: frequency and voltage.
May 28 19:57:57 laptop kernel: powernow: Found PSB header at c00f0800
May 28 19:57:57 laptop kernel: powernow: Table version: 0x12
May 28 19:57:57 laptop kernel: powernow: Flags: 0x0 (Mobile voltage regulator)
May 28 19:57:57 laptop kernel: powernow: Settling Time: 100 microseconds.
May 28 19:57:57 laptop kernel: powernow: Has 31 PST tables. (Only dumping ones r
elevant to this CPU).
May 28 19:57:57 laptop kernel: powernow: PST:24 (@c00f099e)
May 28 19:57:57 laptop kernel: powernow:  cpuid: 0x780^Ifsb: 133^ImaxFID: 0x1^Is
tartvid: 0x9
May 28 19:57:57 laptop kernel: powernow:    FID: 0x12 (4.0x [532MHz])^IVID: 0x13
 (1.200V)
May 28 19:57:57 laptop kernel: powernow:    FID: 0x4 (5.0x [665MHz])^IVID: 0x13
(1.200V)
May 28 19:57:57 laptop kernel: powernow:    FID: 0x6 (6.0x [798MHz])^IVID: 0x13
(1.200V)
May 28 19:57:57 laptop kernel: powernow:    FID: 0xc (9.0x [1197MHz])^IVID: 0xd
(1.350V)
May 28 19:57:57 laptop kernel: powernow:    FID: 0x1 (11.5x [1529MHz])^IVID: 0x9
 (1.550V)
May 28 19:57:57 laptop kernel:
May 28 19:57:57 laptop kernel: powernow: Minimum speed 532 MHz. Maximum speed 15
29 MHz.

My relavant .config section for CPUFREQ:
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_POWERNOW_K7=y

The 'lspci' output from the computer:
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M] (rev 01)
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller
(rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 20)
00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1

Thanks
Hari
harisri@bigpond.com



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTGTOkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGTOkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:40:20 -0400
Received: from p508EBE9D.dip.t-dialin.net ([80.142.190.157]:17559 "HELO
	neutronstar.dyndns.org") by vger.kernel.org with SMTP
	id S263737AbTGTOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:40:06 -0400
Date: Sun, 20 Jul 2003 17:02:43 +0200
From: textshell@neutronstar.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030720150243.GJ2331@neutronstar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please CC your replies, because i'm not subscribed]

I'm testing 2.6.0-test1 on my HP nx9005 Laptop (using a Mobile AMD Athlon XP)

But i can't get the sysfs interface of CPUFreq part to show up. I then
recomplied the kernel with both old (obsolete) /proc interfaces enabled. The old
interfaces both show up, but seem to be not working (but the is my first try to
get CPUFreq working with any kernel version). I googled around for hours
without finding any useful information for this case.

Anyway, /proc/sys/cpu/0/{speed,speed-max,speed-min} are all 0 when i cat them.

If i cat /proc/cpufreq i get:
Badness in kobject_get at lib/kobject.c:378
Call Trace:
 [<c01f775c>] kobject_get+0x4c/0x50
 [<c0135e85>] cpufreq_cpu_get+0x85/0x100
 [<c0136e13>] cpufreq_get_policy+0x23/0xa0
 [<c01f962f>] sprintf+0x1f/0x30
 [<c02a6bf0>] cpufreq_proc_read+0x50/0x170
 [<c0161ff8>] real_lookup+0xc8/0xf0
 [<c013e011>] buffered_rmqueue+0xd1/0x170
 [<c016b6a2>] dput+0x22/0x200
 [<c013e140>] __alloc_pages+0x90/0x300
 [<c02a6ba0>] cpufreq_proc_read+0x0/0x170
 [<c0184805>] proc_file_read+0xc5/0x280
 [<c0154b48>] vfs_read+0xd8/0x140
 [<c0154df2>] sys_read+0x42/0x70
 [<c010b29b>] syscall_call+0x7/0xb
          minimum CPU frequency  -  maximum CPU frequency  -  policy

The last line output by cat, the rest are kernel messages.

/sys/devices/system/cpu/cpu0/ is just an empty directory, it even does not
contain a 'name' file.

I can echo > to /proc/cpufreq and /proc/sys/cpu/0/speed without any
result (i.e. no speed change as far as i can tell).

The powernow driver detects the CPU.

Martin H.



Form bootup messages:
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f18c0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).

Hopefully relevant parts from my .config:
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K7=y
# [every thing else not set]

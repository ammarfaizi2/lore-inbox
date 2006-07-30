Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWG3MJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWG3MJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWG3MJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:09:05 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:9152 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932298AbWG3MJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:09:04 -0400
Date: Sun, 30 Jul 2006 14:08:44 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: linux-kernel@vger.kernel.org
Cc: zwane@arm.linux.org.uk
Subject: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060730120844.GA18293@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Since 2.6.18-rc1, up to and including -rc3, cpufreq has died on me. It
worked fine in 2.6.16.9.

The whole cpufreq hierarchy in /sys/ is missing, nothing is reported during
bootup mentioning 'cpufreq', and when I build with all the cpufreq stuff
configured as modules, I see this:

$ lsmod
Module                  Size  Used by
capability              3464  0
commoncap               5120  1 capability
acpi_cpufreq            4748  0
speedstep_lib           3716  0
cpufreq_userspace       3092  0
cpufreq_stats           3588  0
freq_table              3588  2 acpi_cpufreq,cpufreq_stats
cpufreq_powersave       1664  0
cpufreq_ondemand        4716  0
cpufreq_conservative     5280  0
b2c2_flexcop_pci        6936  0
b2c2_flexcop           22412  1 b2c2_flexcop_pci
mt352                   5636  1 b2c2_flexcop
mt312                   6660  1 b2c2_flexcop
bcm3510                 8196  1 b2c2_flexcop
stv0299                 8840  1 b2c2_flexcop
stv0297                 6272  1 b2c2_flexcop
nxt200x                11396  1 b2c2_flexcop
lgdt330x                7196  1 b2c2_flexcop
psmouse                31624  0

# modprobe p4_clockmod
FATAL: Error inserting p4_clockmod
(/lib/modules/2.6.18-rc3/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko):
Device or resource busy

dmesg is silent on why this is. I've grepped the files in the cpufreq
directory, but none of them contain EBUSY.

Under 2.6.16.9, this was logged at startup:
[17179582.044000] p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation
available

cpuinfo:
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 3000.298
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
constant_tsc pni monitor ds_cpl cid xtpr
bogomips        : 6004.95

>From .config:

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m

dmesg output is on http://ds9a.nl/tmp/dmesg , full .config on
http://ds9a.nl/config

Please let me know how I can help solve this problem. Zwane, you are welcome
to ssh to my system if that helps, let me know.

Kind regards,

bert



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services

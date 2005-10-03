Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbVJCV5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVJCV5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVJCV5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:57:31 -0400
Received: from ns.tasking.nl ([195.193.207.2]:45545 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S932705AbVJCV51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:57:27 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@altium.nl (Dick Streefland)
Subject: PowerNow! frequency scaling causes stalls
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <7484.4341a91e.3c3d8@altium.nl>
Date: Mon, 03 Oct 2005 21:56:46 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new laptop with an AMD Mobile Sempron, and I'm experimenting
with the PowerNow! frequency scaling. It seems to work, but on every
frequency change, everything stalls for 3-4 seconds, even the X mouse
pointer! Keyboard input seems to be buffered though. Is this normal?

I'm currently using the builtin frequency scaling "governors" of the
kernel with the following settings:

echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
echo 15000000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
echo 1        > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice

However, using the powernow daemon results in the same behavior.

Here are the relevant kernel (2.6.13.2) options:

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_DEBUG=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

This is reported in /var/log/messages:

Oct  3 22:04:35 acer kernel: CPU: AMD Mobile AMD Sempron(tm) Processor 3000+ stepping 02
[...]
Oct  3 22:04:35 acer kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.3)
Oct  3 22:04:35 acer kernel: powernow-k8:    0 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
Oct  3 22:04:35 acer kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xc (1250 mV)
Oct  3 22:04:35 acer kernel: powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x13 (1075 mV)
Oct  3 22:04:35 acer kernel: cpu_init done, current fid 0xa, vid 0xa

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------


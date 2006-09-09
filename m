Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWIIOWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWIIOWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWIIOWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:22:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:610 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932198AbWIIOWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:22:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QTgW4dLBTnqdJiRs42PUw/Yk05/+WtF5CyEGqtw7qQJ1/uYLSV/ipcgBTSyQj3enhhAyausDGnR7qWonXJc0w+ThwhDteHvIqhvtI79Iibx3rP9k6CGVHMaf+gEzhPBVQcu2jmKIyPhDSpAYT5v375cNXYu2M6jgTwaOFoopMtY=
Message-ID: <82ecf08e0609090722p1ded935dm794d569278d60122@mail.gmail.com>
Date: Sat, 9 Sep 2006 11:22:02 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Cpufreq not working in 2.6.18-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Cpufreq is not working for me in 2.6.18-rc6 (as it worked flawlessly
in 2.6.17.7 and earlier versions)

I cannot insmod powernow-k7, it only shows (in dmesg):

powernow: PowerNOW! Technology present. Can scale: frequency and voltage.

But then insmod fails with EBUSY (or better: init_module(0x804b018,
11352, "")       = -1 EBUSY (Device or resource busy))

I traced this to cpufreq_register_driver returning -0x16

I disabled APM for this kernel, previous kernel version had APM
enabled (AFAIK, shouldn't be relevant; ACPI is enabled)

I tried to enable APM only to discover it does not work to compile APM
as a module :/ (complains about default_idle and machine_real_restart
being "unknown symbols")

Will try with builtin APM later

Relevant config info is below:

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set

CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m
# CONFIG_ACPI_SBS is not set

Thanks in advance
-- 
-
Thiago Galesi

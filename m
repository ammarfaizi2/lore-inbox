Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUCWRXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUCWRXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:23:36 -0500
Received: from mail3.absamail.co.za ([196.35.40.69]:18734 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S262720AbUCWRXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:23:25 -0500
Subject: [Problem 2.6.4] Process table time incorrect after ACPI/APM resume
From: Niel Lambrechts <antispam@absamail.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080062537.6802.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 19:22:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System: 
SuSE 9.0 pro.
Linux 2.6.4 #1 Fri Mar 12 01:01:06 SAST 2004 i686 i686 i386 GNU/Linux.
IBM Thinkpad R50P, Intel 82855PM, Centrino 1.7 GHz.

Problem:
After ACPI/APM suspend-to-ram, process table times are wrong.

Symptoms:
After 1st resume, process table times were about 5 seconds slower than
the actual system time. I initially noticed this using ACPI, but can
confirm that the same happens under APM!

After repeating the suspend/resume thing:

ksyrium:~ # ps -ef|grep nothing
root      2288  1550  0 12:24 pts/34   00:00:00 grep nothing
ksyrium:~ # date
Thu Mar 18 12:26:41 SAST 2004
ksyrium:~ # ps -ef|grep nothing
root      2291  1550  0 12:24 pts/34   00:00:00 grep nothing
ksyrium:~ # date
Thu Mar 18 12:26:50 SAST 2004
ksyrium:~ # ps -ef|grep nothing
root      2294  1550  0 12:24 pts/34   00:00:00 grep nothing
ksyrium:~ # date
Thu Mar 18 12:26:53 SAST 2004
ksyrium:~ # ps -ef|grep nothing
root      2350  1550  0 12:31 pts/34   00:00:00 grep nothing
ksyrium:~ # date
Thu Mar 18 12:33:50 SAST 2004

The process table times are slowed significantly,
but not to a complete standstill afer resuming under BOTH power
management systems.

Surely this is not correct/sane? I couldn't find any more info at the
usual places googling/bugzilla.

Niel

Relevant options:
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_SND_RTCTIMER=m
# Power management options (ACPI, APM)
# APM (Advanced Power Management) BIOS Support
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_SERIAL_8250_ACPI is not set



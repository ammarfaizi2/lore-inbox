Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUC1W0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUC1W0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:26:00 -0500
Received: from mail3.absamail.co.za ([196.35.40.69]:60297 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S262418AbUC1WZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:25:53 -0500
Subject: [2.6.4] STIME confusion after ACPI/APM resume
From: Niel Lambrechts <antispam@absamail.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080512680.1743.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 00:24:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wondering if anyone else is getting this wrong behaviour?

<apm -s OR echo 3 > /proc/acpi/sleep>
<resume after a while>
notebook:~ # date
Thu Mar 18 12:26:41 SAST 2004

notebook:~ # ps -ef|grep nothing
UID        PID  PPID  C STIME TTY          TIME CMD
root      2291  1550  0 12:24 pts/34   00:00:00 grep nothing

You can clearly see STIME column lagging behind the real system time by
2 minutes...

It seems to be behind exactly the amount of time that the notebook was
suspended for.

BTW, hwclock and system time is in sync.

I have tried recompiling with disabling HPET - made no difference. also
updated ps (rpm) to ps-2004.1.24-3, same story.  

Is ps broken or is this an obscure kernel issue?

-Niel

Equipment:
IBM R50P Thinkpad, SuSE 9.0 Pro, kernel 2.6.4 w/APM.

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


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTKLMfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTKLMfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:35:48 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:21264 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262081AbTKLMfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:35:47 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 hangs upon echo > /proc/acpi/alarm
Date: Wed, 12 Nov 2003 20:33:18 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311122033.18729.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI version is 20031002

Initial backtrace obtained with kdb:

acpi_os_read_port+36
acpi_hw_lowlevel_read+7b
acpi_ev_gpe_detect+94
acpi_ev_sci_xrupt_handler+3c
acpi_irq+d
handle_IRQ_event+31
do_IRQ+72
call_do_IRQ+5
do_softirq+5a
do_IRQ+a1
proc_file_write+9b
sys_write+be
system_call+33

Further stepping shows endless loop around:

acpi_ev_gpe_detect+80
  acpi_hw_lowlevel_read
    acpi_os_read_port
    acpi_ut_get_region_name
    acpi_ut_debug_print 
  acpi_ut_debug_print
  jmp acpi_ev_gpe_detect+80

Debugging is compiled in, but no meesages go to dmesg

How to enable acpi_ut_debug_print output?

Regards
Michael


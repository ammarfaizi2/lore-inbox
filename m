Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTDFWSs (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbTDFWSs (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:18:48 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:42371 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263121AbTDFWSr (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 18:18:47 -0400
Subject: 2.5.66-bk12: acpi_power_off: sleeping function called from illegal
	context
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049668212.725.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 00:30:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing this oops on my P4 box running 2.5.66-bk12 + ACPI when
shutting it down (copied by hand):

Power down.
acpi_power_off called
Debug: sleeping function called from illegal context at
include/asm/semaphore.h: 119
Call  Trace:
 [<c012088a>] __might_sleep+0x5f/0x75
 [<c01ffb10>] acpi_os_wait_semaphore+0xc5/0xea
 [<c021440c>] acpi_ut_acquire_mutex+0x51/0x73
 [<c020ab4f>] acpi_set_register+0x34/0x15d
 [<c020b1f6>] acpi_enter_sleep_state+0x77/0x1ab
 [<c0215d7d>] acpi_power_off+0x21/0x23
 [<c011a3e5>] machine_power_off+0x10/0x13
 [<c0135f7b>] sys_reboot+0x332/0x741
 [<c011e010>] schedule+0x210/0x6d7
 [<c0130daf>] group_send_sig_info+0x2af/0x6b6
 [<c011e50d>] preempt_schedule+0x36/0x50
 [<c0131384>] kill_proc_info+0x60/0x62
 [<c0134346>] sys_kill+0x4d/0x51
 [<c016e76b>] __fput+0xaf/0xfb
 [<c016cabc>] filp_close+0x160/0x226
 [<c01850cb>] sys_ioctl+0x197/0x3e8
 [<c010af29>] sysenter_past_esp+0x52/0x71

This is not 100% reproducible. When using ACPI, the machine is *never*
able to properly shut it off (only APM is able to turn the machine off).

________________________________________________________________________
Linux Registered User #287198


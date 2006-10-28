Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752190AbWJ1MDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbWJ1MDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 08:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbWJ1MDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 08:03:24 -0400
Received: from smtp-send.myrealbox.com ([151.155.5.143]:41875 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S1752190AbWJ1MDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 08:03:23 -0400
Subject: Lockup with cpufreq that may be similar to recently fixed
	acpi_cpufreq
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 06:03:21 -0600
Message-Id: <1162037001.2465.14.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a single vendor problem. I am having a difficult time
getting the vendor to respond. However, I have a dual core Turion laptop
which is locking up on resume from suspend (resume from hibernate now
works fine). Below is the DWARF2 trace back. It is showing a problem in
cpufreq_resume (if I read this correctly). I think this may be similar
to a problem that was recently fixed, that had the same symptoms, in
acpi_cpufreq. This is 2.6.18.

Oct 18 12:51:12 mysystem kernel: BUG: sleeping function called from
invalid
context at kernel/rwsem.c:20
Oct 18 12:51:12 mysystem kernel: in_atomic():0, irqs_disabled():1
Oct 18 12:51:12 mysystem kernel:  [<c04051db>] dump_trace+0x69/0x1af
Oct 18 12:51:12 mysystem kernel:  [<c0405339>] show_trace_log_lvl+0x18/0x2c
Oct 18 12:51:12 mysystem kernel:  [<c04058ed>] show_trace+0xf/0x11
Oct 18 12:51:12 mysystem kernel:  [<c04059ea>] dump_stack+0x15/0x17
Oct 18 12:51:12 mysystem kernel:  [<c0439446>] down_read+0x12/0x20
Oct 18 12:51:12 mysystem kernel:  [<c0431601>] blocking_notifier_call_chain+0xe/0x29
Oct 18 12:51:12 mysystem kernel:  [<c05a9798>] cpufreq_resume+0x118/0x135
Oct 18 12:51:12 mysystem kernel:  [<c0551440>] __sysdev_resume+0x20/0x53
Oct 18 12:51:12 mysystem kernel:  [<c0551583>] sysdev_resume+0x16/0x47
Oct 18 12:51:12 mysystem kernel:  [<c0555767>] device_power_up+0x5/0xa
Oct 18 12:51:12 mysystem kernel:  [<c04418fd>] suspend_enter+0x3b/0x44
Oct 18 12:51:12 mysystem kernel:  [<c0441a2c>] enter_state+0x126/0x176
Oct 18 12:51:12 mysystem kernel:  [<c0441b01>] state_store+0x85/0x99
Oct 18 12:51:12 mysystem kernel:  [<c04a5fe6>] subsys_attr_store+0x1e/0x22
Oct 18 12:51:14 mysystem kernel:  [<c04a60d9>] sysfs_write_file+0xa7/0xce
Oct 18 12:51:14 mysystem kernel:  [<c046f805>] vfs_write+0xa8/0x159
Oct 18 12:51:14 mysystem kernel:  [<c046fe32>] sys_write+0x41/0x67
Oct 18 12:51:14 mysystem kernel:  [<c0404013>] syscall_call+0x7/0xb
Oct 18 12:51:14 mysystem kernel: DWARF2 unwinder stuck at syscall_call+0x7/0xb
Oct 18 12:51:14 mysystem kernel: Leftover inexact backtrace:
Oct 18 12:51:14 mysystem kernel:  =======================

Thank you,
Trever Adams


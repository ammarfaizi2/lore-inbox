Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVCCA63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVCCA63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVCCA6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:58:15 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:19162 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261392AbVCCA4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:56:52 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Cc: pavel@ucw.cz
Date: Thu, 03 Mar 2005 00:56:44 +0000
Message-Id: <1109811404.5918.80.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Scheduling while atomic errors on swsusp resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the current Ubuntu development kernel (2.6.10 with acpi and swsusp
stuff backported from 2.6.11), a user is getting the following trace on
resume. Passing noapic nolapic removes the APIC error, but the rest of
the trace is identical. This is reproducible, but only seems to happen
on this machine. Anyone have any idea what's going on before I head off
to try getting it reproduced with a stock kernel?

Stopping tasks:
=========================================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done (21866 pages freed)
.........................................swsusp: Need to copy 19917 pages
.swsusp: Restoring Highmem
APIC error on CPU0: 00(00)
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
scheduling while atomic: hibernate.sh/0x00000002/6955
 [<c029d72d>] schedule+0x52d/0x540
 [<f886c5e0>] task_no_data_intr+0x0/0xa0 [ide_core]
 [<c029d808>] wait_for_completion+0x78/0xd0
 [<c01161e0>] default_wake_function+0x0/0x20
 [<c01161e0>] default_wake_function+0x0/0x20
 [<c021a5f8>] __elv_add_request+0x78/0xc0
 [<f8868049>] ide_do_drive_cmd+0xf9/0x170 [ide_core]
 [<f8865343>] generic_ide_resume+0x93/0xc0 [ide_core]
 [<c0219d67>] resume_device+0x27/0x30
 [<c0219e14>] dpm_resume+0xa4/0xb0
 [<c0219e31>] device_resume+0x11/0x20
 [<c0135712>] finish+0x12/0x60
 [<c0135841>] pm_suspend_disk+0x41/0x80
 [<c01334dc>] enter_state+0x6c/0x70
 [<c0133620>] state_store+0xa0/0xa8
 [<c019563a>] subsys_attr_store+0x3a/0x40
 [<c01958de>] flush_write_buffer+0x3e/0x50
 [<c019595f>] sysfs_write_file+0x6f/0x80
 [<c01958f0>] sysfs_write_file+0x0/0x80
 [<c015831f>] vfs_write+0xbf/0x150
 [<c0158481>] sys_write+0x51/0x80
 [<c01030e9>] sysenter_past_esp+0x52/0x75
Restarting tasks...<3>scheduling while atomic: hibernate.sh/0x00000002/6955
 [<c029d72d>] schedule+0x52d/0x540
 [<c011593e>] wake_up_process+0x1e/0x20
 [<c0133944>] thaw_processes+0xa4/0xe0
 [<c0135720>] finish+0x20/0x60
 [<c0135841>] pm_suspend_disk+0x41/0x80
 [<c01334dc>] enter_state+0x6c/0x70
 [<c0133620>] state_store+0xa0/0xa8
 [<c019563a>] subsys_attr_store+0x3a/0x40
 [<c01958de>] flush_write_buffer+0x3e/0x50
 [<c019595f>] sysfs_write_file+0x6f/0x80
 [<c01958f0>] sysfs_write_file+0x0/0x80
 [<c015831f>] vfs_write+0xbf/0x150
 [<c0158481>] sys_write+0x51/0x80
 [<c01030e9>] sysenter_past_esp+0x52/0x75
 done
scheduling while atomic: hibernate.sh/0x00000001/6955
 [<c029d72d>] schedule+0x52d/0x540
 [<c0158481>] sys_write+0x51/0x80
 [<c0103166>] work_resched+0x5/0x16
scheduling while atomic: hibernate.sh/0x00000001/6955
 [<c029d72d>] schedule+0x52d/0x540
 [<c0116cd3>] sys_sched_yield+0x53/0x70
 [<c0164358>] coredump_wait+0x38/0xa0
 [<c0115904>] try_to_wake_up+0xa4/0xc0
 [<c016448d>] do_coredump+0xcd/0x1d6
 [<c01c93e4>] vgacon_scroll+0x144/0x230
 [<c0122dcf>] free_uid+0x1f/0x80
 [<c01236b5>] __dequeue_signal+0xe5/0x1a0
 [<c01237a5>] dequeue_signal+0x35/0x90
 [<c012547d>] get_signal_to_deliver+0x20d/0x300
 [<c0102f3d>] do_signal+0x9d/0x130
 [<c012ad6e>] __kernel_text_address+0x2e/0x40
 [<c012ad6e>] __kernel_text_address+0x2e/0x40
 [<c01156af>] recalc_task_prio+0x8f/0x190
 [<c029d4f1>] schedule+0x2f1/0x540
 [<c01142b0>] do_page_fault+0x0/0x5c7
 [<c0103007>] do_notify_resume+0x37/0x3c
 [<c010318a>] work_notifysig+0x13/0x15
note: hibernate.sh[6955] exited with preempt_count 1
-- 
Matthew Garrett | mjg59@srcf.ucam.org


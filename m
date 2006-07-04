Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWGDOyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWGDOyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 10:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGDOyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 10:54:19 -0400
Received: from homer.mvista.com ([63.81.120.158]:13737 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751037AbWGDOyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 10:54:19 -0400
Subject: [BUG] scsi/io-elevator held lock freed.
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Content-Type: text/plain
Date: Tue, 04 Jul 2006 07:54:14 -0700
Message-Id: <1152024854.29262.5.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this during boot. I booted the same kernel several times, and only
saw it once. The kernel was 2.6.17-mm5 .

Daniel


=========================
[ BUG: held lock freed! ]
-------------------------
swapper/1 is freeing memory f73a8580-f73a867f, with a lock still held there!
2 locks held by swapper/1:
 #0:  (&shost->scan_mutex){--..}, at: [<c0419098>] mutex_lock+0x8/0x10
 #1:  (&eq->sysfs_lock){--..}, at: [<c0419098>] mutex_lock+0x8/0x10

stack backtrace:
 [<c010546b>] show_trace+0x1b/0x20
 [<c0105494>] dump_stack+0x24/0x30
 [<c013c234>] debug_check_no_locks_freed+0x154/0x190
 [<c016be44>] kfree+0x54/0xb0
 [<c022c0f3>] cfq_exit_queue+0xe3/0x100
 [<c021f6ea>] elevator_exit+0x2a/0x50
 [<c022180b>] blk_cleanup_queue+0x3b/0x50
 [<c02c7ff1>] scsi_free_queue+0x11/0x20
 [<c02cd5ff>] scsi_device_dev_release_usercontext+0xff/0x1a0
 [<c0130975>] execute_in_process_context+0x25/0x60
 [<c02cc433>] scsi_device_dev_release+0x23/0x30
 [<c0298bdd>] device_release+0x1d/0x80
 [<c0230c6c>] kobject_cleanup+0x4c/0x90
 [<c0230cc4>] kobject_release+0x14/0x20
 [<c02312ea>] kref_put+0x3a/0xb0
 [<c0230451>] kobject_put+0x21/0x30
 [<c0298fca>] put_device+0x1a/0x20
 [<c02cae17>] scsi_probe_and_add_lun+0x637/0x9a0
 [<c02cb75f>] __scsi_scan_target+0xef/0x600
 [<c02cbce8>] scsi_scan_channel+0x78/0x90
 [<c02cbd67>] scsi_scan_host_selected+0x67/0xe0
 [<c02cbe12>] scsi_scan_host+0x32/0x40
 [<c02d2d84>] sym2_probe+0x9d4/0xa20
 [<c023c871>] pci_device_probe+0x61/0x80
 [<c029b4be>] driver_probe_device+0x4e/0xe0
 [<c029b653>] __driver_attach+0x73/0x80
 [<c029ada7>] bus_for_each_dev+0x57/0x80
 [<c029b337>] driver_attach+0x27/0x30
 [<c029a916>] bus_add_driver+0x86/0x180
 [<c029b91d>] driver_register+0xad/0xf0
 [<c023c3a5>] __pci_register_driver+0x65/0x90
 [<c05693dc>] sym2_init+0x6c/0x120
 [<c01003e0>] init+0xf0/0x320
 [<c01008e5>] kernel_thread_helper+0x5/0x10



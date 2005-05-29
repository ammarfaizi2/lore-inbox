Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVE2NPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVE2NPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVE2NPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:15:20 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:39258 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261298AbVE2NPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:15:12 -0400
Subject: Hanging fdisk after disk changes
From: "Raf D'Halleweyn (list)" <list@noduck.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 29 May 2005 09:14:56 -0400
Message-Id: <1117372496.7448.7.camel@alto>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,

I have an fdisk process that is hanging for 12 hours now. I attached a
new disk (Firewire) and ran 'fdisk -l' to see the partitions.

This is with 2.6.12-rc5 (and the inotify patch), but I have noticed
similar behavior with previous versions. Sysrq-t gives the following:

fdisk         D C201055C     0 17226      1         13118 17287 (NOTLB)
f2763dac 00000086 f4436a40 c201055c 000008eb 00000020 f4553e00 f4436a40
       00000002 00000000 f4436a40 c0129659 c2010f60 f776adf0 00000000 00000002
       c2010520 00000000 000295f9 9535f9b2 000008eb c201055c f206f020 f206f144
Call Trace:
 [__mod_timer+249/320] __mod_timer+0xf9/0x140
 [kobject_release+0/16] kobject_release+0x0/0x10
 [wait_for_completion+148/224] wait_for_completion+0x94/0xe0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [scsi_insert_special_req+56/64] scsi_insert_special_req+0x38/0x40
 [scsi_wait_req+140/192] scsi_wait_req+0x8c/0xc0
 [scsi_wait_done+0/144] scsi_wait_done+0x0/0x90
 [scsi_allocate_request+46/112] scsi_allocate_request+0x2e/0x70
 [scsi_test_unit_ready+111/208] scsi_test_unit_ready+0x6f/0xd0
 [cap_task_post_setuid+0/320] cap_task_post_setuid+0x0/0x140
 [sd_media_changed+110/160] sd_media_changed+0x6e/0xa0
 [check_disk_change+54/128] check_disk_change+0x36/0x80
 [sd_open+98/256] sd_open+0x62/0x100
 [sd_open+0/256] sd_open+0x0/0x100
 [do_open+256/864] do_open+0x100/0x360
 [blkdev_open+52/112] blkdev_open+0x34/0x70
 [dentry_open+362/608] dentry_open+0x16a/0x260
 [filp_open+104/112] filp_open+0x68/0x70
 [get_unused_fd+162/208] get_unused_fd+0xa2/0xd0
 [sys_open+79/224] sys_open+0x4f/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb


Raf. 


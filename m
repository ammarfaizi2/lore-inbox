Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTFBEV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTFBEV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:21:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:60834 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261840AbTFBEVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:21:52 -0400
Date: Sun, 01 Jun 2003 20:58:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 763] New: machine hang, log file indicates "Slab corruption"
Message-ID: <63770000.1054526282@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: machine hang, log file indicates "Slab corruption"
    Kernel Version: 2.5.70-bk6
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: mhughes@mhughes.dhs.org


Distribution: Red Hat 8.0
Hardware Environment: Athlon XP1900
Software Environment: gcc 3.2
Problem Description: System hang

Steps to reproduce: not known (this is the first occurence). I installed
2.5.70-bk6 this morning, ran about .5 day before hanging up during normal usage
(running the gimp, editing digital pictures). 

I don't know if this category and component are correct, but the most
interesting thing in the logs looked like an indication of memory corruption to
me, so this was my best guess.

Not sure if the log messages are related or not, but thought I would stick them
in. Basically, seeing lots of ATAPI cdrom errors (the drives were not in use),
and one slab corruption block. Here's the whole section of log:
Jun  1 10:06:11 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 10:06:11 penguin kernel: hdc: DMA disabled
Jun  1 10:06:11 penguin kernel: hdc: ATAPI reset complete
Jun  1 10:06:11 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 10:06:11 penguin kernel: hdc: ATAPI reset complete
Jun  1 10:06:11 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 10:06:11 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 10:06:11 penguin kernel: hdc: drive not ready for command
Jun  1 10:06:11 penguin kernel: sr0: CDROM (ioctl) error, command: Read TOC 00
00 00 00 00 00 00 0c 40
Jun  1 10:06:11 penguin kernel: Current sr?: sense key No Sense
Jun  1 10:30:10 penguin kernel: ide-scsi: abort called for 38372
Jun  1 10:30:10 penguin kernel: bad: scheduling while atomic!
Jun  1 10:30:10 penguin kernel: Call Trace:
Jun  1 10:30:10 penguin kernel:  [<c011ab19>] schedule+0x399/0x3a0
Jun  1 10:30:10 penguin kernel:  [<c0109c6c>] __down+0x8c/0x100
Jun  1 10:30:10 penguin kernel:  [<c011ab80>] default_wake_function+0x0/0x30
Jun  1 10:30:10 penguin kernel:  [<c011abe1>] __wake_up_common+0x31/0x50
Jun  1 10:30:10 penguin kernel:  [<c0109e7f>] __down_failed+0xb/0x14
Jun  1 10:30:10 penguin kernel:  [<c02c645f>] .text.lock.scsi_error+0x37/0x58
Jun  1 10:30:10 penguin kernel:  [<c02c5ca0>] scsi_sleep_done+0x0/0x20
Jun  1 10:30:10 penguin kernel:  [<c02d4772>] idescsi_abort+0xf2/0x100
Jun  1 10:30:10 penguin kernel:  [<c02d4680>] idescsi_abort+0x0/0x100
Jun  1 10:30:10 penguin kernel:  [<c02c5612>] scsi_try_to_abort_cmd+0x62/0x80
Jun  1 10:30:10 penguin kernel:  [<c02c5740>] scsi_eh_abort_cmds+0x40/0x80
Jun  1 10:30:10 penguin kernel:  [<c02c6113>] scsi_unjam_host+0xa3/0xd0
Jun  1 10:30:10 penguin kernel:  [<c02c6208>] scsi_error_handler+0xc8/0x110
Jun  1 10:30:10 penguin kernel:  [<c02c6140>] scsi_error_handler+0x0/0x110
Jun  1 10:30:10 penguin kernel:  [<c0108e4d>] kernel_thread_helper+0x5/0x18
Jun  1 10:30:10 penguin kernel:
Jun  1 10:30:10 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 10:30:11 penguin kernel: hdc: ATAPI reset complete
Jun  1 10:30:11 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 10:30:11 penguin kernel: hdc: ATAPI reset complete
Jun  1 10:30:11 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 10:30:11 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 10:30:11 penguin kernel: hdc: drive not ready for command
Jun  1 11:20:35 penguin sshd(pam_unix)[1766]: session opened for user michelle
by (uid=501)
Jun  1 11:20:49 penguin sshd(pam_unix)[1815]: session opened for user michelle
by (uid=501)
Jun  1 11:21:05 penguin sshd(pam_unix)[1868]: session opened for user michelle
by (uid=501)
Jun  1 11:21:12 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 11:21:12 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:21:12 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:21:12 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:21:12 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:21:12 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 11:21:12 penguin kernel: hdc: drive not ready for command
Jun  1 11:21:12 penguin kernel: sr0: CDROM (ioctl) error, command: Read TOC 00
00 00 00 00 00 00 0c 40
Jun  1 11:21:12 penguin kernel: Current sr?: sense key No Sense
Jun  1 11:21:27 penguin gconfd (michelle-1925): starting (version 1.2.1), pid
1925 user 'michelle'
Jun  1 11:21:27 penguin gconfd (michelle-1925): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at
position 0
Jun  1 11:21:27 penguin gconfd (michelle-1925): Resolved address
"xml:readwrite:/home/michelle/.gconf" to a writable config source at position 1
Jun  1 11:21:27 penguin gconfd (michelle-1925): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at
position 2
Jun  1 11:47:34 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 11:47:34 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:47:34 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:47:34 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:47:34 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:47:34 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 11:47:34 penguin kernel: hdc: drive not ready for command
Jun  1 11:50:49 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 11:50:49 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:50:49 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:50:49 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:50:49 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:50:49 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 11:50:49 penguin kernel: hdc: drive not ready for command
Jun  1 11:50:49 penguin kernel: sr0: CDROM (ioctl) error, command: Test Unit
Ready 00 00 00 00 00
Jun  1 11:50:49 penguin kernel: Current sr?: sense key No Sense
Jun  1 11:56:34 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 11:56:34 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:56:34 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:56:34 penguin kernel: hdc: ATAPI reset complete
Jun  1 11:56:34 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 11:56:34 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 11:56:34 penguin kernel: hdc: drive not ready for command
Jun  1 11:56:34 penguin kernel: sr0: CDROM (ioctl) error, command: Read TOC 00
00 00 00 00 00 00 0c 40
Jun  1 11:56:34 penguin kernel: Current sr?: sense key No Sense
Jun  1 12:22:44 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 12:22:44 penguin kernel: hdc: ATAPI reset complete
Jun  1 12:22:44 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 12:22:44 penguin kernel: hdc: ATAPI reset complete
Jun  1 12:22:44 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 12:22:44 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 12:22:44 penguin kernel: hdc: drive not ready for command
Jun  1 12:22:44 penguin kernel: sr0: CDROM (ioctl) error, command: Test Unit
Ready 00 00 00 00 00
Jun  1 12:22:44 penguin kernel: Current sr?: sense key No Sense
Jun  1 12:42:02 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 12:42:02 penguin kernel: ide-scsi: abort called for 124613
Jun  1 12:42:02 penguin kernel: bad: scheduling while atomic!
Jun  1 12:42:02 penguin kernel: Call Trace:
Jun  1 12:42:02 penguin kernel:  [<c011ab19>] schedule+0x399/0x3a0
Jun  1 12:42:02 penguin kernel:  [<c02a91a7>] ide_do_request+0x207/0x3a0
Jun  1 12:42:02 penguin kernel:  [<c0109c6c>] __down+0x8c/0x100
Jun  1 12:42:02 penguin kernel:  [<c011ab80>] default_wake_function+0x0/0x30
Jun  1 12:42:02 penguin kernel:  [<c011abe1>] __wake_up_common+0x31/0x50
Jun  1 12:42:02 penguin kernel:  [<c0109e7f>] __down_failed+0xb/0x14
Jun  1 12:42:02 penguin kernel:  [<c02c645f>] .text.lock.scsi_error+0x37/0x58
Jun  1 12:42:02 penguin kernel:  [<c02c5ca0>] scsi_sleep_done+0x0/0x20
Jun  1 12:42:02 penguin kernel:  [<c02d4772>] idescsi_abort+0xf2/0x100
Jun  1 12:42:02 penguin kernel:  [<c02d4680>] idescsi_abort+0x0/0x100
Jun  1 12:42:02 penguin kernel:  [<c02c5612>] scsi_try_to_abort_cmd+0x62/0x80
Jun  1 12:42:02 penguin kernel:  [<c02c5740>] scsi_eh_abort_cmds+0x40/0x80
Jun  1 12:42:02 penguin kernel:  [<c02c6113>] scsi_unjam_host+0xa3/0xd0
Jun  1 12:42:02 penguin kernel:  [<c02c6208>] scsi_error_handler+0xc8/0x110
Jun  1 12:42:02 penguin kernel:  [<c02c6140>] scsi_error_handler+0x0/0x110
Jun  1 12:42:02 penguin kernel:  [<c0108e4d>] kernel_thread_helper+0x5/0x18
Jun  1 12:42:02 penguin kernel:
Jun  1 12:42:02 penguin kernel: hdc: ATAPI reset complete
Jun  1 12:42:02 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 12:42:02 penguin kernel: hdc: ATAPI reset complete
Jun  1 12:42:02 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 12:42:03 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 12:42:03 penguin kernel: hdc: drive not ready for command
Jun  1 13:13:43 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 13:13:43 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:13:43 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:13:43 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:13:43 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:13:43 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 13:13:43 penguin kernel: hdc: drive not ready for command
Jun  1 13:19:17 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 13:19:17 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:19:17 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:19:17 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:19:17 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:19:17 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 13:19:17 penguin kernel: hdc: drive not ready for command
Jun  1 13:19:17 penguin kernel: sr0: CDROM (ioctl) error, command: Test Unit
Ready 00 00 00 00 00
Jun  1 13:19:17 penguin kernel: Current sr?: sense key No Sense
Jun  1 13:29:32 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 13:29:32 penguin kernel: ide-scsi: abort called for 155546
Jun  1 13:29:32 penguin kernel: bad: scheduling while atomic!
Jun  1 13:29:32 penguin kernel: Call Trace:
Jun  1 13:29:32 penguin kernel:  [<c011ab19>] schedule+0x399/0x3a0
Jun  1 13:29:32 penguin kernel:  [<c02a91a7>] ide_do_request+0x207/0x3a0
Jun  1 13:29:32 penguin kernel:  [<c0109c6c>] __down+0x8c/0x100
Jun  1 13:29:32 penguin kernel:  [<c011ab80>] default_wake_function+0x0/0x30
Jun  1 13:29:32 penguin kernel:  [<c011abe1>] __wake_up_common+0x31/0x50
Jun  1 13:29:32 penguin kernel:  [<c0109e7f>] __down_failed+0xb/0x14
Jun  1 13:29:32 penguin kernel:  [<c02c645f>] .text.lock.scsi_error+0x37/0x58
Jun  1 13:29:32 penguin kernel:  [<c02c5ca0>] scsi_sleep_done+0x0/0x20
Jun  1 13:29:32 penguin kernel:  [<c02d4772>] idescsi_abort+0xf2/0x100
Jun  1 13:29:32 penguin kernel:  [<c02d4680>] idescsi_abort+0x0/0x100
Jun  1 13:29:32 penguin kernel:  [<c02c5612>] scsi_try_to_abort_cmd+0x62/0x80
Jun  1 13:29:32 penguin kernel:  [<c02c5740>] scsi_eh_abort_cmds+0x40/0x80
Jun  1 13:29:32 penguin kernel:  [<c02c6113>] scsi_unjam_host+0xa3/0xd0
Jun  1 13:29:32 penguin kernel:  [<c02c6208>] scsi_error_handler+0xc8/0x110
Jun  1 13:29:32 penguin kernel:  [<c02c6140>] scsi_error_handler+0x0/0x110
Jun  1 13:29:32 penguin kernel:  [<c0108e4d>] kernel_thread_helper+0x5/0x18
Jun  1 13:29:32 penguin kernel:
Jun  1 13:29:32 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:29:32 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:29:32 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:29:32 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:29:33 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 13:29:33 penguin kernel: hdc: drive not ready for command
Jun  1 13:41:18 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 13:41:18 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:41:18 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:41:18 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:41:18 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:41:18 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 13:41:18 penguin kernel: hdc: drive not ready for command
Jun  1 13:48:48 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 13:48:48 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:48:48 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:48:48 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:48:48 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:48:48 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 13:48:48 penguin kernel: hdc: drive not ready for command
Jun  1 13:48:48 penguin kernel: sr0: CDROM (ioctl) error, command: Read TOC 00
00 00 00 00 00 00 0c 00
Jun  1 13:48:48 penguin kernel: Current sr?: sense key No Sense
Jun  1 13:49:08 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 13:49:08 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:49:08 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:49:08 penguin kernel: hdc: ATAPI reset complete
Jun  1 13:49:08 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 13:49:08 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 13:49:08 penguin kernel: hdc: drive not ready for command
Jun  1 13:49:08 penguin kernel: sr0: CDROM (ioctl) error, command: Test Unit
Ready 00 00 00 00 00
Jun  1 13:49:08 penguin kernel: Current sr?: sense key No Sense
Jun  1 13:54:01 penguin kernel: Slab corruption: start=c933cd80,
expend=c933d37f, problemat=c933cd88
Jun  1 13:54:01 penguin kernel: Data: ********6A
***************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************************************************************** Jun  1 13:54:01 penguin kernel:
*******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
Jun  1 13:54:01 penguin kernel: Next: ********************************
Jun  1 13:54:01 penguin kernel: slab error in check_poison_obj(): cache
`task_struct':
object was modified after freeing
Jun  1 13:54:01 penguin kernel: Call Trace:
Jun  1 13:54:01 penguin kernel:  [<c013a95b>] check_poison_obj+0x15b/0x1b0
Jun  1 13:54:01 penguin kernel:  [<c013c07e>] kmem_cache_alloc+0x11e/0x150
Jun  1 13:54:01 penguin kernel:  [<c011c2f6>] dup_task_struct+0xe6/0x110
Jun  1 13:54:01 penguin kernel:  [<c011c2f6>] dup_task_struct+0xe6/0x110
Jun  1 13:54:01 penguin kernel:  [<c011ce3f>] copy_process+0x6f/0xb50
Jun  1 13:54:01 penguin kernel:  [<c0220b5f>] sprintf+0x1f/0x30
Jun  1 13:54:01 penguin kernel:  [<c015d478>] do_pipe+0x178/0x1f0
Jun  1 13:54:01 penguin kernel:  [<c011d96d>] do_fork+0x4d/0x160
Jun  1 13:54:01 penguin kernel:  [<c0109718>] sys_vfork+0x38/0x40
Jun  1 13:54:01 penguin kernel:  [<c010ae9b>] syscall_call+0x7/0xb
Jun  1 13:54:01 penguin kernel:
Jun  1 14:00:11 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 14:00:11 penguin kernel: ide-scsi: abort called for 175350
Jun  1 14:00:11 penguin kernel: bad: scheduling while atomic!
Jun  1 14:00:11 penguin kernel: Call Trace:
Jun  1 14:00:11 penguin kernel:  [<c011ab19>] schedule+0x399/0x3a0
Jun  1 14:00:11 penguin kernel:  [<c02a91a7>] ide_do_request+0x207/0x3a0
Jun  1 14:00:11 penguin kernel:  [<c0109c6c>] __down+0x8c/0x100
Jun  1 14:00:11 penguin kernel:  [<c011ab80>] default_wake_function+0x0/0x30
Jun  1 14:00:11 penguin kernel:  [<c011abe1>] __wake_up_common+0x31/0x50
Jun  1 14:00:11 penguin kernel:  [<c0109e7f>] __down_failed+0xb/0x14
Jun  1 14:00:11 penguin kernel:  [<c02c645f>] .text.lock.scsi_error+0x37/0x58
Jun  1 14:00:11 penguin kernel:  [<c02c5ca0>] scsi_sleep_done+0x0/0x20
Jun  1 14:00:11 penguin kernel:  [<c02d4772>] idescsi_abort+0xf2/0x100
Jun  1 14:00:11 penguin kernel:  [<c02d4680>] idescsi_abort+0x0/0x100
Jun  1 14:00:11 penguin kernel:  [<c02c5612>] scsi_try_to_abort_cmd+0x62/0x80
Jun  1 14:00:11 penguin kernel:  [<c02c5740>] scsi_eh_abort_cmds+0x40/0x80
Jun  1 14:00:11 penguin kernel:  [<c02c6113>] scsi_unjam_host+0xa3/0xd0
Jun  1 14:00:11 penguin kernel:  [<c02c6208>] scsi_error_handler+0xc8/0x110
Jun  1 14:00:11 penguin kernel:  [<c02c6140>] scsi_error_handler+0x0/0x110
Jun  1 14:00:11 penguin kernel:  [<c0108e4d>] kernel_thread_helper+0x5/0x18

etc. The last log message before the hang was more than an hour later
and is another hdc error - 
Jun  1 15:07:29 penguin kernel: hdc: irq timeout: status=0xd8 { Busy }
Jun  1 15:07:29 penguin kernel: hdc: ATAPI reset complete
Jun  1 15:07:29 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 15:07:29 penguin kernel: hdc: ATAPI reset complete
Jun  1 15:07:29 penguin kernel: hdc: irq timeout: status=0x80 { Busy }
Jun  1 15:07:29 penguin kernel: hdc: status error: status=0x08 { DataRequest }
Jun  1 15:07:29 penguin kernel: hdc: drive not ready for command
Jun  1 15:07:29 penguin kernel: sr0: CDROM (ioctl) error, command: Test Unit
Ready 00 00 00 00 00
Jun  1 15:07:29 penguin kernel: Current sr?: sense key No Sense

If I can add info or do any useful debugging, please let me know!
Matt



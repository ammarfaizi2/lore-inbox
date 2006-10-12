Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWJLGpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWJLGpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWJLGpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:45:42 -0400
Received: from rbox5.erasmusmc.nl ([156.83.10.15]:2765 "EHLO
	rbox5.erasmusmc.nl") by vger.kernel.org with ESMTP id S932500AbWJLGpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:45:41 -0400
From: "Jerome Borsboom" <j.borsboom@erasmusmc.nl>
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Oct 2006 08:45:29 +0200
MIME-Version: 1.0
Subject: crash on using sg and gdth with tape backup
Message-ID: <452E00A9.21620.18D57B@j.borsboom.erasmusmc.nl>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got two identical easy to trigger crashed when using a tape backup 
unit through an ICP vortex SCSI card. Below is the kernel crash dump 
from a vanilla 2.6.18 kernel. I have no idea what is causing it. 
Will try 2.6.17 series kernel to see if it is related to recent 
gdth.c changes.

Jerome

Oct 11 23:02:04 cl09-enehelft kernel: BUG: unable to handle kernel paging request at virtual address f8804000
Oct 11 23:02:04 cl09-enehelft kernel:  printing eip:
Oct 11 23:02:04 cl09-enehelft kernel: f882f365
Oct 11 23:02:04 cl09-enehelft kernel: *pde = 01916067
Oct 11 23:02:04 cl09-enehelft kernel: Oops: 0002 [#1]
Oct 11 23:02:04 cl09-enehelft kernel: PREEMPT SMP 
Oct 11 23:02:04 cl09-enehelft kernel: Modules linked in: sg 3c59x mii af_packet xt_tcpudp ipt_LOG xt_state ip_conntrack_ftp ip_connt
rack iptable_filter ip_tables x_tables quota_v2 sd_mod gdth scsi_mod 
Oct 11 23:02:04 cl09-enehelft kernel: CPU:    0
Oct 11 23:02:04 cl09-enehelft kernel: EIP:    0060:[<f882f365>]    Not tainted VLI
Oct 11 23:02:04 cl09-enehelft kernel: EFLAGS: 00010006   (2.6.18 #1) 
Oct 11 23:02:04 cl09-enehelft kernel: EIP is at gdth_copy_command+0x155/0x170 [gdth]
Oct 11 23:02:04 cl09-enehelft kernel: eax: 00000003   ebx: c030b3ac   ecx: 0000149d   edx: f8801020
Oct 11 23:02:04 cl09-enehelft kernel: esi: c030e17c   edi: f8804000   ebp: 00000000   esp: e5c05cb8
Oct 11 23:02:04 cl09-enehelft kernel: ds: 007b   es: 007b   ss: 0068
Oct 11 23:02:04 cl09-enehelft kernel: Process ytlinsdr (pid: 1467, ti=e5c05000 task=c1955030 task.ti=e5c05000)
Oct 11 23:02:04 cl09-enehelft kernel: Stack: 00008044 c0005a20 c0005a64 c030b3dc c030b3ac f882fc19 00000000 c01b0a39
Oct 11 23:02:04 cl09-enehelft kernel:        00000001 00000003 00ef7e98 00000000 00000005 00000000 c03082f4 00000002
Oct 11 23:02:04 cl09-enehelft kernel:        00000000 00000005 c03082f4 c03082f4 c0005a20 f8830dea ec416800 f6bef3d8
Oct 11 23:02:04 cl09-enehelft kernel: Call Trace:
Oct 11 23:02:04 cl09-enehelft kernel:  [<f882fc19>] gdth_fill_raw_cmd+0x189/0x5a0 [gdth]
Oct 11 23:02:04 cl09-enehelft kernel:  [<c01b0a39>] journal_add_journal_head+0xb9/0x1f0
Oct 11 23:02:04 cl09-enehelft kernel:  [<f8830dea>] gdth_next+0x29a/0xbc0 [gdth]
Oct 11 23:02:04 cl09-enehelft kernel:  [<c01aabac>] journal_stop+0x17c/0x260
Oct 11 23:02:04 cl09-enehelft kernel:  [<c0124b20>] lock_timer_base+0x20/0x50
Oct 11 23:02:04 cl09-enehelft kernel:  [<c0124c68>] __mod_timer+0xa8/0xd0
Oct 11 23:02:04 cl09-enehelft kernel:  [<f8830803>] gdth_putq+0xe3/0x160 [gdth]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f883178b>] gdth_queuecommand+0x7b/0x90 [gdth]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f881ab3a>] scsi_dispatch_cmd+0x14a/0x240 [scsi_mod]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f881f2de>] scsi_request_fn+0x1be/0x310 [scsi_mod]
Oct 11 23:02:04 cl09-enehelft kernel:  [<c012513a>] del_timer+0x5a/0x70
Oct 11 23:02:04 cl09-enehelft kernel:  [<c01c20c5>] __generic_unplug_device+0x25/0x30
Oct 11 23:02:04 cl09-enehelft kernel:  [<c01c212e>] blk_execute_rq_nowait+0x5e/0xb0
Oct 11 23:02:04 cl09-enehelft kernel:  [<c01c23c5>] blk_get_request+0x55/0x90
Oct 11 23:02:04 cl09-enehelft kernel:  [<f881f031>] scsi_execute_async+0x281/0x370 [scsi_mod]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f881eae0>] scsi_end_async+0x0/0x60 [scsi_mod]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f88c4481>] sg_common_write+0x281/0x6a0 [sg]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f88c3fa0>] sg_cmd_done+0x0/0x260 [sg]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f88c5cca>] sg_open+0x29a/0x310 [sg]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f88c4a36>] sg_new_write+0x196/0x230 [sg]
Oct 11 23:02:04 cl09-enehelft kernel:  [<f88c6813>] sg_ioctl+0x803/0xa40 [sg]
Oct 11 23:02:04 cl09-enehelft kernel:  [<c016d9a8>] do_ioctl+0x78/0x90
Oct 11 23:02:04 cl09-enehelft kernel:  [<c016da1c>] vfs_ioctl+0x5c/0x2b0
Oct 11 23:02:04 cl09-enehelft kernel:  [<c016dcad>] sys_ioctl+0x3d/0x70
Oct 11 23:02:04 cl09-enehelft kernel:  [<c0102fdd>] sysenter_past_esp+0x56/0x79
Oct 11 23:02:04 cl09-enehelft kernel: Code: 02 00 00 89 de 0f b7 c0 8d 94 8f 20 10 00 00 66 89 42 08 8d bc 2f 30 12 00 00 0f b6 83 c
c 01 00 00 66 89 42 0a 8b 0c 24 c1 e9 02 <f3> a5 8b 0c 24 83 e1 03 74 02 f3 a4 e9 1a ff ff ff 8d 76 00 8d
Oct 11 23:02:04 cl09-enehelft kernel: EIP: [<f882f365>] gdth_copy_command+0x155/0x170 [gdth] SS:ESP 0068:e5c05cb8
Oct 11 23:02:04 cl09-enehelft kernel:  <6>note: ytlinsdr[1467] exited with preempt_count 2
-----------------------------
Dr.ir. Jerome Borsboom, Ph.D.
Biomedical Engineering
Erasmus MC
Room Ee2302
Dr. Molewaterplein 50
3015 GE Rotterdam
the Netherlands
Tel:  +31 10 408 7474
Fax: + 31 10 408 9445



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264988AbTIJPYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbTIJPYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:24:05 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:43940 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264988AbTIJPYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:24:01 -0400
Date: Wed, 10 Sep 2003 17:23:59 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [2.6] USB oops
Message-ID: <Pine.LNX.4.51.0309101720540.14731@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this calltrace after doing these steps:
1) remove an mp3 player from usb without unmount it
2) come back the day after and plug it in
3) try to unmount the device after noticing it has not been unmounted

unmount segfaults
and kernlog contains this:
Sep 10 13:23:45 pysiak kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000024
Sep 10 13:23:45 pysiak kernel:  printing eip:
Sep 10 13:23:45 pysiak kernel: c0170295
Sep 10 13:23:45 pysiak kernel: *pde = 00000000
Sep 10 13:23:45 pysiak kernel: Oops: 0002 [#1]
Sep 10 13:23:45 pysiak kernel: PREEMPT
Sep 10 13:23:45 pysiak kernel: CPU:    0
Sep 10 13:23:45 pysiak kernel: EIP:    0060:[simple_rmdir+39/75]    Tainted: P   VLI
Sep 10 13:23:45 pysiak kernel: EFLAGS: 00010202
Sep 10 13:23:45 pysiak kernel: EIP is at simple_rmdir+0x27/0x4b
Sep 10 13:23:45 pysiak kernel: eax: 00000000   ebx: d7e5b380   ecx: d7e5b39c   edx: ffffffd9
Sep 10 13:23:45 pysiak kernel: esi: d52a1800   edi: d3000000   ebp: d7e5b39c   esp: d3001e6c
Sep 10 13:23:45 pysiak kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 13:23:45 pysiak kernel: Process umount (pid: 3343, threadinfo=d3000000 task=d96126b0)
Sep 10 13:23:45 pysiak kernel: Stack: d7e5b380 c218d800 d7e5ba80 d7e5b380 c01845e8 d52a1800 d7e5b380 d7e5b280
Sep 10 13:23:45 pysiak kernel:        d7e5b380 c01846b6 d7e5b380 d7e5b280 cab50da4 cd292ca0 cab50c00 c049d8ec
Sep 10 13:23:45 pysiak kernel:        c0282093 cab50da4 c0498680 cab50da4 cab50d80 c02b1d9c cab50da4 c049d8a0
Sep 10 13:23:45 pysiak kernel: Call Trace:
Sep 10 13:23:45 pysiak kernel:  [remove_dir+76/111] remove_dir+0x4c/0x6f
Sep 10 13:23:45 pysiak kernel:  [sysfs_remove_dir+169/268] sysfs_remove_dir+0xa9/0x10c
Sep 10 13:23:45 pysiak kernel:  [kobject_del+89/105] kobject_del+0x59/0x69
Sep 10 13:23:45 pysiak kernel:  [device_del+104/147] device_del+0x68/0x93
Sep 10 13:23:45 pysiak kernel:  [scsi_device_put+180/210] scsi_device_put+0xb4/0xd2
Sep 10 13:23:45 pysiak kernel:  [sd_release+76/141] sd_release+0x4c/0x8d
Sep 10 13:23:45 pysiak kernel:  [blkdev_put+429/461] blkdev_put+0x1ad/0x1cd
Sep 10 13:23:45 pysiak kernel:  [blkdev_put+365/461] blkdev_put+0x16d/0x1cd
Sep 10 13:23:45 pysiak kernel:  [kill_block_super+60/72] kill_block_super+0x3c/0x48
Sep 10 13:23:45 pysiak kernel:  [deactivate_super+95/184] deactivate_super+0x5f/0xb8
Sep 10 13:23:45 pysiak kernel:  [sys_umount+63/144] sys_umount+0x3f/0x90
Sep 10 13:23:45 pysiak kernel:  [sys_oldumount+23/27] sys_oldumount+0x17/0x1b
Sep 10 13:23:45 pysiak kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 10 13:23:45 pysiak kernel:
Sep 10 13:23:45 pysiak kernel: Code: 04 31 c0 c3 83 ec 10 89 5c 24 08 89 74 24 0c 8b 5c 24 18 8b 74 24 14 89 1c 24 e8 48 ff ff ff 85 c0 ba d9 ff ff ff 74 19 8b 43 08 <83> 68 24 01 89 34 24 89 5c 24 04 e8 ad ff ff ff 31 d2 83 6e 24
Sep 10 13:24:02 pysiak kernel:  <6>usb 1-2: USB disconnect, address 4
Sep 10 13:24:02 pysiak kernel: usb-storage: storage_disconnect() called
Sep 10 13:24:02 pysiak kernel: usb-storage: usb_stor_stop_transport called
Sep 10 13:24:02 pysiak kernel: usb-storage: -- dissociate_dev

Regards,
Maciej


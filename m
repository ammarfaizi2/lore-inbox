Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUGLTCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUGLTCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUGLTC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:02:29 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:58778 "EHLO
	mwinf0903.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261987AbUGLTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:01:57 -0400
Message-ID: <40F2E01D.7050803@reolight.net>
Date: Mon, 12 Jul 2004 21:01:49 +0200
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel-Bug with USB-MASS-STORAGE
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unable to remount my hard disk without restarting my computer.
This error seems can be fully reproduced after many hours.

My USB hard disk is a seagate into a USB-To-IDE.

scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Genesys   Model: USB to IDE Disk   Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 6306048 512-byte hdwr sectors (3229 MB)





scsi0 (0:0): rejecting I/O to dead device
printk: 382 messages suppressed.
Buffer I/O error on device sda1, logical block 502
lost page write due to I/O error on sda1
slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free
all objects
 [<c01365e5>] kmem_cache_destroy+0x85/0xf3
 [<c0261e21>] scsi_destroy_command_freelist+0x59/0x87
 [<c0262b24>] scsi_host_dev_release+0x32/0x8a
 [<c02330c8>] device_release+0x58/0x5c
 [<c01d8512>] kobject_cleanup+0x98/0x9a
 [<c026a51b>] scsi_disk_put+0x30/0x52
 [<c026a8dd>] sd_release+0x3c/0x68
 [<c0151118>] blkdev_put+0x184/0x1a2
 [<c01510dc>] blkdev_put+0x148/0x1a2
 [<c014ee47>] deactivate_super+0x5b/0x8a
 [<c016396c>] sys_umount+0x3f/0x90
 [<c01639d4>] sys_oldumount+0x17/0x1b
 [<c0103f1f>] syscall_call+0x7/0xb

usb 1-5: new high speed USB device using address 3
kmem_cache_create: duplicate cache scsi_cmd_cache
------------[ cut here ]------------
kernel BUG at mm/slab.c:1392!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: ppp_async ppp_deflate bsd_comp ppp_generic slhc
zlib_deflate p4_clockmod speedstep_lib
CPU:    0
EIP:    0060:[<c01361fa>]    Not tainted
EFLAGS: 00010202   (2.6.7)
EIP is at kmem_cache_create+0x3bb/0x547
eax: 00000032   ebx: c15abf70   ecx: c045cacc   edx: c03a0c18
esi: c036ada2   edi: c036ada2   ebp: c15ab880   esp: c15b9d54
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 27, threadinfo=c15b8000 task=dfc1d130)
Stack: c0356340 c036ad93 00000080 00002000 c15b9d74 c15ab8bc ffffffff
ffffff80
       00000080 c15d4400 c03e74e0 c15d440c c03e7508 c0261d40 c036ad93
00000180
       00000080 00002000 00000000 00000000 000001d8 c15d4400 c15d45d8
c03ea8e0
Call Trace:
 [<c0261d40>] scsi_setup_command_freelist+0x74/0xfc
 [<c0262d24>] scsi_host_alloc+0x1a8/0x2a9
 [<c0114746>] default_wake_function+0x0/0x12
 [<c029fcb3>] usb_stor_acquire_resources+0xac/0x107
 [<c029ff83>] storage_probe+0xee/0x16f
 [<c0287af0>] usb_probe_interface+0x5a/0x60
 [<c0234079>] bus_match+0x3f/0x6a
 [<c02340e5>] device_attach+0x41/0x91
 [<c02342a4>] bus_add_device+0x5b/0x9f
 [<c02332dc>] device_add+0xa1/0x120
 [<c028e322>] usb_set_configuration+0x2c4/0x41c
 [<c0288938>] usb_new_device+0x9f/0x120
 [<c028a848>] hub_port_connect_change+0x170/0x330
 [<c028acd2>] hub_events+0x2ca/0x33d
 [<c028ad72>] hub_thread+0x2d/0xe4
 [<c0103df6>] ret_from_fork+0x6/0x14
 [<c0114746>] default_wake_function+0x0/0x12
 [<c028ad45>] hub_thread+0x0/0xe4
 [<c010225d>] kernel_thread_helper+0x5/0xb

Code: 0f 0b 70 05 7c 5b 35 c0 8b 0b e9 63 ff ff ff 8b 47 34 c7 04


Greeting,

-- 
Auzanneau Grégory
GPG 0x99137BEE

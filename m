Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTEEIYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTEEIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:24:29 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:42000 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S262060AbTEEIY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:24:26 -0400
Message-ID: <3EB62347.8020109@torque.net>
Date: Mon, 05 May 2003 18:39:35 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: illegal context for sleeping ... rmmod ide-cd + ide-scsi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lk 2.5.69 (and in 68) both the ide-cd and ide-scsi
modules generate a "sleeping function called from illegal
context" stack trace when removed.

After "rmmod ide-cd" this appears:
  Debug: sleeping function called from illegal context
         at include/asm/semaphore.h:119
  Call Trace:
   [<c011dcec>] __might_sleep+0x5c/0x70
   [<c025b634>] auto_remove_settings+0x24/0x80
   [<c025db8a>] ide_unregister_subdriver+0x15a/0x3d0
   [<e10d48df>] ide_cdrom_cleanup+0x2f/0x110 [ide_cd]
   [<c02346de>] driver_unregister+0x2e/0x42
   [<e10d90e0>] ide_cdrom_driver+0x0/0xd8 [ide_cd]
   [<e10d91a8>] ide_cdrom_driver+0xc8/0xd8 [ide_cd]
   [<c025e270>] ide_unregister_driver+0x100/0x1df
   [<c0155f1f>] unmap_vma_list+0x1f/0x30
   [<e10d9200>] +0x0/0x140 [ide_cd]
   [<e10d4df2>] +0x12/0x20 [ide_cd]
   [<e10d90e0>] ide_cdrom_driver+0x0/0xd8 [ide_cd]
   [<c013d336>] sys_delete_module+0x1d6/0x240
   [<c0156457>] sys_munmap+0x57/0x80
   [<c0109eaf>] syscall_call+0x7/0xb

After "rmmod ide-scsi" this appears:
  Debug: sleeping function called from illegal context
        at include/asm/semaphore.h:119
  Call Trace:
   [<e10c8068>] idescsi_driver+0xc8/0xd8 [ide_scsi]
   [<c011dcec>] __might_sleep+0x5c/0x70
   [<e10c8068>] idescsi_driver+0xc8/0xd8 [ide_scsi]
   [<c025b634>] auto_remove_settings+0x24/0x80
   [<c025db8a>] ide_unregister_subdriver+0x15a/0x3d0
   [<e10c7ff8>] idescsi_driver+0x58/0xd8 [ide_scsi]
   [<e10c7ff8>] idescsi_driver+0x58/0xd8 [ide_scsi]
   [<e10c542d>] idescsi_cleanup+0x1d/0x60 [ide_scsi]
   [<e10c7fa0>] idescsi_driver+0x0/0xd8 [ide_scsi]
   [<c025e270>] ide_unregister_driver+0x100/0x1df
   [<e10c6e87>] +0xfa/0x10f [ide_scsi]
   [<e10c8300>] +0x0/0x140 [ide_scsi]
   [<e10c663f>] +0x2f/0x50 [ide_scsi]
   [<e10c7fa0>] idescsi_driver+0x0/0xd8 [ide_scsi]
   [<c013d336>] sys_delete_module+0x1d6/0x240
   [<c0156457>] sys_munmap+0x57/0x80
   [<c0109eaf>] syscall_call+0x7/0xb

My .config has these kernel debugging options set:
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

Doug Gilbert



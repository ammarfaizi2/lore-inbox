Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWEQU7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWEQU7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 16:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWEQU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 16:59:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43748 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751117AbWEQU7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 16:59:20 -0400
Message-ID: <446B8EA6.1080306@sgi.com>
Date: Wed, 17 May 2006 15:59:18 -0500
From: Michael Reed <mdr@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>
CC: Gary Hagensen <gwh@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [BUG} 2.6.17-rc4-git5 - kobject_add fails after fibre channel switchdisable
 / switchenable
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get these messages after doing a switchdisable and waiting for the fibre channel
rports to be removed and then doing a switchenable.  It is driver agnostic.
I didn't notice these messages at this severity with rc3.  With rc3 I'd see one
every once in the while.  So, something has brought this out big time.

http://marc.theaimsgroup.com/?l=linux-scsi&m=114589164424203&w=2

and

http://marc.theaimsgroup.com/?l=linux-kernel&m=114443482812255&w=2

I think my comment in the previous posting about "missing partitions"
is a wild goose and should be ignored.

I have the recent fc transport patch applied which fixes the scan vs. delete
deadlocks but I tested both with and without.
([PATCH] fc transport: resolve scan vs delete deadlocks)

This appears to occur now for each target on the fabric.  It's no longer
intermittent.


Mike


May 17 14:08:15 duck kernel: kobject_add failed for 2:0:38:0 with -EEXIST, don't try to register things\
                               with the same name in the same directory.
May 17 14:08:15 duck kernel:
May 17 14:08:15 duck kernel: Call Trace:
May 17 14:08:15 duck kernel:  [<a000000100012560>] show_stack+0x40/0xa0
May 17 14:08:15 duck kernel:                                 sp=e00000301520fa80 bsp=e000003015209340
May 17 14:08:15 duck kernel:  [<a0000001000125f0>] dump_stack+0x30/0x60
May 17 14:08:15 duck kernel:                                 sp=e00000301520fc50 bsp=e000003015209328
May 17 14:08:15 duck kernel:  [<a00000010040da80>] kobject_add+0x3a0/0x420
May 17 14:08:15 duck kernel:                                 sp=e00000301520fc50 bsp=e0000030152092e8
May 17 14:08:15 duck kernel:  [<a0000001004e3a60>] device_add+0xe0/0x2e0
May 17 14:08:15 duck kernel:                                 sp=e00000301520fc50 bsp=e0000030152092a8
May 17 14:08:15 duck kernel:  [<a0000001005646a0>] scsi_sysfs_add_sdev+0x60/0x520
May 17 14:08:15 duck kernel:                                 sp=e00000301520fc50 bsp=e000003015209260
May 17 14:08:15 duck kernel:  [<a000000100560250>] scsi_probe_and_add_lun+0x11b0/0x1440
May 17 14:08:15 duck kernel:                                 sp=e00000301520fc50 bsp=e0000030152091f0
May 17 14:08:15 duck kernel:  [<a0000001005618a0>] __scsi_scan_target+0x720/0xb60
May 17 14:08:15 duck kernel:                                 sp=e00000301520fc70 bsp=e000003015209188
May 17 14:08:15 duck kernel:  [<a000000100562290>] scsi_scan_target+0xd0/0x100
May 17 14:08:15 duck kernel:                                 sp=e00000301520fcd0 bsp=e000003015209138
May 17 14:08:15 duck kernel:  [<a00000010056f400>] fc_scsi_scan_rport+0xe0/0x160
May 17 14:08:15 duck kernel:                                 sp=e00000301520fcd0 bsp=e000003015209110
May 17 14:08:15 duck kernel:  [<a0000001000cac40>] run_workqueue+0x1c0/0x280
May 17 14:08:15 duck kernel:                                 sp=e00000301520fcd0 bsp=e0000030152090d0
May 17 14:08:15 duck kernel:  [<a0000001000cbf90>] worker_thread+0x1d0/0x260
May 17 14:08:15 duck kernel:                                 sp=e00000301520fcd0 bsp=e0000030152090a0
May 17 14:08:15 duck kernel:  [<a0000001000d3be0>] kthread+0x220/0x2a0
May 17 14:08:15 duck kernel:                                 sp=e00000301520fd50 bsp=e000003015209058
May 17 14:08:15 duck kernel:  [<a000000100010af0>] kernel_thread_helper+0xd0/0x100
May 17 14:08:15 duck kernel:                                 sp=e00000301520fe30 bsp=e000003015209030
May 17 14:08:15 duck kernel:  [<a000000100009140>] start_kernel_thread+0x20/0x40
May 17 14:08:15 duck kernel:                                 sp=e00000301520fe30 bsp=e000003015209030
May 17 14:08:15 duck kernel: error 1

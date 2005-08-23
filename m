Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVHWLZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVHWLZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVHWLZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:25:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62936 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932130AbVHWLZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:25:12 -0400
Date: Tue, 23 Aug 2005 13:25:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: usb oops in 2.6.13-rc6-mm2
Message-ID: <20050823112509.GF16461@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

usbcore: deregistering driver usb-storage
usb 1-1: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP: 
<ffffffff803cf140>{_spin_lock+0}
PGD 1c303067 PUD 1c304067 PMD 0 
Oops: 0002 [1] SMP 
CPU 0 
Modules linked in: nls_iso8859_1 nls_cp437 vfat fat nls_base ide_cd
cdrom
Pid: 80, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff803cf140>] <ffffffff803cf140>{_spin_lock+0}
RSP: 0018:ffff81001fc75d80  EFLAGS: 00010296
RAX: ffff81001c08cdb0 RBX: ffff810019f5f8f8 RCX: ffff81001c4b14e8
RDX: 0000000000000070 RSI: ffffffff8040cfcc RDI: 0000000000000000
RBP: ffff810019f5f8a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8018ad27 R12: 0000000000000000
R13: ffff810001a23c20 R14: ffff810001a23c00 R15: 0000000000000100
FS:  00002aaaaade8b00(0000) GS:ffffffff80612880(0000)
knlGS:0000000061ad4bb0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000001c302000 CR4: 00000000000006e0
Process khubd (pid: 80, threadinfo ffff81001fc74000, task
ffff8100019f4e80)
Stack: ffffffff803cd130 ffffffff80500aa0 ffff810019f5f980
ffffffff80500aa0 
       ffffffff802a3263 ffff810019f5f9e8 ffff810019f5f8a0
ffff810019f5f8a0 
       ffffffff802a34f2 ffffffff80500880 
Call Trace:<ffffffff803cd130>{klist_remove+21}
<ffffffff802a3263>{__device_release_driver+75}
       <ffffffff802a34f2>{device_release_driver+39}
<ffffffff802a2db7>{bus_remove_device+146}
       <ffffffff802a1f75>{device_del+55}
<ffffffff802a1fbc>{device_unregister+9}
       <ffffffff802ff51c>{hub_thread+900}
<ffffffff80145e70>{autoremove_wake_function+0}
       <ffffffff802ff198>{hub_thread+0}
<ffffffff80145a70>{keventd_create_kthread+0}
       <ffffffff80145c9e>{kthread+203}
<ffffffff8012e3ae>{schedule_tail+57}
       <ffffffff8010e6ce>{child_rip+8}
<ffffffff80145a70>{keventd_create_kthread+0}
       <ffffffff80145bd3>{kthread+0} <ffffffff8010e6c6>{child_rip+0}
       

Code: f0 fe 0f 79 09 f3 90 80 3f 00 7e f9 eb f2 c3 f0 ff 0f 8b 07 
RIP <ffffffff803cf140>{_spin_lock+0} RSP <ffff81001fc75d80>
CR2: 0000000000000000

Just got this oops removing a usb-storage managed usb device.
usb-storage had been manually removed (as you can see from the kernel
message), a few seconds later I removed power from the device and the
oopsed happened right then.

-- 
Jens Axboe


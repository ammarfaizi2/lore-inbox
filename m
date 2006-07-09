Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWGIFo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWGIFo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 01:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWGIFo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 01:44:26 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:606 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161092AbWGIFoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 01:44:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=b39zTP7IAT7fTaBU+iI+QUP1j4TT+4kJWBtnREb/0eFsvCTxGkpzGgFvlxN408uEBGUk+NpMKHEIzMvBVYgXEYsVO4L5/ZWPDsvancromwg5Gbc7kZNFAoUmmoGa3LUUxh2Z/NYdo4ZTRzdcasQ3aapqRhWceP3PyvuLf8LF1ZY=
Date: Sun, 9 Jul 2006 01:05:26 -0400
To: linux-kernel@vger.kernel.org, mingo@elte.hu, arjan@infradead.org
Subject: [LOCKDEP] 2.6.18-rc1: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
Message-ID: <20060709050525.GA1149@nineveh.rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, mingo@elte.hu,
	arjan@infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    [ resending -- original msg was > 100k ]

    Hello,

    I haven't seen this one cross the LKML.  I'm seeing it in both
2.6.18-rc1 and in .17-mm6.  I hope it's useful.

    The stack backtrace and offending executable varies from boot to
boot, so lockdep messages from two boots follow, and I've posted a
full dmesg from a third boot and my .config:

http://home.columbus.rr.com/jfannin3/dmesg.txt

http://home.columbus.rr.com/jfannin3/config.txt

[   22.488000]
[   22.488000] =================================
[   22.488000] [ INFO: inconsistent lock state ]
[   22.488000] ---------------------------------
[   22.488000] inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
[   22.488000] udevd/2684 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   22.488000]  (rtc_lock){+-..}, at: [<c0278c1c>] rtc_get_rtc_time+0x2c/0x1a0
[   22.488000] {hardirq-on-W} state was registered at:
[   22.488000]   [<c0144229>] lock_acquire+0x69/0x90
[   22.488000]   [<c033c020>] _spin_lock+0x40/0x50
[   22.488000]   [<c0106fa3>] get_cmos_time+0x13/0x170
[   22.488000]   [<c048daeb>] hpet_time_init+0xb/0x70
[   22.488000]   [<c0487744>] start_kernel+0x1f4/0x470
[   22.488000]   [<c0100210>] 0xc0100210
[   22.488000] irq event stamp: 193648
[   22.488000] hardirqs last  enabled at (193647): [<c033c331>] _write_unlock_irq+0x31/0x60
[   22.488000] hardirqs last disabled at (193648): [<c0103e0f>] common_interrupt+0x1b/0x2c
[   22.488000] softirqs last  enabled at (193582): [<c012b229>] __do_softirq+0x109/0x140
[   22.488000] softirqs last disabled at (193575): [<c012b2d9>] do_softirq+0x79/0x80
[   22.488000]
[   22.488000] other info that might help us debug this:
[   22.488000] no locks held by udevd/2684.
[   22.488000]
[   22.488000] stack backtrace:
[   22.488000]  [<c0104728>] show_trace_log_lvl+0x148/0x170
[   22.488000]  [<c010591b>] show_trace+0x1b/0x20
[   22.488000]  [<c0105944>] dump_stack+0x24/0x30
[   22.488000]  [<c0142a85>] print_usage_bug+0x255/0x260
[   22.488000]  [<c0142fc7>] mark_lock+0x537/0x620
[   22.488000]  [<c01436b2>] __lock_acquire+0x602/0xdf0
[   22.488000]  [<c0144229>] lock_acquire+0x69/0x90
[   22.488000]  [<c033c476>] _spin_lock_irq+0x46/0x60
[   22.488000]  [<c0278c1c>] rtc_get_rtc_time+0x2c/0x1a0
[   22.488000]  [<c0117d02>] hpet_rtc_interrupt+0x152/0x1b0
[   22.488000]  [<c01588d1>] handle_IRQ_event+0x31/0x70
[   22.488000]  [<c01589a9>] __do_IRQ+0x99/0x110
[   22.488000]  [<c0105d97>] do_IRQ+0x47/0xa0
[   22.488000]  [<c0103e19>] common_interrupt+0x25/0x2c
[   22.488000]  [<c01440d2>] lock_release+0xb2/0x1a0
[   22.488000]  [<c033c814>] _spin_unlock+0x24/0x60
[   22.488000]  [<c016a7b0>] unmap_vmas+0x300/0x640
[   22.488000]  [<c016d84a>] exit_mmap+0x8a/0x140
[   22.488000]  [<c01227e9>] mmput+0x39/0xb0
[   22.488000]  [<c01235b3>] copy_process+0x833/0x1510
[   22.488000]  [<c01242fb>] do_fork+0x6b/0x210
[   22.488000]  [<c01011f9>] sys_clone+0x39/0x40
[   22.488000]  [<c01032f9>] sysenter_past_esp+0x56/0x8d
[   22.488000]  [<b7ef6410>] 0xb7ef6410
[   22.620000] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   22.620000] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   22.840000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   22.840000] md: bitmap version 4.39

[   22.724000]
[   22.724000] =================================
[   22.724000] [ INFO: inconsistent lock state ]
[   22.724000] ---------------------------------
[   22.724000] inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
[   22.724000] S25brltty/3382 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   22.724000]  (rtc_lock){+-..}, at: [<c0278c1c>] rtc_get_rtc_time+0x2c/0x1a0
[   22.724000] {hardirq-on-W} state was registered at:
[   22.724000]   [<c0144229>] lock_acquire+0x69/0x90
[   22.724000]   [<c033c020>] _spin_lock+0x40/0x50
[   22.724000]   [<c0106fa3>] get_cmos_time+0x13/0x170
[   22.724000]   [<c048daeb>] hpet_time_init+0xb/0x70
[   22.724000]   [<c0487744>] start_kernel+0x1f4/0x470
[   22.724000]   [<c0100210>] 0xc0100210
[   22.724000] irq event stamp: 1276
[   22.724000] hardirqs last  enabled at (1275): [<c01033bf>] restore_nocheck+0x12/0x15
[   22.724000] hardirqs last disabled at (1276): [<c0103e0f>] common_interrupt+0x1b/0x2c
[   22.724000] softirqs last  enabled at (0): [<c012314b>] copy_process+0x3cb/0x1510
[   22.724000] softirqs last disabled at (0): [<00000000>] 0x0
[   22.724000]
[   22.724000] other info that might help us debug this:
[   22.724000] no locks held by S25brltty/3382.
[   22.724000]
[   22.724000] stack backtrace:
[   22.724000]  [<c0104728>] show_trace_log_lvl+0x148/0x170
[   22.724000]  [<c010591b>] show_trace+0x1b/0x20
[   22.724000]  [<c0105944>] dump_stack+0x24/0x30
[   22.724000]  [<c0142a85>] print_usage_bug+0x255/0x260
[   22.724000]  [<c0142fc7>] mark_lock+0x537/0x620
[   22.724000]  [<c01436b2>] __lock_acquire+0x602/0xdf0
[   22.724000]  [<c0144229>] lock_acquire+0x69/0x90
[   22.724000]  [<c033c476>] _spin_lock_irq+0x46/0x60
[   22.724000]  [<c0278c1c>] rtc_get_rtc_time+0x2c/0x1a0
[   22.724000]  [<c0117d02>] hpet_rtc_interrupt+0x152/0x1b0
[   22.724000]  [<c01588d1>] handle_IRQ_event+0x31/0x70
[   22.724000]  [<c01589a9>] __do_IRQ+0x99/0x110
[   22.724000]  [<c0105d97>] do_IRQ+0x47/0xa0
[   22.724000]  [<c0103e19>] common_interrupt+0x25/0x2c
[   22.724000]  [<b7f93c0a>] 0xb7f93c0a
[   22.860000] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   22.860000] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   22.892000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   22.892000] md: bitmap version 4.39

--
Joseph Fannin
jfannin@gmail.com

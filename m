Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUE0RrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUE0RrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUE0Rpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:45:39 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:1284 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S264920AbUE0Rox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:44:53 -0400
Date: Thu, 27 May 2004 19:45:10 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:122
Message-ID: <20040527174509.GA1654@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm using pptp-linux to connect to my ADSL-provider. I've been doing this
for several years now, without significant problems. A week ago, I
upgraded

May 27 11:35:41 calvin kernel: Badness in local_bh_enable at kernel/softirq.c:122
May 27 11:35:41 calvin kernel: Call Trace:
May 27 11:35:41 calvin kernel:  [<c011ac00>] local_bh_enable+0x60/0x80
May 27 11:35:41 calvin kernel:  [<c4cc2b54>] ppp_sync_push+0x54/0x140 [ppp_synctty]
May 27 11:35:41 calvin kernel:  [<c4cc25a5>] ppp_sync_wakeup+0x25/0x60 [ppp_synctty]
May 27 11:35:41 calvin kernel:  [<c01f20e7>] pty_unthrottle+0x47/0x60
May 27 11:35:41 calvin kernel:  [<c01eefb1>] check_unthrottle+0x31/0x40
May 27 11:35:41 calvin kernel:  [<c01ef02b>] n_tty_flush_buffer+0xb/0x60
May 27 11:35:41 calvin kernel:  [<c01f2488>] pty_flush_buffer+0x48/0x60
May 27 11:35:41 calvin kernel:  [<c01ec116>] do_tty_hangup+0x2d6/0x340
May 27 11:35:41 calvin kernel:  [<c01ed387>] release_dev+0x547/0x580
May 27 11:35:41 calvin kernel:  [<c010c038>] timer_interrupt+0xb8/0xc0
May 27 11:35:41 calvin kernel:  [<c012544d>] rcu_check_quiescent_state+0x4d/0x60
May 27 11:35:41 calvin kernel:  [<c012551e>] rcu_process_callbacks+0xbe/0xe0
May 27 11:35:41 calvin kernel:  [<c011ad7a>] tasklet_action+0x3a/0x60
May 27 11:35:41 calvin kernel:  [<c0108805>] do_IRQ+0xc5/0xe0
May 27 11:35:41 calvin kernel:  [<c0106ed8>] common_interrupt+0x18/0x20
May 27 11:35:41 calvin kernel:  [<c01ed709>] tty_release+0x9/0x20
May 27 11:35:41 calvin kernel:  [<c0145532>] __fput+0xd2/0x100
May 27 11:35:41 calvin kernel:  [<c0143ee3>] filp_close+0x43/0x80
May 27 11:35:41 calvin kernel:  [<c0118795>] put_files_struct+0x55/0xc0
May 27 11:35:41 calvin kernel:  [<c01192eb>] do_exit+0x14b/0x2e0
May 27 11:35:41 calvin kernel:  [<c0119548>] do_group_exit+0x48/0x80
May 27 11:35:41 calvin kernel:  [<c0120bf9>] get_signal_to_deliver+0x199/0x2c0
May 27 11:35:41 calvin kernel:  [<c0106a65>] do_signal+0x45/0xc0
May 27 11:35:41 calvin kernel:  [<c01134ea>] recalc_task_prio+0x8a/0x1a0
May 27 11:35:41 calvin kernel:  [<c014463d>] vfs_read+0xbd/0xe0
May 27 11:35:41 calvin kernel:  [<c014482b>] sys_read+0x2b/0x60
May 27 11:35:41 calvin kernel:  [<c0106b29>] do_notify_resume+0x49/0x50
May 27 11:35:41 calvin kernel:  [<c0106d0e>] work_notifysig+0x13/0x15
May 27 11:35:41 calvin kernel:


Each time the pppd link was retried, the "Badness in..." message appeared.

This is on a 450 MHz K6-II.
-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance."-MS Q308417

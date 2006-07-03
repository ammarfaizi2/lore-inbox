Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWGCIZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWGCIZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWGCIZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:25:35 -0400
Received: from hu-out-0102.google.com ([72.14.214.207]:2745 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750909AbWGCIZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:25:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QFyIPFy2ZnbZFwGLr0xMbYkp6KBP7K0lRdMCw/zk3lthC0B/7O4djP0jywopnvSFQftwACgEWgGz02sqldtEc7c39cIVE48eUSXgopAyd2pNiPVV93bsNPGlOqFAqZ8n1tNo4nQH1QeTQAypUUbwpxtpCoydGlwBjWiUXeh0Ag4=
Message-ID: <a44ae5cd0607030125l770086e1wdbbc8e8306ce94ca@mail.gmail.com>
Date: Mon, 3 Jul 2006 01:25:33 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.17-mm5 -- inconsistent {in-softirq-W} -> {softirq-on-W} usage.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
modprobe/2881 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&dev->_xmit_lock){-+..}, at: [<c11ad5cb>] netpoll_send_skb+0x79/0xea
{in-softirq-W} state was registered at:
  [<c102d152>] lock_acquire+0x60/0x80
  [<c1200376>] _spin_lock+0x23/0x32
  [<c11af282>] dev_watchdog+0x14/0xb1
  [<c101dab2>] run_timer_softirq+0xf2/0x14a
  [<c101a691>] __do_softirq+0x55/0xb0
  [<c1004a8d>] do_softirq+0x58/0xbd
irq event stamp: 3780
hardirqs last  enabled at (3779): [<c1200800>] _spin_unlock_irqrestore+0x36/0x59
hardirqs last disabled at (3780): [<c1200581>] _spin_lock_irqsave+0xf/0x3c
softirqs last  enabled at (3544): [<c101a6e7>] __do_softirq+0xab/0xb0
softirqs last disabled at (3535): [<c1004a8d>] do_softirq+0x58/0xbd

other info that might help us debug this:
1 lock held by modprobe/2881:
 #0:  (&dev->_xmit_lock){-+..}, at: [<c11ad5cb>] netpoll_send_skb+0x79/0xea

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102b7c7>] print_usage_bug+0x1cc/0x1d9
 [<c102bd71>] mark_lock+0x23c/0x360
 [<c102bedc>] mark_held_locks+0x47/0x65
 [<c102bfe9>] trace_hardirqs_on+0xef/0x119
 [<c1200845>] _spin_unlock_irq+0x22/0x43
 [<f9099d31>] rtl8139_start_xmit+0xd9/0xff [8139too]
 [<c11ad5ea>] netpoll_send_skb+0x98/0xea
 [<c11ae2ef>] netpoll_send_udp+0x1e8/0x1f1
 [<f93160cd>] write_msg+0x40/0x67 [netconsole]
 [<c1015e8d>] __call_console_drivers+0x45/0x51
 [<c1015ee7>] _call_console_drivers+0x4e/0x52
 [<c1016003>] release_console_sem+0x118/0x1ed
 [<c1016364>] register_console+0x190/0x197
 [<f9316079>] init_netconsole+0x60/0x74 [netconsole]
 [<c1033794>] sys_init_module+0x12cc/0x14b1
 [<c1002d6d>] sysenter_past_esp+0x56/0x8d
netconsole: network logging started

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161422AbWHDVVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161422AbWHDVVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161474AbWHDVVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:21:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14546 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161422AbWHDVVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:21:52 -0400
Date: Fri, 4 Aug 2006 17:21:49 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: lockdep warning w/2.6.18rc3-git3, ipw2200
Message-ID: <20060804212149.GA2889@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eth1: no IPv6 routers present
eee80211_crypt: registered algorithm 'WEP'

=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
ip/2759 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&ifa->lock){-+..}, at: [<f8b2d836>] inet6_addr_add+0xf8/0x13e [ipv6]
{in-softirq-W} state was registered at:
  [<c043bfb9>] lock_acquire+0x4b/0x6a
  [<c0608d48>] _spin_lock_bh+0x1e/0x2d
  [<f8b2e757>] addrconf_dad_timer+0x3a/0xe2 [ipv6]
  [<c042dbc0>] run_timer_softirq+0x108/0x167
  [<c04293ab>] __do_softirq+0x78/0xf2
  [<c0406673>] do_softirq+0x5a/0xbe
irq event stamp: 3479
hardirqs last  enabled at (3479): [<c04291bf>] local_bh_enable_ip+0xc6/0xcf
hardirqs last disabled at (3477): [<c0429152>] local_bh_enable_ip+0x59/0xcf
softirqs last  enabled at (3478): [<f8b2a9ce>] ipv6_add_addr+0x210/0x254 [ipv6]
softirqs last disabled at (3466): [<c0608e17>] _read_lock_bh+0xb/0x2d

other info that might help us debug this:
1 lock held by ip/2759:
 #0:  (rtnl_mutex){--..}, at: [<c0607c98>] mutex_lock+0x21/0x24

stack backtrace:
 [<c04051ee>] show_trace_log_lvl+0x58/0x159
 [<c04057ea>] show_trace+0xd/0x10
 [<c0405903>] dump_stack+0x19/0x1b
 [<c043a402>] print_usage_bug+0x1ca/0x1d7
 [<c043a8eb>] mark_lock+0x239/0x353
 [<c043b50a>] __lock_acquire+0x459/0x997
 [<c043bfb9>] lock_acquire+0x4b/0x6a
 [<c0608d1b>] _spin_lock+0x19/0x28
 [<f8b2d836>] inet6_addr_add+0xf8/0x13e [ipv6]
 [<f8b2da39>] inet6_rtm_newaddr+0x1bd/0x1d2 [ipv6]
 [<c05b8f13>] rtnetlink_rcv_msg+0x1b3/0x1d6
 [<c05c479b>] netlink_run_queue+0x69/0xfe
 [<c05b8d16>] rtnetlink_rcv+0x29/0x42
 [<c05c4c28>] netlink_data_ready+0x12/0x50
 [<c05c3c90>] netlink_sendskb+0x1f/0x37
 [<c05c4569>] netlink_unicast+0x1a1/0x1bb
 [<c05c4c09>] netlink_sendmsg+0x275/0x282
 [<c05a823a>] sock_sendmsg+0xe8/0x103
 [<c05a8a49>] sys_sendmsg+0x14d/0x1a8
 [<c05a9c1b>] sys_socketcall+0x16b/0x186
 [<c0403faf>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
 [<c04057ea>] show_trace+0xd/0x10
 [<c0405903>] dump_stack+0x19/0x1b
 [<c043a402>] print_usage_bug+0x1ca/0x1d7
 [<c043a8eb>] mark_lock+0x239/0x353
 [<c043b50a>] __lock_acquire+0x459/0x997
 [<c043bfb9>] lock_acquire+0x4b/0x6a
 [<c0608d1b>] _spin_lock+0x19/0x28
 [<f8b2d836>] inet6_addr_add+0xf8/0x13e [ipv6]
 [<f8b2da39>] inet6_rtm_newaddr+0x1bd/0x1d2 [ipv6]
 [<c05b8f13>] rtnetlink_rcv_msg+0x1b3/0x1d6
 [<c05c479b>] netlink_run_queue+0x69/0xfe
 [<c05b8d16>] rtnetlink_rcv+0x29/0x42
 [<c05c4c28>] netlink_data_ready+0x12/0x50
 [<c05c3c90>] netlink_sendskb+0x1f/0x37
 [<c05c4569>] netlink_unicast+0x1a1/0x1bb
 [<c05c4c09>] netlink_sendmsg+0x275/0x282
 [<c05a823a>] sock_sendmsg+0xe8/0x103
 [<c05a8a49>] sys_sendmsg+0x14d/0x1a8
 [<c05a9c1b>] sys_socketcall+0x16b/0x186
 [<c0403faf>] syscall_call+0x7/0xb

Is this the same as the netlink/wireless event one discussed for
orinoco?

Bill

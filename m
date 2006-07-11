Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWGKXFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWGKXFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWGKXFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:05:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:5814 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751343AbWGKXFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:05:09 -0400
Subject: [BUG] Two BUG warnings in net/core/dev.c
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Jul 2006 16:05:06 -0700
Message-Id: <1152659106.5364.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these were seen on my laptop w/ the current (as of this writing)
-git tree using the e1000 driver after a suspend/resume cycle.

thanks
-john

BUG: warning at net/core/dev.c:1171/skb_checksum_help()
 [<c0103d69>] show_trace_log_lvl+0x149/0x170
 [<c01052bb>] show_trace+0x1b/0x20
 [<c01052e4>] dump_stack+0x24/0x30
 [<c03c7523>] skb_checksum_help+0x163/0x170
 [<c0439c15>] ip_nat_fn+0x1a5/0x210
 [<c0439fa5>] ip_nat_local_fn+0x65/0xf0
 [<c03db140>] nf_iterate+0x60/0x90
 [<c03db1cc>] nf_hook_slow+0x5c/0x100
 [<c03eca51>] ip_queue_xmit+0x1f1/0x4c0
 [<c03fd2af>] tcp_transmit_skb+0x3bf/0x7d0
 [<c03ff32f>] tcp_push_one+0x9f/0x120
 [<c03f4943>] tcp_sendmsg+0x393/0xbf0
 [<c0411595>] inet_sendmsg+0x35/0x60
 [<c03be06d>] sock_sendmsg+0xcd/0x100
 [<c03be3e3>] sys_sendto+0xd3/0x100
 [<c03be442>] sys_send+0x32/0x40
 [<c03bea32>] sys_socketcall+0x142/0x260
 [<c010320d>] sysenter_past_esp+0x56/0x8d
 [<b7fa8410>] 0xb7fa8410


BUG: warning at net/core/dev.c:1225/skb_gso_segment()
 [<c0103d69>] show_trace_log_lvl+0x149/0x170
 [<c01052bb>] show_trace+0x1b/0x20
 [<c01052e4>] dump_stack+0x24/0x30
 [<c03c8e8a>] skb_gso_segment+0x20a/0x210
 [<c03ca3bf>] dev_hard_start_xmit+0x15f/0x300
 [<c03d6cab>] __qdisc_run+0x7b/0x1f0
 [<c03ca687>] dev_queue_xmit+0x127/0x310
 [<c03d0ccc>] neigh_resolve_output+0xec/0x2a0
 [<c03ed490>] ip_output+0x170/0x260
 [<c03ecb06>] ip_queue_xmit+0x2a6/0x4c0
 [<c03fd2af>] tcp_transmit_skb+0x3bf/0x7d0
 [<c03ff32f>] tcp_push_one+0x9f/0x120
 [<c03f4943>] tcp_sendmsg+0x393/0xbf0
 [<c0411595>] inet_sendmsg+0x35/0x60
 [<c03be06d>] sock_sendmsg+0xcd/0x100
 [<c03be3e3>] sys_sendto+0xd3/0x100
 [<c03be442>] sys_send+0x32/0x40
 [<c03bea32>] sys_socketcall+0x142/0x260
 [<c010320d>] sysenter_past_esp+0x56/0x8d
 [<b7fa8410>] 0xb7fa8410



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVBFTv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVBFTv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVBFTv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:51:26 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:38323 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261288AbVBFTvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:51:12 -0500
Date: Sun, 6 Feb 2005 20:51:11 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3 BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
Message-ID: <20050206195111.GA28814@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While executing
iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport https -j DNAT --to 192.168.0.1
iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport http  -j DNAT --to 192.168.0.1
ip route del default
ip addr del 80.126.170.174 dev eth0

on a dual PIII during a shutdown:

kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
kernel: caller is get_next_corpse+0x13/0x260
kernel:  [<c010385e>] dump_stack+0x1e/0x30
kernel:  [<c024f13f>] smp_processor_id+0xaf/0xc0
kernel:  [<c0407d83>] get_next_corpse+0x13/0x260
kernel:  [<c0408006>] ip_ct_iterate_cleanup+0x36/0xc0
kernel:  [<c041896a>] masq_inet_event+0x3a/0x70
kernel:  [<c012eded>] notifier_call_chain+0x2d/0x50
kernel:  [<c03ef589>] inet_del_ifa+0x99/0x150
kernel:  [<c03efafb>] inet_rtm_deladdr+0x12b/0x170
kernel:  [<c03b1f47>] rtnetlink_rcv+0x347/0x410
kernel:  [<c03c1b10>] netlink_data_ready+0x60/0x70
kernel:  [<c03c0f71>] netlink_sendskb+0x31/0x60
kernel:  [<c03c17e9>] netlink_sendmsg+0x259/0x310
kernel:  [<c039e87b>] sock_sendmsg+0xbb/0xe0
kernel:  [<c03a0424>] sys_sendmsg+0x1c4/0x230
kernel:  [<c03a08cc>] sys_socketcall+0x21c/0x240
kernel:  [<c01029f3>] syscall_call+0x7/0xb
kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
kernel: caller is get_next_corpse+0x23f/0x260
kernel:  [<c010385e>] dump_stack+0x1e/0x30
kernel:  [<c024f13f>] smp_processor_id+0xaf/0xc0
kernel:  [<c0407faf>] get_next_corpse+0x23f/0x260
kernel:  [<c0408006>] ip_ct_iterate_cleanup+0x36/0xc0
kernel:  [<c041896a>] masq_inet_event+0x3a/0x70
kernel:  [<c012eded>] notifier_call_chain+0x2d/0x50
kernel:  [<c03ef589>] inet_del_ifa+0x99/0x150
kernel:  [<c03efafb>] inet_rtm_deladdr+0x12b/0x170
kernel:  [<c03b1f47>] rtnetlink_rcv+0x347/0x410
kernel:  [<c03c1b10>] netlink_data_ready+0x60/0x70
kernel:  [<c03c0f71>] netlink_sendskb+0x31/0x60
kernel:  [<c03c17e9>] netlink_sendmsg+0x259/0x310
kernel:  [<c039e87b>] sock_sendmsg+0xbb/0xe0
kernel:  [<c03a0424>] sys_sendmsg+0x1c4/0x230
kernel:  [<c03a08cc>] sys_socketcall+0x21c/0x240
kernel:  [<c01029f3>] syscall_call+0x7/0xb

-- 
Frank

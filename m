Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVBMTaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVBMTaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVBMTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:30:46 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:3712 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261296AbVBMTai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:30:38 -0500
Date: Sun, 13 Feb 2005 20:30:37 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: repost: 2.6.11-rc4 BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
Message-ID: <20050213193037.GA2802@janus>
References: <20050206195111.GA28814@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206195111.GA28814@janus>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 08:51:11PM +0100, Frank van Maarseveen wrote:
> While executing
> iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport https -j DNAT --to 192.168.0.1
> iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport http  -j DNAT --to 192.168.0.1

still present in -rc4:
kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6351
kernel: caller is get_next_corpse+0x13/0x260
kernel:  [<c010385e>] dump_stack+0x1e/0x30
kernel:  [<c024f60f>] smp_processor_id+0xaf/0xc0
kernel:  [<c0408c03>] get_next_corpse+0x13/0x260
kernel:  [<c0408e86>] ip_ct_iterate_cleanup+0x36/0xc0
kernel:  [<c041981a>] masq_inet_event+0x3a/0x70
kernel:  [<c012ee4d>] notifier_call_chain+0x2d/0x50
kernel:  [<c03f02d9>] inet_del_ifa+0x99/0x150
kernel:  [<c03f084b>] inet_rtm_deladdr+0x12b/0x170
kernel:  [<c03b290b>] rtnetlink_rcv+0x35b/0x420
kernel:  [<c03c26c0>] netlink_data_ready+0x60/0x70
kernel:  [<c03c1ad1>] netlink_sendskb+0x31/0x60
kernel:  [<c03c2391>] netlink_sendmsg+0x261/0x320
kernel:  [<c039f16b>] sock_sendmsg+0xbb/0xe0
kernel:  [<c03a0d14>] sys_sendmsg+0x1c4/0x230
kernel:  [<c03a11bc>] sys_socketcall+0x21c/0x240
kernel:  [<c01029f3>] syscall_call+0x7/0xb
kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6351
kernel: caller is get_next_corpse+0x23f/0x260
kernel:  [<c010385e>] dump_stack+0x1e/0x30
kernel:  [<c024f60f>] smp_processor_id+0xaf/0xc0
kernel:  [<c0408e2f>] get_next_corpse+0x23f/0x260
kernel:  [<c0408e86>] ip_ct_iterate_cleanup+0x36/0xc0
kernel:  [<c041981a>] masq_inet_event+0x3a/0x70
kernel:  [<c012ee4d>] notifier_call_chain+0x2d/0x50
kernel:  [<c03f02d9>] inet_del_ifa+0x99/0x150
kernel:  [<c03f084b>] inet_rtm_deladdr+0x12b/0x170
kernel:  [<c03b290b>] rtnetlink_rcv+0x35b/0x420
kernel:  [<c03c26c0>] netlink_data_ready+0x60/0x70
kernel:  [<c03c1ad1>] netlink_sendskb+0x31/0x60
kernel:  [<c03c2391>] netlink_sendmsg+0x261/0x320
kernel:  [<c039f16b>] sock_sendmsg+0xbb/0xe0
kernel:  [<c03a0d14>] sys_sendmsg+0x1c4/0x230
kernel:  [<c03a11bc>] sys_socketcall+0x21c/0x240
kernel:  [<c01029f3>] syscall_call+0x7/0xb

-- 
Frank

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVBFUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVBFUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVBFUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 15:05:29 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:26613 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261305AbVBFUFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 15:05:19 -0500
Message-ID: <4206787F.8060508@tiscali.de>
Date: Sun, 06 Feb 2005 21:05:19 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3 BUG: using smp_processor_id() in preemptible [00000001]
 code: ip/6840
References: <20050206195111.GA28814@janus>
In-Reply-To: <20050206195111.GA28814@janus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:

>While executing
>iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport https -j DNAT --to 192.168.0.1
>iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport http  -j DNAT --to 192.168.0.1
>ip route del default
>ip addr del 80.126.170.174 dev eth0
>
>on a dual PIII during a shutdown:
>
>kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
>kernel: caller is get_next_corpse+0x13/0x260
>kernel:  [<c010385e>] dump_stack+0x1e/0x30
>kernel:  [<c024f13f>] smp_processor_id+0xaf/0xc0
>kernel:  [<c0407d83>] get_next_corpse+0x13/0x260
>kernel:  [<c0408006>] ip_ct_iterate_cleanup+0x36/0xc0
>kernel:  [<c041896a>] masq_inet_event+0x3a/0x70
>kernel:  [<c012eded>] notifier_call_chain+0x2d/0x50
>kernel:  [<c03ef589>] inet_del_ifa+0x99/0x150
>kernel:  [<c03efafb>] inet_rtm_deladdr+0x12b/0x170
>kernel:  [<c03b1f47>] rtnetlink_rcv+0x347/0x410
>kernel:  [<c03c1b10>] netlink_data_ready+0x60/0x70
>kernel:  [<c03c0f71>] netlink_sendskb+0x31/0x60
>kernel:  [<c03c17e9>] netlink_sendmsg+0x259/0x310
>kernel:  [<c039e87b>] sock_sendmsg+0xbb/0xe0
>kernel:  [<c03a0424>] sys_sendmsg+0x1c4/0x230
>kernel:  [<c03a08cc>] sys_socketcall+0x21c/0x240
>kernel:  [<c01029f3>] syscall_call+0x7/0xb
>kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
>kernel: caller is get_next_corpse+0x23f/0x260
>kernel:  [<c010385e>] dump_stack+0x1e/0x30
>kernel:  [<c024f13f>] smp_processor_id+0xaf/0xc0
>kernel:  [<c0407faf>] get_next_corpse+0x23f/0x260
>kernel:  [<c0408006>] ip_ct_iterate_cleanup+0x36/0xc0
>kernel:  [<c041896a>] masq_inet_event+0x3a/0x70
>kernel:  [<c012eded>] notifier_call_chain+0x2d/0x50
>kernel:  [<c03ef589>] inet_del_ifa+0x99/0x150
>kernel:  [<c03efafb>] inet_rtm_deladdr+0x12b/0x170
>kernel:  [<c03b1f47>] rtnetlink_rcv+0x347/0x410
>kernel:  [<c03c1b10>] netlink_data_ready+0x60/0x70
>kernel:  [<c03c0f71>] netlink_sendskb+0x31/0x60
>kernel:  [<c03c17e9>] netlink_sendmsg+0x259/0x310
>kernel:  [<c039e87b>] sock_sendmsg+0xbb/0xe0
>kernel:  [<c03a0424>] sys_sendmsg+0x1c4/0x230
>kernel:  [<c03a08cc>] sys_socketcall+0x21c/0x240
>kernel:  [<c01029f3>] syscall_call+0x7/0xb
>
>  
>
Hi!
You have to use get_cpu() or __smp_processor_id() to avoid this debug 
message.
Have a look at inlcude/linux/smp.h and include/asm-i386/smp.h.

Matthias-Christian Ott

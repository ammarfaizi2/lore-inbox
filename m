Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVBNODu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVBNODu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 09:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVBNODu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 09:03:50 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:31694 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261431AbVBNODq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 09:03:46 -0500
Message-ID: <4210AFC5.2030807@tiscali.de>
Date: Mon, 14 Feb 2005 15:03:49 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: repost: 2.6.11-rc4 BUG: using smp_processor_id() in preemptible
 [00000001] code: ip/6840
References: <20050206195111.GA28814@janus> <20050213193037.GA2802@janus>
In-Reply-To: <20050213193037.GA2802@janus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:

>On Sun, Feb 06, 2005 at 08:51:11PM +0100, Frank van Maarseveen wrote:
>  
>
>>While executing
>>iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport https -j DNAT --to 192.168.0.1
>>iptables -t nat -D OUTPUT -d 80.126.170.174 -p tcp --dport http  -j DNAT --to 192.168.0.1
>>    
>>
>
>still present in -rc4:
>kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6351
>kernel: caller is get_next_corpse+0x13/0x260
>kernel:  [<c010385e>] dump_stack+0x1e/0x30
>kernel:  [<c024f60f>] smp_processor_id+0xaf/0xc0
>kernel:  [<c0408c03>] get_next_corpse+0x13/0x260
>kernel:  [<c0408e86>] ip_ct_iterate_cleanup+0x36/0xc0
>kernel:  [<c041981a>] masq_inet_event+0x3a/0x70
>kernel:  [<c012ee4d>] notifier_call_chain+0x2d/0x50
>kernel:  [<c03f02d9>] inet_del_ifa+0x99/0x150
>kernel:  [<c03f084b>] inet_rtm_deladdr+0x12b/0x170
>kernel:  [<c03b290b>] rtnetlink_rcv+0x35b/0x420
>kernel:  [<c03c26c0>] netlink_data_ready+0x60/0x70
>kernel:  [<c03c1ad1>] netlink_sendskb+0x31/0x60
>kernel:  [<c03c2391>] netlink_sendmsg+0x261/0x320
>kernel:  [<c039f16b>] sock_sendmsg+0xbb/0xe0
>kernel:  [<c03a0d14>] sys_sendmsg+0x1c4/0x230
>kernel:  [<c03a11bc>] sys_socketcall+0x21c/0x240
>kernel:  [<c01029f3>] syscall_call+0x7/0xb
>kernel: BUG: using smp_processor_id() in preemptible [00000001] code: ip/6351
>kernel: caller is get_next_corpse+0x23f/0x260
>kernel:  [<c010385e>] dump_stack+0x1e/0x30
>kernel:  [<c024f60f>] smp_processor_id+0xaf/0xc0
>kernel:  [<c0408e2f>] get_next_corpse+0x23f/0x260
>kernel:  [<c0408e86>] ip_ct_iterate_cleanup+0x36/0xc0
>kernel:  [<c041981a>] masq_inet_event+0x3a/0x70
>kernel:  [<c012ee4d>] notifier_call_chain+0x2d/0x50
>kernel:  [<c03f02d9>] inet_del_ifa+0x99/0x150
>kernel:  [<c03f084b>] inet_rtm_deladdr+0x12b/0x170
>kernel:  [<c03b290b>] rtnetlink_rcv+0x35b/0x420
>kernel:  [<c03c26c0>] netlink_data_ready+0x60/0x70
>kernel:  [<c03c1ad1>] netlink_sendskb+0x31/0x60
>kernel:  [<c03c2391>] netlink_sendmsg+0x261/0x320
>kernel:  [<c039f16b>] sock_sendmsg+0xbb/0xe0
>kernel:  [<c03a0d14>] sys_sendmsg+0x1c4/0x230
>kernel:  [<c03a11bc>] sys_socketcall+0x21c/0x240
>kernel:  [<c01029f3>] syscall_call+0x7/0xb
>
>  
>
Than fix it, the way I mentioned.

Matthias-Christian Ott

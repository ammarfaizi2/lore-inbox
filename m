Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967810AbWK3BtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967810AbWK3BtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967812AbWK3BtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:49:08 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:17159
	"HELO linuxace.com") by vger.kernel.org with SMTP id S967810AbWK3BtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:49:04 -0500
Date: Wed, 29 Nov 2006 17:49:04 -0800
From: Phil Oester <kernel@linuxace.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-netdev@vger.kernel.org
Subject: Re: Linux 2.6.19
Message-ID: <20061130014904.GA1405@linuxace.com>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org> <20061129151111.6bd440f9.rdunlap@xenotime.net> <20061130005631.GA3896@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130005631.GA3896@yggdrasil.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting an oops on boot here, caused by commit
e81c73596704793e73e6dbb478f41686f15a4b34 titled
"[NET]: Fix MAX_HEADER setting".

Reverting that patch fixes things up for me.  Dave?

Phil



Bringing up interface eth0:  
skb_over_panic: text:c02af809 len:56 put:16 head:d7e213c0
data:d7e213d0 tail:d7e21408 end:d7e21400 dev:eth0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:93!
invalid opcode: 0000 [#1]
CPU:    0
EIP:    0060:[<c0244659>]    Not tainted VLI
EFLAGS: 00010296   (2.6.19 #1)
EIP is at skb_over_panic+0x59/0x70
eax: 0000006f   ebx: d7e213c0   ecx: ffffffff   edx: c03102c0
esi: d7e4f000   edi: d7e213f8   ebp: d7e4f000   esp: c037aec4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=c037a000 task=c03023e0 task.ti=c0347000)
Stack: c02fbb9c c02af809 00000038 00000010 d7e213c0 d7e213d0 d7e21408 d7e21400
       d7e4f000 00000010 d6e84520 c02af80e d6c718a0 c037af6c 0000003a 00000010
       c037af6c d6c718a0 d6c09920 d79749c0 00000001 00000000 000002ff 00000000
Call Trace:
 [<c02af809>] ndisc_send_rs+0x399/0x3e0
 [<c02af80e>] ndisc_send_rs+0x39e/0x3e0
 [<c02a4132>] addrconf_dad_completed+0x82/0xc0
 [<c02a6595>] addrconf_dad_timer+0xe5/0xf0
 [<c0214799>] e100_poll+0x259/0x420
 [<c0117330>] it_real_fn+0x0/0x60
 [<c011bcdf>] cascade+0x3f/0x60
 [<c02a64b0>] addrconf_dad_timer+0x0/0xf0
 [<c011bdeb>] run_timer_softirq+0xab/0x170
 [<c01188c2>] __do_softirq+0x42/0xa0
 [<c01053c0>] do_softirq+0x60/0xb0
 [<c012eea0>] handle_edge_irq+0x0/0x110
 [<c0105495>] do_IRQ+0x85/0xe0
 [<c02c707e>] schedule+0x29e/0x580
 [<c0103586>] common_interrupt+0x1a/0x20
 [<c01018f2>] default_idle+0x32/0x60
 [<c0101962>] cpu_idle+0x42/0x60
 [<c0348733>] start_kernel+0x283/0x330
 [<c0348250>] unknown_bootoption+0x0/0x260
 =======================
Code: 00 00 89 5c 24 14 8b 98 8c 00 00 00 89 54 24 0c 89 5c 24 10 8b 40 60 89 4c 2
4 04 c7 04 24 9c bb 2f c0 89 44 24 08 e8 47 07 ed ff <0f> 0b 5d 00 a4 91 2f c0 83
c4 24 5b 5e c3 89 f6 8d bc 27 00 00
EIP: [<c0244659>] skb_over_panic+0x59/0x70 SS:ESP 0068:c037aec4

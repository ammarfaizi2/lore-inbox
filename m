Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUBAKDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUBAKDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:03:52 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:49819 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S265233AbUBAKDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:03:50 -0500
From: Michael Neuffer <neuffer@neuffer.info>
Date: Sun, 1 Feb 2004 11:03:40 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shuchen@realtek.com.tw
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040201100340.GA12436@neuffer.info>
References: <20040130014108.09c964fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130014108.09c964fd.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Andrew Morton (akpm@osdl.org):
> [...] 
> +bk-netdev.patch
> 
>  Latest experimental netdev tree

The patch to r8169.c from the netdev patch clearly increases stability

The 2.6.2-rc2 kernel hangs within minutes even on very light load, whereas
2.6.2-rc2-mm2-1 holds up under heavy network traffic repeatably for
over half an hour before it hangs and somewhat longer under light traffic.

It is definitely the RTL-8169 interface since I can not get the kernel
to hang using a different (RTL-8139C) controller connected to the same 
Gigabit switch.

After many tests I was finally able to capture an Oops:
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c02f6a7a>]   Not tainted VLI
EFLAGS: 00010216
EIP is at rtl8169_rx_interrupt+0x7a/0x280
eax: 0000000f7  ebx: 3281c0f7   ecx: efcec200   edx: 00000000
esi: eecc2070   edi: 00000007   ebp: 000000f3   esp: e99a9fc2
ds: 007b   es: 007b   ss: 0068
Process setiathome (pid: 1817, threadinfo=e99a8000 task=e9a92240)
Stack: ed7d5600 efcec000 efcec000 e99a9f68 eecc2070 00000000 00000001 f3851000
       00000014 e99a8000 c02f6d62 efcec000 efcec200 f3851000 00000001 efcec200
       ef00ef00 04000001 00000000 e99a9fc4 c010e06a 00000013 efcec000 e99a9fc4
Call Trace:
 [<c02f6d62>] rtl8169_interrupt+0xe2/0xf0
 [<c010e06a>] handle_IRQ_event+0x3a/0x70
 [<c010e401>] do_IRQ+0x91/0x130
 [<c0491cdc>] common_interrupt+0x18/0x20

Code: 24 14 89 d8 25 ff 1f 00 00 8d 68 fc 3b 2d 38 12 58 c0 0f 8c 3f 01 00 00 8b
 4c 24 30 c7 84 b9 90 00 00 00 00 00 00 00 8b 54 24 14 <8b> 42 68 85 c0 0f 85 14
 01 00 00 8b 82 a0 00 00 00 01 6a 64 01
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler not syncing


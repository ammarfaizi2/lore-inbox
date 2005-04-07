Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVDGWtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVDGWtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVDGWtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:49:07 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32643 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262624AbVDGWsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:48:08 -0400
Message-ID: <4255B868.6040600@engr.sgi.com>
Date: Thu, 07 Apr 2005 15:47:04 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
Cc: johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>	 <20050331144428.7bbb4b32.akpm@osdl.org>  <424C9177.1070404@engr.sgi.com> <1112341968.9334.109.camel@uganda> <4255B6D2.7050102@engr.sgi.com>
In-Reply-To: <4255B6D2.7050102@engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, when it happened last time, my program listening to the socket
complained about duplicate messages received.

    Unmatched seq. Rcvd=1824062, expected=1824061   <===
    Unmatched seq. Rcvd=1824062, expected=1824063   <===
    Unmatched seq. Rcvd=1824348, expected=1824307

When my program received 1824062 while expecting 1824061
it adjusted itself to expect the next one being 1824063. But instead
the message of 1824062 arrived the second time.

    - jay


Jay Lan wrote:

> Hi Evgeniy,
>
> Should i be concerned about this bugcheck?
>
> I have seen this happening a number of times, all with the same signature
> in my testing. I ran a mix of AIM7,  ubench,  fork-test (continuously 
> fork new
> processes), and another program reading from the fork connector socket.
>
> Thanks,
> - jay
>
>
>
> cqueue/1[656]: bugcheck! 0 [1]
> Modules linked in: nfs lockd sunrpc sg st sr_mod ipv6 usbcore
>
> Pid: 656, CPU 1, comm:             cqueue/1
> psr : 00001010085a6010 ifs : 8000000000000289 ip  : 
> [<a0000001005cee50>]    Not tainted
> ip is at __kfree_skb+0x1b0/0x220
> unat: 0000000000000000 pfs : 0000000000000289 rsc : 0000000000000003
> rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000009641
> ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
> csd : 0000000000000000 ssd : 0000000000000000
> b0  : a0000001005cee50 b6  : a00000010000e7e0 b7  : a0000001003ae440
> f6  : 0fffbccccccccc8c00000 f7  : 0ffdaa200000000000000
> f8  : 100008000000000000000 f9  : 10002a000000000000000
> f10 : 0fffcccccccccc8c00000 f11 : 1003e0000000000000000
> r1  : a000000100c0ec00 r2  : 0000000000004000 r3  : 0000000000004000
> r8  : 0000000000000028 r9  : a0000001008eaac8 r10 : 0000000000000004
> r11 : 0000000000000028 r12 : e00000307a99fd60 r13 : e00000307a998000
> r14 : a000000100887c00 r15 : a000000100a24b18 r16 : a000000100a22e18
> r17 : ffffffffffffffff r18 : a000000100887bec r19 : a000000100a9080f
> r20 : 0000000000003517 r21 : 00000000000fffff r22 : 0000000000000034
> r23 : 0000000000000034 r24 : a000000100a90810 r25 : 0000000000003518
> r26 : 0000000000003518 r27 : 00000010085a6010 r28 : a000000100a90811
> r29 : 0000000000003519 r30 : 0000000000000000 r31 : a000000100a24ae8
>
> Call Trace:
> [<a0000001000126a0>] show_stack+0x80/0xa0
>                                sp=e00000307a99f920 bsp=e00000307a999078
> [<a000000100012f00>] show_regs+0x840/0x880
>                                sp=e00000307a99faf0 bsp=e00000307a999018
> [<a000000100034890>] die+0x150/0x1c0
>                                sp=e00000307a99fb00 bsp=e00000307a998fd0
> [<a000000100034940>] die_if_kernel+0x40/0x60
>                                sp=e00000307a99fb00 bsp=e00000307a998fa0
> [<a000000100035d20>] ia64_bad_break+0x300/0x380
>                                sp=e00000307a99fb00 bsp=e00000307a998f78
> [<a00000010000b5e0>] ia64_leave_kernel+0x0/0x280
>                                sp=e00000307a99fb90 bsp=e00000307a998f78
> [<a0000001005cee50>] __kfree_skb+0x1b0/0x220
>                                sp=e00000307a99fd60 bsp=e00000307a998f30
> [<a00000010044f630>] kfree_skb+0x50/0xa0
>                                sp=e00000307a99fd60 bsp=e00000307a998f10
> [<a00000010044e400>] cn_queue_wrapper+0xe0/0x100
>                                sp=e00000307a99fd60 bsp=e00000307a998ee8
> [<a0000001000cb880>] worker_thread+0x3e0/0x520
>                                sp=e00000307a99fd60 bsp=e00000307a998e60
> [<a0000001000d7210>] kthread+0x290/0x300
>                                sp=e00000307a99fdd0 bsp=e00000307a998e20
> [<a000000100010a00>] kernel_thread_helper+0xe0/0x100
>                                sp=e00000307a99fe30 bsp=e00000307a998df0
> [<a000000100009120>] start_kernel_thread+0x20/0x40
>                                sp=e00000307a99fe30 bsp=e00000307a998df0
>
>
>


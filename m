Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUCaTw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUCaTw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:52:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:43240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262370AbUCaTw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 14:52:26 -0500
Date: Wed, 31 Mar 2004 11:52:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Craig, Dave" <dwcraig@qualcomm.com>
Cc: list@noduck.net, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-Id: <20040331115213.225dd70b.akpm@osdl.org>
In-Reply-To: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com>
References: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Craig, Dave" <dwcraig@qualcomm.com> wrote:
>
> cascade: c1a1d5e0 != c1a0d5e0
>  hander=c028ee8d (igmp_ifc_timer_expire+0x0/0x3e)
>  Call Trace:
>   [<c012ca73>] cascade+0x79/0xa1
>   [<c028ee8d>] igmp_ifc_timer_expire+0x0/0x3e
>   [<c012d0b3>] run_timer_softirq+0x159/0x1c9
>   [<c012899d>] do_softirq+0xc9/0xcb
>   [<c0119c46>] smp_apic_timer_interrupt+0xd8/0x140
>   [<c0108c09>] default_idle+0x0/0x32
>   [<c010bab2>] apic_timer_interrupt+0x1a/0x20
>   [<c0108c09>] default_idle+0x0/0x32
>   [<c0108c36>] default_idle+0x2d/0x32
>   [<c0108cb4>] cpu_idle+0x3a/0x43
>   [<c0105000>] rest_init+0x0/0x68
>   [<c039c89f>] start_kernel+0x1b7/0x209
>   [<c039c427>] unknown_bootoption+0x0/0x124
> 
>  Here is the result.  I am doing a lot of IPv4 multicast.

There's only a single bit difference between the expected and actual
timer->base value.  So either your machine has flakey memory or the percpu
data area happened to be separated by 64k.

Is the machine SMP?  If so can you please run

	nm vmliunx | grep __per_cpu

and send the output?

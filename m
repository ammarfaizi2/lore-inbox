Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUCaVnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUCaVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:41:15 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:59025 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S262605AbUCaVja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:39:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel BUG at kernel/timer.c:370!
Date: Wed, 31 Mar 2004 13:39:13 -0800
Message-ID: <0320111483D8B84AAAB437215BBDA526847F7F@NAEX01.na.qualcomm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel BUG at kernel/timer.c:370!
Thread-Index: AcQXWxx80Xzu4s4NQICLh1VZefaWNgADWH2g
From: "Craig, Dave" <dwcraig@qualcomm.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <list@noduck.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Mar 2004 21:39:14.0602 (UTC) FILETIME=[9CAFC8A0:01C41768]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure thing.

7ecb001b A __crc___per_cpu_offset
c033a510 r __kcrctab___per_cpu_offset
c033c462 r __kstrtab___per_cpu_offset
c03366c4 r __ksymtab___per_cpu_offset
c040bd90 A __per_cpu_end
c040c020 B __per_cpu_offset
c04090a0 A __per_cpu_start

It is a dual processor and the processors are hyperthreaded.

	Dave

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
Sent: Wednesday, March 31, 2004 11:52 AM
To: Craig, Dave
Cc: list@noduck.net; linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!

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
timer->base value.  So either your machine has flakey memory or the
percpu
data area happened to be separated by 64k.

Is the machine SMP?  If so can you please run

	nm vmliunx | grep __per_cpu

and send the output?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



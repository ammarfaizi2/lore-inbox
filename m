Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbTLINhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTLINhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:37:47 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:18314 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265796AbTLINhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:37:40 -0500
Message-ID: <3FD5CFE1.8080800@cyberone.com.au>
Date: Wed, 10 Dec 2003 00:36:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@zwane.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
References: <20031209045929.437362C002@lists.samba.org>
In-Reply-To: <20031209045929.437362C002@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>In message <3FD3FD52.7020001@cyberone.com.au> you write:
>
>>I'm not aware of any reason why the kernel should not become generally
>>SMT aware. It is sufficiently different to SMP that it is worth
>>specialising it, although I am only aware of P4 and POWER5 implementations.
>>
>
>To do it properly, it should be done within the NUMA framework.  That
>would allow generic slab cache optimizations, etc.  We'd really need a
>multi-level NUMA framework for this though.
>
>But patch looks fine.
>

Well if (something like) cpu_sibling_map is to become architecture
independant code, it should probably get something like cpu_to_package,
package_to_cpumask sort of things like NUMA has.

I don't know if SMT should become just another level of NUMA because
its not NUMA of course. For the scheduler it seems to make sense because
SMT/SMP/NUMA basically want slight variations of the same thing.

Possibly as you say slab cache could be SMTed, but I'm not convinced
that SMT and NUMA should become inseperable. Anyway I doubt 2.6 will
see a general multi level NUMA framework.

>
>>I have an alternative to Ingo's HT scheduler which basically does
>>the same thing. It is showing a 20% elapsed time improvement with a
>>make -j3 on a 2xP4 Xeon (4 logical CPUs).
>>
>
>Me too.
>
>My main argument with Ingo's patch (last I looked) was technical: the
>code becomes clearer if the structures are explicitly split into the
>"per-runqueue stuff" and the "per-cpu stuff" (containing a my_runqueue
>pointer).
>

Ahh so yours isn't an earlier/later version of the same implementation..

>
>I'd be very interested in your patch though, Nick.
>

I've just had hard to trace bug report with it, but there is some
interest in it now so I'll work on sorting it out and getting
something out for testing and review. Sorry for the delay.



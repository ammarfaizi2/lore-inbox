Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTKXPUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTKXPUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:20:37 -0500
Received: from relay-3m.club-internet.fr ([194.158.104.42]:33440 "EHLO
	relay-3m.club-internet.fr") by vger.kernel.org with ESMTP
	id S263650AbTKXPUg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:20:36 -0500
From: pinotj@club-internet.fr
To: manfred@colorfullife.com
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Mon, 24 Nov 2003 16:20:31 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069687231.18953.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to be late,

>De: Linus Torvalds <torvalds@osdl.org>
[...]
>> Summary: Oops reproductible when heavy load, bug in mm/slab.c
>
>Do you have CONFIG_PREEMPT on, and if so, does it go away if you compile without PREEMPT? We have at least one other bug that seems to be dependent on CONFIG_PREEMPT

I compiled without PREEMPT and first it seemed good. I could compile again a kernel without problem.
But later, I got the same oops when doing something else
(like `./configure` in parallele with a `make install` on other tty) so CONFIG_PREEMPT doesn't seem to be the cause, unfortunately, but a parameter than can affect the probability of getting the oops.

>De: Manfred Spraul <manfred@colorfullife.com>
[...]
>>slab: double free detected in cache 'buffer_head', objp cc3f9798, objnr 26, slabp cc3f9000, s_mem cc3f9180 bufctl f7ffffff.  
>>
>Good.
>
>+#define BUFCTL_END	0xfeffFFFF
>+#define BUFCTL_FREE	0xf7ffFFFE
>+#define	SLAB_LIMIT	0xf0ffFFFD

This seems to solve the problem, no oops during kernel compilation. Unfortunately, considering what I wrote just above, I'm not so sure it's really solved. Now I will use the 2.6.0-test10 and make again tests (alone, with this patch, with PREEMPT_CONFIG=n)

>f7ffffff is not a valid value, slab never writes that into a bufctl. 
>Someone did a ++ or "|= 1", or a hw bug.
>I think the Athlon cpus have ECC for the L2 cache - could you check in 
>the bios that ECC checking is enabled?

Well, cheap mainboard (VIA K7S5A) with cheap BIOS. I can only {en,dis}able cache L1/L2, nothing about ECC. DRAM is set to safe.
But as I said, I got no problem with 2.6.0-test9 vanilla. I compiled all my LFS/BLFS with it during several days.
I even use it these days as rescue kernel to compile the others.

Thanks for your help,

Jerome Pinot


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293237AbSCOVAa>; Fri, 15 Mar 2002 16:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293238AbSCOVAV>; Fri, 15 Mar 2002 16:00:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41360 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293237AbSCOVAB>;
	Fri, 15 Mar 2002 16:00:01 -0500
Date: Fri, 15 Mar 2002 20:55:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Joe Korty <joe.korty@ccur.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
In-Reply-To: <200203152054.UAA27581@rudolph.ccur.com>
Message-ID: <Pine.LNX.4.44.0203152053001.21386-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Joe Korty wrote:

> - ksoftirqd() - change daemon nice(2) value from 19 to -19.

this is broken. The goal is to reduce softirq load during overload
situations. The default policy should be "do not allow external network
load to make your system essentially unusuable". Those who want to allow
this nevertheless can renice ksoftirqd manually.

> - reschedule_idle() - smp_send_reschedule when setting idle's need_resched
> 
>     Idle tasks nowdays don't spin waiting for need->resched to change,
>     they sleep on a halt insn instead.  Therefore any setting of
>     need->resched on an idle task running on a remote CPU should be
>     accompanied by a cross-processor interrupt.

this is broken as well. Check out the idle=poll feature i wrote some time
ago.

	Ingo


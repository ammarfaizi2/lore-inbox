Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbTCGFrm>; Fri, 7 Mar 2003 00:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbTCGFrl>; Fri, 7 Mar 2003 00:47:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18314 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261361AbTCGFrl>;
	Fri, 7 Mar 2003 00:47:41 -0500
Date: Fri, 7 Mar 2003 06:57:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303070653050.2873-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> The multi-second "freezes" are the thing that bothered me, and those
> were definitely due to the fact that X was competing as a
> _non_interactive member against other non-interactive members, causing
> it to still get 10% of the CPU, but only every few seconds. So you'd get
> a very bursty behaviour with very visible pauses.

this is only part of what happens in the 'X freeze' case. A CPU hog
competing against another CPU hog can never result in a multi-second
freeze, unless the system is hopelessly overloaded.

What happens is that the CPU-hog estimation is off for compile jobs, and
that _they_ end up being partly interactive, and starve X which does
happen to fall into the CPU-hog category briefly. The 10-15 seconds
timeout is the starvation limit kicking in.

so the correct approach is both to make X more interactive (your patch),
_and_ to make the compilation jobs less interactive (my patch). This is
that explains why Andrew saw roughly similar interactivity with you and my
patch applied separately, but the best result was when the combo patch was
applied. Agreed?

	Ingo


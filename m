Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284644AbRL0IjZ>; Thu, 27 Dec 2001 03:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286167AbRL0IjO>; Thu, 27 Dec 2001 03:39:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42167 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284644AbRL0Ii6>;
	Thu, 27 Dec 2001 03:38:58 -0500
Date: Thu, 27 Dec 2001 11:36:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Ashok Raj <ashokr2@attbi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: softirq question...
In-Reply-To: <3C277D28.103FE1AF@mvista.com>
Message-ID: <Pine.LNX.4.33.0112271131200.5266-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Dec 2001, george anzinger wrote:

> I tried a simple loop till done approach and found some issue in the
> keyboard driver where the tasklet was in the queue but disabled.  The
> handler just reinserted it in the queue and flagged it as ready, thus
> looping forever in the boot code.  How did you solve this problem?

i've changed the tasklet code so that this loop does not cause problems,
by reusing the SCHED bit:

+        * Being able to clear the SCHED bit from 1 to 0 means
+        * we got the right to handle this tasklet.
+        * Setting it from 0 to 1 means we can queue it.

	Ingo


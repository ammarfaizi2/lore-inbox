Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293403AbSCOWPt>; Fri, 15 Mar 2002 17:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293407AbSCOWPi>; Fri, 15 Mar 2002 17:15:38 -0500
Received: from users.ccur.com ([208.248.32.211]:25523 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293403AbSCOWPb>;
	Fri, 15 Mar 2002 17:15:31 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203152214.WAA27958@rudolph.ccur.com>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
To: mingo@elte.hu
Date: Fri, 15 Mar 2002 17:14:20 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <Pine.LNX.4.44.0203152156270.23324-100000@elte.hu> from "Ingo Molnar" at Mar 15, 2002 09:57:06 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> but even in the Athlon case an IPI is still an IRQ entry, which will add
>>> at least 200 cycles or more to the idle wakeup latency.
>> 
>> It is an idle cpu that is spending those 200 cycles.
> 
> wrong. When it's woken up it's *not* an idle CPU anymore, and it's the
> freshly woken up task that is going to execute 200 cycles later...

I have to disagree.  It is the woken up task *running on the
otherwise idle CPU* that burns up 200 cycles at the tail.

A cpu is wasting, say, 5,000,000 cycles (1GHz/100/2, or 1/2 tick) in
hlt when it could have been doing work.  Why worry about an
alternative wakeup path that burns up 200-400 cycles of that on the
otherwise idling cpu, even if it is at the tail.

Joe

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286316AbSAHO5A>; Tue, 8 Jan 2002 09:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288083AbSAHO4u>; Tue, 8 Jan 2002 09:56:50 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:39687 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286316AbSAHO4o>;
	Tue, 8 Jan 2002 09:56:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 16:00:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <20020108142117.F3221@inspiron.school.suse.de> <20020108133335.GB26307@krispykreme>
In-Reply-To: <20020108133335.GB26307@krispykreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Nxjg-00009W-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 02:33 pm, Anton Blanchard wrote:
> Andrea Arcangeli [apparently] wrote:
> > So yes, mean latency will decrease with preemptive kernel, but your CPU
> > is definitely paying something for it.
> 
> And Andrew Morton's work suggests he can do a much better job of
> reducing latency than -preempt.

That's not a particularly clueful comment, Anton.  Obviously, any 
latency-busting hacks that Andrew does could also be patched into a
-preempt kernel.

What a preemptible kernel can do that a non-preemptible kernel can't is: 
reschedule exactly as often as necessary, instead of having lots of extra 
schedule points inserted all over the place, firing when *they* think the 
time is right, which may well be earlier than necessary.

The preemptible approach is much less of a maintainance headache, since 
people don't have to be constantly doing audits to see if something changed, 
and going in to fiddle with scheduling points.

Finally, with preemption, rescheduling can be forced with essentially zero 
latency in response to an arbitrary interrupt such as IO completion, whereas 
the non-preemptive kernel will have to 'coast to a stop'.  In other words, 
the non-preemptive kernel will have little lags between successive IOs, 
whereas the preemptive kernel can submit the next IO immediately.  So there 
are bound to be loads where the preemptive kernel turns in better latency 
*and throughput* than the scheduling point hack.

Mind you, I'm not devaluing Andrew's work, it's good and valuable.  However 
it's good to be aware of why that approach can't equal the latency-busting 
performance of the preemptive approach.

--
Daniel

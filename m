Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbVGNKZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVGNKZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVGNKZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:25:45 -0400
Received: from khc.piap.pl ([195.187.100.11]:1284 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262985AbVGNKZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:25:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org>
	<200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	<20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	<Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	<20050713184227.GB2072@ucw.cz>
	<Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 14 Jul 2005 12:25:40 +0200
In-Reply-To: <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 13 Jul 2005 12:10:48 -0700 (PDT)")
Message-ID: <m34qaxlm57.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> And in short-term things, the timeval/jiffie conversion is likely to be a 
> _bigger_ issue than the crystal frequency conversion.
>
> So we should aim for a HZ value that makes it easy to convert to and from
> the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> good values for that reason. 864 is not.

Probably only theoretical, and probably the hardware isn't up to it...
But what if we have:
- 64-bit jiffies done in hardware (a counter). 1 cycle = 1 microsecond
  or even a CPU clock cycle. Can *APIC or another HPET do that?
- 64-bit "match timer" (i.e., a register in the counter which fires IRQ
  when it matches the counter value)
- the CPU(s) sorting the timer list and programming "match timer" with
  software timer next to be executed. Upon firing the timer, a new "next
  to be executed" timer would be programmed into the counter's "match
  timer".

We would have no timer ticks when nobody requested them - the CPUs would
be allowed to sleep for, say, even 50 ms when no task is RUNNING.
-- 
Krzysztof Halasa

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVGNQjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVGNQjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVGNQjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:39:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbVGNQi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:38:29 -0400
Date: Thu, 14 Jul 2005 09:37:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Arjan van de Ven <arjan@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050714121340.GA1072@ucw.cz>
Message-ID: <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org>
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
 <20050714005106.GA16085@taniwha.stupidest.org>
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe>
 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org>
 <20050714121340.GA1072@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Vojtech Pavlik wrote:
>  
> A note on the relaive timer API: There needs to be a way to say
> "x milliseconds from the time this timer should have triggered" instead
> of "x milliseconds from now", to avoid skew in timers that try to be
> strictly periodic.

I disagree.

There should be an _absolute_ interface, and a driver that wants that 
should just have calculated when in time the timeout finishes - and then 
keep on using the absolute value.

Btw, this is exactly why the jiffy-based thing is _good_. The kernel 
timers _are_ absolute, and you make them relative by adding "jiffies".

The fact is, the current timers are better than people give them credit 
for, and converting them away from a jiffies-based interface (to a 
usleep-like one) is STUPID.

There's absolutely nothing wrong with "jiffies", and anybody who thinks 
that

	msleep(20);

is fundamentally better than

	timeout = jiffies + HZ/50;

just doesn't realize that the latter is a bit more complicated exactly 
because the latter is a hell of a lot more POWERFUL. Trying to get rid of 
jiffies for some religious reason is _stupid_.

I have to say, this whole thread has been pretty damn worthless in general 
in my not-so-humble opinion.

		Linus

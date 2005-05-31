Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVEaTNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVEaTNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVEaTNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:13:13 -0400
Received: from ultra7.eskimo.com ([204.122.16.70]:31239 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S261285AbVEaTLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:11:50 -0400
Date: Tue, 31 May 2005 12:10:39 -0700
From: Elladan <elladan@eskimo.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531191039.GV1680@eskimo.com>
References: <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <429BA27A.5010406@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429BA27A.5010406@andrew.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 07:32:10PM -0400, James Bruce wrote:
> Nick Piggin wrote:
> >Sorry James, we were talking about hard realtime. Read the thread.
> 
> hard realtime = mathematically provable maximum latency
> 
> Yes, you'll want a nanokernel for that, you're right.  That's because 
> one has to analyze every line of code, and protect against introduced 
> regressions, which is almost impossible given the pace that Linux-proper 
> is developed.  Then there's the other 95% of applications, for which a 
> "statistical RT" approach such as used in the RT patch suffice.  So 
> arguing for a nanokernel for (provable) hard realtime is orthogonal to 
> the discussion of this patch, and we apparently don't actually disagree.

In the real world, this isn't really possible.  Ideally, you'd like to be able
to offer some proof of correctness for the software, but this isn't actually
going to get you provable maximum latency, because you can't prove the
hardware.  

Even with perfect software, the hardware is subject to cosmic rays, bad design,
etc.  Even if you strongly control the hardware for latency, eg.  turn off
cache and try to make sure everything is measurable, in the end the real proof
that your device does what it says it does is measurement.  If the RTOS
guarantees aren't violated during testing, or at best, in a time period
comparable to the failure rate of the hardware, that's "good enough."

Given that hardware is always subject to failure or flakiness, the more
practical distinction between "hard" and "soft" realtime is whether the failure
rate is measurable or is lost in the noise of other failure modes such as
hardware.  "Soft" RT typically means that the failure rate is measurable but
may be sufficient for particular tasks, and in comparison "hard" means the
software is thought to be correct within your ability to measure.

Certainly there's a lot of value for some applications in trying to control the
software well enough that all the latencies can be understood and characterized
by inspection, but on any sort of consumer commodity hardware system this is
really not going to buy you much.  There are so many potential latencies just
due to wacky hardware that even a "perfect" RTOS is going to be subject to all
sorts of weird latencies and bizarre issues eg. with interrupt routing and CPU
thermal control and the like.  

Showing that the application works as intended is really just going to be a
matter of showing that on a particular system, the latency requirements are met
under load.  Which is exactly a sort of statistical approach.  For almost all
"PC" applications that need realtime, this is exactly what's desired.

And clearly, the ultimate test of any RT system is exactly a "statistical" test
- can it be measured to fail, and if so, why and how often?

For limited embedded applications, a "hard" nanokernel approach can certainly
lead to higher confidence that the device works as intended, but for anything
outside of embedded products it's really not very practical.  Nobody's going to
run their desktop OS under a nanokernel just to make their DVD software work
right.

-J

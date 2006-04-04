Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWDDTHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWDDTHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDDTHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:07:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15234 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750750AbWDDTHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:07:14 -0400
Date: Tue, 4 Apr 2006 21:06:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <1144126422.5344.418.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604041218250.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
 <1144126422.5344.418.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Apr 2006, Thomas Gleixner wrote:

> On Mon, 2006-04-03 at 21:54 +0200, Roman Zippel wrote:
> > Another general comment from an arch/driver specific perspective: right 
> > now everything is rather concentrated on getting the time, but AFAICT it's 
> > more common that the subsystem which is used to read the time is also used 
> > as timer (i.e. for the scheduler tick), this means the clocksource driver 
> > should also include the interrupt setup.
> 
> I don't think so. Coupling the clock sources to clock event sources is
> wrong. In many systems the clock event source delivering the next event
> interrupt - either periodic or per event programmed - is independend
> from the clock source which is used to read the time.

Why? In order to program a clock event you have to be able to read the 
clock somehow. In many systems it's the same hardware.

> Also we want to distribute multiple clock event sources for various
> services. Hardwiring those into combos is counter productive.

What suggest I want to hardwire everything?

> > i386 is currently rather hardcoded to use the i8253 timer, but AFAIK it 
> > would be desirable to e.g. use HPET for that (especially for hrtimer). 
> > Something like TSC should internally use another clocksource to provide 
> > the timer interrupt.
> 
> This is exactly the result of such an artificial combo. "Use internally
> something else." Thats fundamentally wrong and violates every basic rule
> of abstraction.

Why and what "basic rule of abstraction"?

> Clock event sources need their own independent abstraction layer, as one
> can be found in my high resolution timer patch queue. There is
> interaction between the timekeeping and the next event interrupt
> programming, but it's important to keep them seperate.
> 
> How should a combo solution allow to add special hardware, which
> provides only one of the services ? By using "something else
> internally" ? No, thanks.

Again, why? Please explain.

Thomas, I would really appreciate if you actually started to argue your 
point instead of just disagreeing with me every time. I have no problem to 
admit that I'm wrong, but it takes a bit more than you just saying it is 
so.
This is not the first time and I have a really hard time to actually get 
you to explain your position and then it's even harder to discuss this 
with you. This is very frustrating and I can't lose the feeling that you 
think I'm a complete idiot, who should know better and isn't worth the 
time to answer, which makes me feel disrespected.
I don't mind really that you mainly just disagree with me and if you 
argued your point, it would make for some interesting and challenging 
conversations, but this isn't possible if you only voice just your 
disagreement.
For example above you bascially only state that your clock event source 
is superior and the correct way of doing this without any explanation why 
(and the "No, thanks." doesn't exactly imply that you're even interested 
in alternatives). This may be true, but it still would be interesting to 
know the advantages of keeping this separate. Why is it such a bad idea to 
have a single base abstraction for reading and setting time(r)?
Do you really expect me to believe you just because you say so?

bye, Roman

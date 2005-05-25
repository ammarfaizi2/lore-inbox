Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVEYHrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVEYHrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVEYHrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:47:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8385 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262292AbVEYHrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:47:00 -0400
Date: Wed, 25 May 2005 09:46:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Sven Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525074633.GA18423@elte.hu>
References: <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <429426C9.8040901@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429426C9.8040901@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >i agree in theory, but interestingly, people who use the -RT branch do 
> >report a smoother desktop experience. While it might also be a 
> >psychological effect, under -RT an interactive X process has the same 
> >kind of latency properties as if all of the mouse pointer input and 
> >rendering was done in the kernel (like some other desktop OSs do).
> >
> >so in terms of mouse pointer 'smoothness', it might very well be 
> >possible for humans to detect a couple of msec delays visually - even 
> >though they are unable to notice those delays directly. (Isnt there some 
> >existing research on this?)
> 
> I'm guessing not, just because the monitor probably hasn't even 
> refreshed at that point ;) But...

this reminds me, people very much notice the difference between an LCD 
that has 20 msec refresh rates vs. ones that have 10 msec refresh rates.

i'd say the direct perception limit should be somewhere around 10 msec, 
but there can be indirect effects that add up. (e.g. while we might not 
be able to detect so small delays directly, the human eye can see 
_distance_ anomalies that are caused by small delays. E.g. the feeling 
of how 'smoothly' the mouse moves might be more accurate than direct 
delay perception. But i'm really out on a limb here as this is so hard 
to measure directly.)

> [...]
> >
> >[ of course this is all just talk, but people seem to have a desire to
> >  talk about it :-) ]
> >
> 
> You make good points. What's more, I don't think anyone needs to 
> advocate the RT work on the basis that it improves interactiveness.
>
> That path is just going to lead to unwinnable arguments and will 
> distract from the real measurable improvements that it does bring.
> 
> I think anyone who doesn't like that won't be convinced because 
> someone is telling them it improves interactiveness ;)

a good number of testers use it because it improves interactiveness - so 
you'll see these arguments come up.

One indirect latency effect is that during heavier VM load, e.g. kswapd 
(or the swapout code) is preemptable by X.

Another indirect effect is that in the stock kernel, interrupt work is 
not preemptable. So a short succession of heavier interrupts, followed 
by softirq processing, can very much cause more than 10 msec delays.  
Under PREEMPT_RT (or just PREEMPT + softirq and hardirq threading) these 
workloads are much more controlled. (at the price of significant IRQ 
processing overhead, which should not be ignored either.)

but ... i agree that this argument in isolation cannot "win". It's the 
sum of arguments that matters.

	Ingo

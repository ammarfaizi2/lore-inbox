Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVEYGdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVEYGdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVEYGdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:33:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16821 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262280AbVEYGdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:33:20 -0400
Date: Wed, 25 May 2005 08:33:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525063306.GC5164@elte.hu>
References: <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524192029.2ef75b89.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Sven Dietrich <sdietrich@mvista.com> wrote:
> >
> > I think people would find their system responsiveness / tunability
> >  goes up tremendously, if you drop just a few unimportant IRQs into
> >  threads.
> 
> People cannot detect the difference between 1000usec and 50usec 
> latencies, so they aren't going to notice any changes in 
> responsiveness at all.

i agree in theory, but interestingly, people who use the -RT branch do 
report a smoother desktop experience. While it might also be a 
psychological effect, under -RT an interactive X process has the same 
kind of latency properties as if all of the mouse pointer input and 
rendering was done in the kernel (like some other desktop OSs do).

so in terms of mouse pointer 'smoothness', it might very well be 
possible for humans to detect a couple of msec delays visually - even 
though they are unable to notice those delays directly. (Isnt there some 
existing research on this?)

but this is getting offtrack. -RT does have direct benefits for pro 
audio (and of course embedded systems) users, maybe also interactivity 
benefits for slower/older systems, but i'm not trying to argue that it's 
necessary for the generic desktop. (especially considering the kernel 
overhead)

but there exist other indirect benefits: what is a scheduling latency 
critical path on CONFIG_PREEMPT, is still a (secondary) critical path on 
PREEMPT_RT too, which embedded people will try to improve. The same is 
true for voluntary-preempt: if you break a latency path on 
CONFIG_PREEMPT, you implicitly improve PREEMPT_VOLUNTARY too. So there 
are fundamental cross-effects between the preemption models, and by 
cowardly luring those embedded developers into using the stock Linux 
kernel instead of hacking on their own isolated patches/trees (or OSs) 
we indirectly improve latencies of the desktop preemption model too.  
Please dont underestimate the amount of development that goes on in the 
embedded world, the more of them use Linux, the better for all Linux 
users.

it's also a perception thing: if Linux _can_ offer sub-100 usec 
latencies, embedded developers are more likely to pick it for their 
project - even if the hardware does not need so good latencies. Embedded 
developers (and OS vendors) will be more likely to standardize on Linux 
exclusively, if they know that whatever future customer comes around, 
Linux will be able to perform.

it's pretty much the same story as with scalability: only a few people 
needs Linux to scale to 500 CPUs (in fact only a small precentage needs 
anything above 4 CPUs), but the perception advantage gives 2-CPU people 
the warm fuzzy feeling that if Linux works fine on 500 CPUs then it must 
be more than adequate on 2 CPUs. Is anyone going to argue that Linux 
does not need to scale above 4 CPUs just because the number of users in 
that space is less than 1%?

[ of course this is all just talk, but people seem to have a desire to
  talk about it :-) ]

	Ingo

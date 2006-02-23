Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWBWMnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWBWMnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWBWMnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:43:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46809 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751155AbWBWMnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:43:23 -0500
Date: Thu, 23 Feb 2006 13:41:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Message-ID: <20060223124152.GA4008@elte.hu>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140686994.4672.4.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602231041.00566.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Thursday 23 February 2006 10:29, Arjan van de Ven wrote:
> > This patch adds an entry for a cleared page to the task struct. The main
> > purpose of this patch is to be able to pre-allocate and clear a page in a
> > pagefault scenario before taking any locks (esp mmap_sem),
> > opportunistically. Allocating+clearing a page is an very expensive 
> > operation that currently increases lock hold times quite bit (in a threaded 
> > environment that allocates/use/frees memory on a regular basis, this leads
> > to contention).
> > 
> > This is probably the most controversial patch of the 3, since there is
> > a potential to take up 1 page per thread in this cache. In practice it's
> > not as bad as it sounds (a large degree of the pagefaults are anonymous 
> > and thus immediately use up the page). One could argue "let the VM reap
> > these" but that has a few downsides; it increases locking needs but more,
> > clearing a page is relatively expensive, if the VM reaps the page again
> > in case it wasn't needed, the work was just wasted.
> 
> Looks like an incredible bad hack. What workload was that again where 
> it helps? And how much? I think before we can consider adding that 
> ugly code you would a far better rationale.

yes, the patch is controversial technologically, and Arjan pointed it 
out above. This is nothing new - and Arjan probably submitted this to 
lkml so that he can get contructive feedback.

What Arjan did is quite nifty, as it moves the page clearing out from 
under the mmap_sem-held critical section. How that is achieved is really 
secondary, it's pretty clear that it could be done in some nicer way.  
Furthermore, we havent seen any significant advance in that area of the 
kernel [threaded mmap() performance] in quite some time, so 
contributions are both welcome and encouraged.

But Andi, regarding the tone of your reply - it is really getting out of 
hand! Please lean back and take a deep breath. Maybe you should even 
sleep over it. And when you come back, please start being _much_ more 
respectful of other people's work. You are not doing Linux _any_ favor 
by flaming away so mindlessly ... Arjan is a longtime contributor and he 
can probably take your flames just fine (as I took your flames just fine 
the other day), but we should really use a _much_ nicer tone on lkml.

You might not realize it, but replies like this can scare away novice 
contributors forever! You could scare away the next DaveM. Or the next 
Alan Cox. Or the next Andi Kleen. Heck, much milder replies can scare 
away even longtime contributors: see Rusty Russell's comments from a 
couple of days ago ...

And no, i dont accept the lame "dont come into the kitchen if you cant 
stand the flames" excuse: your reply was totally uncalled for, was 
totally undeserved and was totally unnecessary. It was incredibly mean 
spirited, and the only effect it can possibly have on the recipient is 
harm. And it's not like this happened in the heat of a longer discussion 
or due to some misunderstanding: you flamed away _right at the 
beginning_, right as the first reply to the patch submission. Shame on 
you! Is it that hard to reply:

  "Hm, nice idea, I wish it were cleaner though because
   <insert explanation here>. How about <insert nifty idea here>."

[ Btw., i could possibly have come up with a good solution for this
  during the time i had to waste on this reply. ]

	Ingo

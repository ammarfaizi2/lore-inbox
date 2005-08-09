Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVHIFaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVHIFaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVHIFap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:30:45 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:1505 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932447AbVHIFap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:30:45 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <42F83D04.7090802@yahoo.com.au>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost>  <42F83849.9090107@yahoo.com.au>
	 <1123564294.4370.119.camel@localhost>  <42F83D04.7090802@yahoo.com.au>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123565413.4370.127.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 15:30:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-08-09 at 15:20, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > Hi Nick et al.
> > 
> > On Tue, 2005-08-09 at 14:59, Nick Piggin wrote:
> 
> >>>Changing the e820 code so it sets PageNosave instead of PageReserved,
> >>>along with a couple of modifications in swsusp itself should get rid of
> >>>the swsusp dependency.
> >>>
> >>
> >>That would work for swsusp, but there are other users that want to
> >>know if a struct page is valid ram (eg. ioremap), so in that case
> >>swsusp would not be able to mess with the flag.
> > 
> > 
> > Um. Mess with which flag? I guess you mean Reserved. I was saying that
> 
> Mess with PageNosave (if that is what we used to denote a struct page
> not pointing to valid RAM).
> 
> Ie. when swsusp allocates its save map (or whatever it calls it), setting
> PageNosave would make other parts of the kernel think the area is not
> valid ram.

Ok. I guess I should have looked, but I thought the suspend
implementations were the only users of Nosave.

> In other words - we can't combine swsusp's PageNosave with our mythical
> PageValidRAM.
> 
> > imaging Reserved going away, so for the short term I'd be meaning making
> > the e820 set both Nosave and Reserved for those pages (which is what the
> > Suspend2 patches do so as to play nicely with swsusp - I don't use
> > Reserved at all).
> > 
> 
> In the short term, PageReserved can stay around - swsusp does still
> work if I hadn't made that clear.

Yeah.

> By the way - how does swsusp2 handle this problem if not using
> PageReserved?

At the places where Reserved is currently set and cleared, I set and
clear Nosave as well. Then I only use Nosave. Swsusp still works fine
(although I have to comment out a bogus bug_on()) and suspend2 can clear
and set additional pages' Nosave flags while it runs (equivalents to
Pavel's nosave_free pages and also pages allocated for checksumming when
I get paranoid).

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


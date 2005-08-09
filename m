Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVHIFMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVHIFMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVHIFMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:12:08 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:50336 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750951AbVHIFME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:12:04 -0400
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
In-Reply-To: <42F83849.9090107@yahoo.com.au>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost>  <42F83849.9090107@yahoo.com.au>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123564294.4370.119.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 15:11:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick et al.

On Tue, 2005-08-09 at 14:59, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > Hi.
> > 
> > On Tue, 2005-08-09 at 07:09, Daniel Phillips wrote:
> > 
> >>>It doesn't look like they'll be able to easily free up a page
> >>>flag for 2 reasons. First, PageReserved will probably be kept
> >>>around for at least one release. Second, swsusp and some arch
> >>>code (ioremap) wants to know about struct pages that don't point
> >>>to valid RAM - currently they use PageReserved, but we'll probably
> >>>just introduce a PageValidRAM or something when PageReserved goes.
> > 
> > 
> > Changing the e820 code so it sets PageNosave instead of PageReserved,
> > along with a couple of modifications in swsusp itself should get rid of
> > the swsusp dependency.
> > 
> 
> That would work for swsusp, but there are other users that want to
> know if a struct page is valid ram (eg. ioremap), so in that case
> swsusp would not be able to mess with the flag.

Um. Mess with which flag? I guess you mean Reserved. I was saying that
imaging Reserved going away, so for the short term I'd be meaning making
the e820 set both Nosave and Reserved for those pages (which is what the
Suspend2 patches do so as to play nicely with swsusp - I don't use
Reserved at all).

> I do think swsusp should (and can, quite easily though I may have
> missed something) consolidate PG_nosave and PG_nosave_free, however
> that's out of the scope of this patch.

I won't comment here. I don't start at swsusp code that much :>

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266176AbRG1CPy>; Fri, 27 Jul 2001 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266198AbRG1CPo>; Fri, 27 Jul 2001 22:15:44 -0400
Received: from [209.250.53.98] ([209.250.53.98]:265 "EHLO hapablap.dyn.dhs.org")
	by vger.kernel.org with ESMTP id <S266176AbRG1CPj>;
	Fri, 27 Jul 2001 22:15:39 -0400
Date: Fri, 27 Jul 2001 21:14:59 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Addendum to Daniel Phillips [RFC] use-once patch
Message-ID: <20010727211459.A13603@hapablap.dyn.dhs.org>
In-Reply-To: <Pine.SV4.4.21.0107271524310.4696-100000@wipro.wipsys.sequent.com> <0107271638180F.00285@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0107271638180F.00285@starship>; from phillips@bonn-fries.net on Fri, Jul 27, 2001 at 04:38:18PM +0200
X-Uptime: 8:41pm  up 1 day, 13:04,  1 user,  load average: 1.04, 1.03, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 04:38:18PM +0200, Daniel Phillips wrote:
> > may be
> > +                * it is the best candidate for swapping.
> > +                */
> > +               if ((page->age > PAGE_AGE_MAX) && (page_count(page)
> > <= 1)) {
> > +                       page->age = PAGE_AGE_START;
> > +               } else {
> > +                       page->age += PAGE_AGE_ADV;
> > +                       if (page->age > PAGE_AGE_MAX) {
> > +                               page->age = PAGE_AGE_MAX;
> > +                       }
> > +                       return;
> > +               }
> 
> I noticed your good benchmark results below, but I'm having some 
> trouble understanding how this works.  How can page->age ever become 
> greater than PAGE_AGE_MAX?  Also, I don't see any reference to 
> PAGE_MAX_USE.  Comments?

What if page->age is equal to PAGE_AGE_MAX when it hits the 'else'
statement.  It will be unconditionally incremented by PAGE_AGE_ADV, and
then it will be greater than PAGE_AGE_MAX.  The inner 'if' statement
catches this, and sets the age back to PAGE_AGE_MAX
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

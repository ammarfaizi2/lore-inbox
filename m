Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVHLXEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVHLXEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 19:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVHLXEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 19:04:13 -0400
Received: from smtp.istop.com ([66.11.167.126]:44769 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751219AbVHLXEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 19:04:12 -0400
From: Daniel Phillips <phillips@arcor.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Sat, 13 Aug 2005 09:04:40 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Pavel Machek <pavel@suse.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <200508130556.11215.phillips@arcor.de> <200508130020.11864.rjw@sisk.pl>
In-Reply-To: <200508130020.11864.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508130904.41438.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 August 2005 08:20, Rafael J. Wysocki wrote:
> On Friday, 12 of August 2005 21:56, Daniel Phillips wrote:
> > I still don't see why you can't lift your flags up into the VMA.  The
> > rmap mechanism is there precisely to let you get from the physical page
> > to the users and user data, including VMAs.
>
> I'm not sure if I understand the issue, but swsusp works on a different
> level. It only needs to figure out which physical pages, as represented by
> struct page objects, should be saved to swap before suspend.  We browse all
> zones (once) and create a list of page frames that should be saved on the
> basis of the contents of the struct page objects alone.  IMHO if we needed
> to use any additional mechanisms here, it would be less efficient than just
> checking the page flags.

Isn't that what hash tables are for?  It seems to me obvious that you don't 
absolutely need to reserve page flag bits, but you think this is better, 
maybe enough faster to make a perceptible difference.  How about testing with 
a hash table?  If it dims the lights then you have all the argument you need.

Admittedly, page flags have not gotten really tight just yet, and this is 
something you can change later if they do become tight.  But it would be very 
nice to know just which of those page flags are really needed (like uptodate) 
versus which are just there for convenience.  I think yours fall in the 
latter category.

Regards,

Daniel

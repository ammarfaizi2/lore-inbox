Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSA1XXD>; Mon, 28 Jan 2002 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSA1XWp>; Mon, 28 Jan 2002 18:22:45 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:24199 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287657AbSA1XWe>;
	Mon, 28 Jan 2002 18:22:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 00:27:29 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <E16VKR5-0000DG-00@starship.berlin> <3C55DAEF.7020500@vitalstream.com>
In-Reply-To: <3C55DAEF.7020500@vitalstream.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VLBR-0000Df-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 12:12 am, Rick Stevens wrote:
> Daniel Phillips wrote:
> 
> > Since the page was copied to the child, the child's page table must be 
> > altered, and since it is shared, it must first be instantiated by the child.  
> > So after all the dust settles, the parent and child have their own copies of 
> > a page table page, which differ only at a single location: the child's page 
> > table points at its freshly made CoW copy, and the parent's page table points 
> > at the original page.
> 
> > 
> > The beauty of this is, the page table could just as easily have been shared 
> > by a sibling of the child, not the parent at all, in the case that the parent 
> > had already instantiated its own copy of the page table page because of an 
> > earlier CoW.
> 
> 
> Ok.  Still seems like a bit more copying than necessary.

I think I can show that it's exactly as much copying as necessary, and no more.
Oh, the page directory could also be shared and, on a 3 level page table, so
could the mid level tables, but that's not a really big win because of the 1K/1
fanout.  I.e, we already took care of 99.9% of the problem just by sharing the
bottom-level page tables.

> I'd have to look at it a bit more and do some noodling.
>  
> > Confused yet?  Welcome to the club ;-)
> 
> Does my head exploding qualify for "confused"?  If so, then I'm not
> yet "confused".  I'm "concerned", since my ears are bleeding (a
> precursor to an explosion) ;-p

:-)

-- 
Daniel

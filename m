Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSBGOHl>; Thu, 7 Feb 2002 09:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289779AbSBGOHc>; Thu, 7 Feb 2002 09:07:32 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:32907 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289564AbSBGOHW>;
	Thu, 7 Feb 2002 09:07:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>, zaitcev@redhat.com
Subject: Re: The IBM order relaxation patch
Date: Thu, 7 Feb 2002 15:12:10 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF5FF19417.595BC760-ONC1256B58.00762715@de.ibm.com>
In-Reply-To: <OF5FF19417.595BC760-ONC1256B58.00762715@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YpHW-0000aw-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 6, 2002 10:50 pm, Ulrich Weigand wrote:
> Pete Zaitcev wrote:
> >It's a stupid question, but: why can we not simply
> >wait until a desired unfragmented memory area is available,
> >with a GPF flag? What they describe does not happen in an
> >interrupt context, so we can sleep.
> 
> Because nobody even *tries* to free adjacent pages to build up
> a free order-2 area.  You could wait really long ...
> 
> This looks hard to fix with the current mm layer.  Maybe Rik's
> rmap method could help here, because with reverse mappings we
> can at least try to free adjacent areas (because we then at least
> *know* who's using the pages).

Yes, that's one of leading reasons for wanting rmap.  (Number one and two 
reasons are: allow forcible unmapping of multiply referenced pages for 
swapout; get more reliable hardware ref bit readings.)

Note that even if we can do forcible freeing we still have to deal with the 
issue of fragmentation due to pinned pages, e.g., slab cache, admittedly a 
rarer problem.

-- 
Daniel

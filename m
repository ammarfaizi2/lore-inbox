Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317879AbSHCVtw>; Sat, 3 Aug 2002 17:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHCVtv>; Sat, 3 Aug 2002 17:49:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45769 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317879AbSHCVtv>; Sat, 3 Aug 2002 17:49:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Sat, 3 Aug 2002 17:50:03 -0400
User-Agent: KMail/1.4.1
Cc: Linus Torvalds <torvalds@transmeta.com>, Gerrit Huizenga <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <15691.22889.22452.194180@napali.hpl.hp.com> <200208031653.39827.frankeh@watson.ibm.com> <15692.19075.541249.977133@napali.hpl.hp.com>
In-Reply-To: <15692.19075.541249.977133@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208031750.03795.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 05:26 pm, David Mosberger wrote:
> >>>>> On Sat, 3 Aug 2002 16:53:39 -0400, Hubertus Franke
> >>>>> <frankeh@watson.ibm.com> said:
>
>   Hubertus> Cool.  Does that mean that BSD already has page coloring
>   Hubertus> implemented ?
>
> FreeBSD (at least on Alpha) makes some attempts at page-coloring, but
> it's said to be far from perfect.
>
>   Hubertus> The agony is: Page Coloring helps to reduce cache
>   Hubertus> conflicts in low associative caches while large pages may
>   Hubertus> reduce TLB overhead.
>
> Why agony?  The latter helps the TLB _and_ solves the page coloring
> problem (assuming the largest page size is bigger than the largest
> cache; yeah, I see that could be a problem on some Power 4
> machines... ;-)
>

In essense, remember page coloring preserves the same bits used
for cache indexing from virtual to physical. If these bits are covered 
by the large page, then ofcourse you will get page coloring for free
otherwise you won't.
Also, page coloring is mainly helpful in low associativity caches.
>From my recollection of the literature, for 4-way or higher its not
worth the trouble.

Just to rephrase:  
- Large pages almost always solve your page coloring problem.
- Page coloring never solves your TLB coverage problem.

>   Hubertus> One shouldn't rule out one for the other, there is a place
>   Hubertus> for both.
>
>   Hubertus> How did you arrive to the (weak) empirical evidence?  You
>   Hubertus> checked TLB misses and cache misses and turned page
>   Hubertus> coloring on and off and large pages on and off?
>
> Yes, that's basically what we did (there is a patch implementing a
> page coloring kernel module floating around).
>
> 	--david

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)

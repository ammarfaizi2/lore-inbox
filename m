Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTAXGcz>; Fri, 24 Jan 2003 01:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTAXGcz>; Fri, 24 Jan 2003 01:32:55 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:23807 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267566AbTAXGcx>; Fri, 24 Jan 2003 01:32:53 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Anoop J." <cs99001@nitc.ac.in>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jan 2003 22:28:40 -0800 (PST)
Subject: Re: your mail
In-Reply-To: <42636.210.212.228.78.1043387664.webmail@mail.nitc.ac.in>
Message-ID: <Pine.LNX.4.44.0301232225030.10187-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

implementing a fully associative cache eliminates the need for page
coloring, but it has to be implemented in hardware. if you don't have
fully associative caches in your hardware page coloring helps avoid the
worst case memory allocations.

from what I have seen on the attempts to implement it the problem is that
the calculations needed to do page colored allocations end up costing
enough that they end up with a net loss compared to the old method.

David Lang


 On Fri, 24 Jan 2003, Anoop J.
wrote:

> Date: Fri, 24 Jan 2003 11:24:24 +0530 (IST)
> From: Anoop J. <cs99001@nitc.ac.in>
> To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
>
>
> How is this different from a fully associative cache .Would be better if u
> could deal it based on the address bits used
>
> Thanks
>
> David Lang wrote:
>
> >The idea of page coloring is based on the fact that common implementations
> >of caching can't put any page in memory in any line in the cache (such an
> >implementation is possible, but is more expensive to do so is not commonly
> >done)
> >
> >With this implementation it means that if your program happens to use
> >memory that cannot be mapped to half of the cache lines then effectivly
> >the CPU cache is half it's rated size for your program. the next time your
> >program runs it may get a more favorable memory allocation and be able to
> >use all of the cache and therefor run faster.
> >
> >Page coloring is an attampt to take this into account when allocating
> >memory to programs so that every program gets to use all of the cache.
> >
> >David Lang
> >
> >
> > On Fri, 24 Jan 2003, Anoop J. wrote:
> >
> >>Date: Fri, 24 Jan 2003 10:38:03 +0530 (IST)
> >>From: Anoop J. <cs99001@nitc.ac.in>
> >>To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
> >>
> >>
> >>How does page coloring work. Iwant its mechanism not the implementation.
> >>I went through some pages of W.L.Lynch's paper on cache and VM. Still not
> >>able to grasp it .
> >>
> >>
> >>Thanks in advance
> >>
> >>
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

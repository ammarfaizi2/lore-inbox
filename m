Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319312AbSH2UtQ>; Thu, 29 Aug 2002 16:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319341AbSH2UtQ>; Thu, 29 Aug 2002 16:49:16 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:33548 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S319312AbSH2UtQ>;
	Thu, 29 Aug 2002 16:49:16 -0400
Date: Thu, 29 Aug 2002 21:53:32 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 Vs 2.4.19-rmap14a with anonymous mmaped memory
In-Reply-To: <E17kV44-00035H-00@starship>
Message-ID: <Pine.LNX.4.44.0208292137540.31984-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Daniel Phillips wrote:

> The perl script that writes tables isn't too informative without knowing
> how the tables are used.  Pseudocode that says exactly what your final
> reference pattern is would be a lot more useful.

I guessed that after I thought about it for a while and reworked the
algorithm for 0.7. To make things easier again, I added a new graph to the
reports which is in 0.7 called "Page Index Reference over Time"

see

http://www.csn.ul.ie/~mel/projects/vmregress/output_sample/mmap/read/25000/mapanon.html

It is the second graph. At the beginning, it is at the 0th page and it
moves through the address space over time. A totally random one would make
this graph look like noise. The graph should give a good idea how memory
was referenced.

In 0.6 and with these tests, it would have been a similar curve except the
last page would have been hit around 40000 references before the end of
the test. After that, the pages were referenced in a linear pattern which
was a mistake after reviewing it a bit.

If people are still interested, I'll run a full set of tests again on
2.4.19 and 2.4.19-rmap14a with 0.7 and post up the results complete with
the page reference information so you don't have to guess this time. It
takes about a full day to run a complete series. Any taker?

> It would also be useful to state what you define as a reference.  A user
> space program read-accesses a single byte from some address?
>

A reference in this test was reading a full page of information using
copy_from_user()

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel


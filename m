Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293055AbSCEAVF>; Mon, 4 Mar 2002 19:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293051AbSCEAUz>; Mon, 4 Mar 2002 19:20:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15714 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293049AbSCEAUo>; Mon, 4 Mar 2002 19:20:44 -0500
Date: Tue, 5 Mar 2002 01:19:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305011907.V20606@dualathlon.random>
In-Reply-To: <20020304232544.P20606@dualathlon.random> <E16i1aZ-0000jQ-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16i1aZ-0000jQ-00@w-gerrit2>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 03:09:51PM -0800, Gerrit Huizenga wrote:
> 
> In message <20020304232544.P20606@dualathlon.random>, > : Andrea Arcangeli writ
> es:
> > it's better to make sure to use all available ram in all nodes instead
> > of doing migrations when the local node is low on mem. But this again
> > depends on the kind of numa system, I'm considering the new numas, not
> > the old ones with the huge penality on the remote memory.
> 
> Andrea, don't forget that the "old" NUMAs will soon be the "new" NUMAs
> again.  The internal bus and clock speeds are still quite likely to
> increase faster than the speeds of most interconnects.  And even quite

For various reasons I think we'll never go back to "old" NUMA in the
long run.

> a few "big SMP" machines today are really somewhat NUMA-like with a
> 2 to 1 - remote to local memory latency (e.g. the Corollary interconnect
> used on a lot of >4-way IA32 boxes is not as fast as the two local
> busses).

there's a reason for that.

> So, desiging for the "new" NUMAs is fine if your code goes into
> production this year.  But if it is going into production in two to
> three years, you might want to be thinking about some greater memory
> latency ratios for the upcoming hardware configurations...

Disagree, but don't take me wrong, I'm not really suggesting to design
for new numa only. I think linux should support both equally well, so
some heuristic like in the scheduler will be mostly the same, but they
will need different heuristics in some other place. For example the
"less frequently used ram migration instead of taking advantage of free
memory in the other nodes first" should fall in the old numa category.

Andrea

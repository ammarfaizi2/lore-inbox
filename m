Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271825AbTHMLsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTHMLsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:48:50 -0400
Received: from unthought.net ([212.97.129.24]:5557 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S271825AbTHMLsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:48:46 -0400
Date: Wed, 13 Aug 2003 13:48:45 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Pavlica, Nick" <Nick.Pavlica@echostar.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swapfile Calculation / 2.4.18 | >
Message-ID: <20030813114845.GB8810@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Pavlica, Nick" <Nick.Pavlica@echostar.com>,
	linux-kernel@vger.kernel.org
References: <200308121453.18739.nick.pavlica@echostar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308121453.18739.nick.pavlica@echostar.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 02:53:18PM -0600, Pavlica, Nick wrote:
> Note:
>   Please CC answers/comments you post to me.
> 
> All,
>   Our team is discussing the best approach to calculating the swap file size 
> for the 2.4.18 kernels and newer on systems with 6 - 8 Gb of RAM.  Does the 
> "Double The System Ram" rule still apply?

It never did.  It's a rule of thumb, if you have no idea about what your
swap needs might be, and if it's a general purpose machine with "normal
amounts of memory" that shouldn't swap at all but still should have some
swap space just in case. 

What do you do with your systems?  How much total virtual memory will
you need?  How much does it cost you to wait an extra hour for the
computers to finish, compared to the cost of the machine/memory you
would need in order to speed up the processing with an hour?

> 
> I'm sorry if I offend anyone by posting this here, I'm just looking for an 
> authoritative / accurate response.

I'm certainly not authorative on this issue   :)    But I rather doubt
that you will find anyone who will stand up and say "for any purpose
imaginable, you will at all times see perfect performance with
K*{physical memory} of swap" for some fixed constant K.

> 
> A quote on the topic from one of our engineers:
> 
>   "I'd disagree on the Swapfile size.  Swapfiles over 2 Gig are insane.  If
>   a host is consuming 2+ Gig of real RAM, and consuming another 2 Gig of
>   Swap, something is wrong with the apps that are running on that host.
>   (I can go into a big tirade on how Linux VM works, if anyone wants ;) )"

I once wrote a finite element solver that was optimized for having the
entire working set of data on disk (with only a small amount in RAM at
any given time).   That was a design decision - nothing was wrong with
that app.

Really, you need to understand what your applications are doing. You
need to understand what their needs are. And you need to know what your
needs are. Then, you can choose whether putting in another 32G of RAM is
better (cost/benefit in your specific scenario) than adding 32G of swap.

Think of your memory like a hierarchy:
  Registers -> L1 cache -> L2 cache -> L3 cache -> RAM -> Disk

Adding more storage earlier in this sequence *can* give you significant
performance increases.  But it may be costly.


The only common rule that I can think of in this respect is: OOM is bad!
Make sure that you have enough virtual memory for your applications, and
then some to spare. A slow (swap thrashing) machine is better than a
crashed machine.

The workloads I have are usually a handfull of processes in the
few-hundred-megs-of-memory range.  For this, I usually make sure that I
have 1-2 GB of swap *more* than I would ever need.  A little headroom is
useful when something doesn't run as expected.

Also, having the majority of the used virtual memory in swap (say, a 2GB
RAM plus 16 GB swap machine with 90% of all virtual memory used), is not
necessarily a problem.  It depends.  Look at "vmstat".  If there is
virtually no paging activity, then it's probably not a performance
problem.  Buying those extra 16 GB of RAM instead may not help you a
lot.  I know people who do chip design, and I've heard stories about
buying extra 'swap drives' simply in order to work around memory leaks
in simulation applications.   It's a workaround, and the simulation
application should of course be fixed, but it can work just nicely for
memory leaks where the data that gets swapped out is never again
accessed.


So to summarize:  There is no simple rule.

Sorry about that  :)

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSJaQNR>; Thu, 31 Oct 2002 11:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbSJaQNQ>; Thu, 31 Oct 2002 11:13:16 -0500
Received: from bitmover.com ([192.132.92.2]:15509 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262730AbSJaQNJ>;
	Thu, 31 Oct 2002 11:13:09 -0500
Date: Thu, 31 Oct 2002 08:19:21 -0800
From: Larry McVoy <lm@bitmover.com>
To: bob <bob@watson.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, karim@opersys.com,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       okrieg@watson.ibm.com, okrieg@us.ibm.com, frankeh@us.ibm.com,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Is your idea good?  [was: Re: LTT for inclusion into 2.5]
Message-ID: <20021031081921.D27620@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	bob <bob@watson.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
	karim@opersys.com, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, okrieg@watson.ibm.com,
	okrieg@us.ibm.com, frankeh@us.ibm.com, LTT-Dev <ltt-dev@shafik.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <3DC0A01B.15B8B535@opersys.com> <15809.21188.456354.71271@k42.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15809.21188.456354.71271@k42.watson.ibm.com>; from bob@watson.ibm.com on Thu, Oct 31, 2002 at 11:00:15AM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't mean to pick on LTT, I haven't used it, it may be the best thing
since sliced bread.

I can tell you how to present this and any other feature similar to this
in a way which would make me a lot more willing to accept it, which
presupposes I'm doing Linus' job which of course I am not.  However,
it's likely that Linus has similar views but he gets to chime in and
speak for himself.

All of these tools/features/whatever add some cost.  The cost can be 
measured in lots of different ways:

    - lines of code
    - lines of code which can't be configed out
    - call depth increases
    - stack size increases
    - cache foot print increases
    - parallelism (think preempt)
    - interface changes

I suspect there are other metrics and it would be very cool if others would
chime in with their pet peeves.

What would be cool is if there was some way to quantify as much as possible 
of the accepted set of costs so that that could be balanced against the 
value of the change, right?

The one that always gets me is

    "I've added feature XYZ, I benchmarked it with <whatever, usually
    LMbench> and it didn't make a difference"

That is almost certainly misleading.  The real thing you want to do
is quantify the actual costs because there can be non-zero costs that
do not show up in benchmarks.  For example, suppose that the benchmark
neatly fits in the onchip caches and it only uses 1/2 of those caches.
Your change could increase the cache foot print to just fill the caches,
the benchmark says no difference, you declare success and move on.
The problem is that almost all changes are good enough that they match
this description.  Measuring them in isolation doesn't tell us enough.
If I combine two changes, both of which use up 1/2 the cache, there is
no longer any room for anything else in the cache.

I'd love to see a trend where patch requests for any non-trivial patch
included before/after data for the above metrics (and any others that 
people see as useful).  I'd love to see some people taking just one of 
the above and making a tool which measures that metric.  Then we combine
the tools into a "patch measurement suite" and start prefixing patches
with

    Code changes:
	+1234 -5678 = -4444	(all code)
	+123 -567 = -444	(all code subject to CONFIG_XYZ)

    Call depth:
	+2 for read()
	+2 for write()
	no change for all other system calls

    Stack size:
	+2099 bytes for read()/write() path

    Cache misses:
	No change for benchmark1, 2, 3
	12,000 data read misses for lat_ctx ....
    
    Etc.

What does the list think of this?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

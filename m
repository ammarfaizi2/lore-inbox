Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSJaQls>; Thu, 31 Oct 2002 11:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJaQls>; Thu, 31 Oct 2002 11:41:48 -0500
Received: from igw3.watson.ibm.com ([198.81.209.18]:31174 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S262790AbSJaQlN>; Thu, 31 Oct 2002 11:41:13 -0500
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 31 Oct 2002 11:47:26 -0500 (EST)
To: Larry McVoy <lm@bitmover.com>
Cc: bob <bob@watson.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       karim@opersys.com, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, okrieg@watson.ibm.com, okrieg@us.ibm.com,
       frankeh@us.ibm.com, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: Is your idea good?  [was: Re: LTT for inclusion into 2.5]
In-Reply-To: <20021031081921.D27620@work.bitmover.com>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<3DC0A01B.15B8B535@opersys.com>
	<15809.21188.456354.71271@k42.watson.ibm.com>
	<20021031081921.D27620@work.bitmover.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15809.23057.231874.284128@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
 > I don't mean to pick on LTT, I haven't used it, it may be the best thing
 > since sliced bread.
...
 >  > The one that always gets me is
 > 
 >     "I've added feature XYZ, I benchmarked it with <whatever, usually
 >     LMbench> and it didn't make a difference"

Larry,
     You're right - whoever wrote that useless LMbench anyway :-)

I agree it would be great to have have a tool that allows us to gather
information on some of what you suggest below - but it's hard - people in
software engineering have been working on such things for a long time.
Further, what you mention below does not make sense in isolation.  For
example a package could add 1000 lines of code and have almost no impact,
while another 10 lines of code could make a huge difference.  So while the
below metrics are fine, without arguing about the expected impact they're
not necessarily helpful.

That's why benchmarks are still helpful as they are indicative of what
expected performance might be.  If you're trying to get at maintainability
then I might (being a K42 convert) argue for a different strategy
altogether.

So what about LTT then.  Well sure enough we did run LMbench as some other
tests.  We ran a kernel compile, a tar, and LMbench - and posted results to
lkml.  While this hardly represents all possibilities, showing little
performance impact on these is a positive statement about impact on other
applications.

To address some of the list below: 
 lines of code: a lot - almost all can be configed out, 
 call depth increase: we can analyze - complicated since while it is a
                      couple levels - other calls in the code may be to
 cache footprint: how? - simulate?  this is tough - qualitatively I think for
                  ltt is small because the same code is used across all trace
                  events.  And less frequent trace events won't interfere
 parallelism: not quite sure what you mean here - we not have a non-blocking
              lockless scheme to address what I think the concern is here
 interface changes: I argue very very positive - as in my letter to Linus
                   getting various developers to talk about performance
                   with a common mechanism would be a big win


I'm sure this doesn't fully address your concerns - but if others feel some 
of the below numbers are really important we can certainly go about getting 
more accurate results then my above off-the-cuff info.

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

----

Larry McVoy writes:
 > I don't mean to pick on LTT, I haven't used it, it may be the best thing
 > since sliced bread.
 > 
 > I can tell you how to present this and any other feature similar to this
 > in a way which would make me a lot more willing to accept it, which
 > presupposes I'm doing Linus' job which of course I am not.  However,
 > it's likely that Linus has similar views but he gets to chime in and
 > speak for himself.
 > 
 > All of these tools/features/whatever add some cost.  The cost can be 
 > measured in lots of different ways:
 > 
 >     - lines of code
 >     - lines of code which can't be configed out
 >     - call depth increases
 >     - stack size increases
 >     - cache foot print increases
 >     - parallelism (think preempt)
 >     - interface changes
 > 
 > I suspect there are other metrics and it would be very cool if others would
 > chime in with their pet peeves.
 > 
 > What would be cool is if there was some way to quantify as much as possible 
 > of the accepted set of costs so that that could be balanced against the 
 > value of the change, right?
 > 
 > The one that always gets me is
 > 
 >     "I've added feature XYZ, I benchmarked it with <whatever, usually
 >     LMbench> and it didn't make a difference"
 > 
 > That is almost certainly misleading.  The real thing you want to do
 > is quantify the actual costs because there can be non-zero costs that
 > do not show up in benchmarks.  For example, suppose that the benchmark
 > neatly fits in the onchip caches and it only uses 1/2 of those caches.
 > Your change could increase the cache foot print to just fill the caches,
 > the benchmark says no difference, you declare success and move on.
 > The problem is that almost all changes are good enough that they match
 > this description.  Measuring them in isolation doesn't tell us enough.
 > If I combine two changes, both of which use up 1/2 the cache, there is
 > no longer any room for anything else in the cache.
 > 
 > I'd love to see a trend where patch requests for any non-trivial patch
 > included before/after data for the above metrics (and any others that 
 > people see as useful).  I'd love to see some people taking just one of 
 > the above and making a tool which measures that metric.  Then we combine
 > the tools into a "patch measurement suite" and start prefixing patches
 > with
 > 
 >     Code changes:
 > 	+1234 -5678 = -4444	(all code)
 > 	+123 -567 = -444	(all code subject to CONFIG_XYZ)
 > 
 >     Call depth:
 > 	+2 for read()
 > 	+2 for write()
 > 	no change for all other system calls
 > 
 >     Stack size:
 > 	+2099 bytes for read()/write() path
 > 
 >     Cache misses:
 > 	No change for benchmark1, 2, 3
 > 	12,000 data read misses for lat_ctx ....
 >     
 >     Etc.
 > 
 > What does the list think of this?
 > -- 
 > ---
 > Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

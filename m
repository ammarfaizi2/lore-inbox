Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUJFTlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUJFTlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUJFTlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:41:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14521 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269382AbUJFTlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:41:07 -0400
Message-ID: <41644A3D.4050100@pobox.com>
Date: Wed, 06 Oct 2004 15:40:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
References: <200410060042.i960gn631637@unix-os.sc.intel.com>	<20041005205511.7746625f.akpm@osdl.org>	<416374D5.50200@yahoo.com.au>	<20041005215116.3b0bd028.akpm@osdl.org>	<41637BD5.7090001@yahoo.com.au>	<20041005220954.0602fba8.akpm@osdl.org>	<416380D7.9020306@yahoo.com.au>	<20041005223307.375597ee.akpm@osdl.org>	<41638E61.9000004@pobox.com> <20041005233958.522972a9.akpm@osdl.org>
In-Reply-To: <20041005233958.522972a9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>>
>>>
>>>>Any thoughts about making -rc's into -pre's, and doing real -rc's?
>>>
>>>
>>>I think what we have is OK.  The idea is that once 2.6.9 is released we
>>>merge up all the well-tested code which is sitting in various trees and has
>>>been under test for a few weeks.  As soon as all that well-tested code is
>>>merged, we go into -rc.  So we're pipelining the development of 2.6.10 code
>>>with the stabilisation of 2.6.9.
>>>
>>>If someone goes and develops *new* code after the release of, say, 2.6.9
>>>then tough tittie, it's too late for 2.6.9: we don't want new code - we
>>>want old-n-tested code.  So your typed-in-after-2.6.9 code goes into
>>>2.6.11.
>>>
>>>That's the theory anyway.  If it means that it takes a long time to get
>>
>>This is damned frustrating :(  Reality is _far_ divorced from what you 
>>just described.
> 
> 
> s/far/a bit/
> 
> 
>>Major developers such as David and Al don't have trees that see wide 
>>testing, their code only sees wide testing once it hits mainline.  See 
>>this message from David, 
>>http://marc.theaimsgroup.com/?l=linux-netdev&m=109648930728731&w=2
>>
> 
> 
> Yes, networking has been an exception.  I think this has been acceptable
> thus far because historically networking has tended to work better than
> other parts of the kernel.  Although the fib_hash stuff was a bit of a
> fiasco.

That's a prime example, yes...


>>In particular, I think David's point about -mm being perceived as overly 
>>experimental is fair.
> 
> 
> I agree - -mm breaks too often.  You wouldn't believe the crap people throw
> at me :(.   But a lot of problems get fixed this way too.
> 
> 
>>Recent experience seems to directly counter the assertion that only 
>>well-tested code is landing in mainline, and it's not hard to pick 
>>through the -rc changelogs to find non-trivial, non-bugfix modifications 
>>to existing code.
> 
> 
> Once we hit -rc2 we shouldn't be doing that.

Why does -rc2 have to be a magic number?  Does that really make sense to 
users that we want to be testing our stuff?

"We picked a magic number, after which, we hope it becomes more stable 
even if it doesn't work out like that in practice"


>> My own experience with netdev-2.6 bears this out as 
>>well:  I have several personal examples of bugs sitting in netdev (and 
>>thus -mm) for quite a while, only being noticed when the code hits mainline.
> 
> 
> yes, I've had a couple of those.  Not too many, fortunately.  But having
> bugs leak in mainline is OK - we expect that.  As long as it wasn't late in
> the cycle.  If it was late in the cycle then, well,
> bad-call-won't-do-that-again.
> 
> 
>>Linus's assertion that "calling it -rc means developers should calm 
>>down" (implying we should start concentrating on bug fixing rather than 
>>more-fun stuff) is equally fanciful.
>>
>>Why is it so hard to say "only bugfixes"?
> 
> 
> (It's not "only bugfixes".  It's "only bugfixes, completely new stuff and
> documentation/comment fixes).
> 
> But yes.  When you see this please name names and thwap people.

I thought I just did ;-)


>>The _reality_ is that there is _no_ point in time where you and Linus 
>>allow for stabilization of the main tree prior to relesae.  The release 
>>criteria has devolved to a point where we call it done when the stack of 
>>pancakes gets too high.
> 
> 
> That's simply wrong.
> 
> For instance, 2.6.8-rc1-mm1-series had 252 patches.  I'm now sitting on 726
> patches.  That's 500 patches which are either non-bugfixes or minor
> bugfixes which are held back.  The various bk tree maintainers do the same
> thing.

Sure I'm sitting on over 100 net driver csets myself.  I'm glad, but the 
overall point is still that "-rc" -- which stands for Release Candidate 
-- is nowhere near release candidate status when -rc1 hits, and fluff 
like sparse notations and changes like the fasync API change in 2.6.8 
always seem to sneak in at the last minute, further belieing(sp?) the 
supposed Release Candidate status.

No matter the effort of maintainers to hold back patches, every 
violation of the Release Candidate Bugfixes Only policy serves to 
undermine user confidence and invalidate previous Q/A work.

	Jeff



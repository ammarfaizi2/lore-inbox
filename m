Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUKCVXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUKCVXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUKCVXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:23:25 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:32897 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261895AbUKCVW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:22:28 -0500
Message-ID: <41894CA6.80307@tmr.com>
Date: Wed, 03 Nov 2004 16:24:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
References: <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org><Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> You just don't get it. I, too, can make a so-called bench-mark
> that will "prove" something that's so incredibly invalid that
> it shouldn't even deserve an answer. However, because you
> are supposed to know what you are doing, I will give you
> an answer.
> 
> It is totally impossible to perform useful work with memory,
> i.e., poping the value of something from memory into a register,
> without incurring the cost of that memory access. It doesn't
> matter if the memory is in cache or if it needs to be read
> using the memory controller. Time is time and it never runs
> backwards. I spend most of my days with hardware logic analyzers
> looking at the memory accesses so I damn-well know what I
> am taking about. That memory-access takes a time-slot that
> something else can't use. You never get it back. It is gone
> forever. This is very important to understand. If you don't
> understand this, you can fall into the "black-magic" trap.
> 
> Modern CPUs make it easy for so-called software engineers to
> perceive so-called facts that are not, in fact, true. Because
> it is possible for the CPU to perform memory-access independent
> of instruction sequence (so-called parallel operations), it is
> possible to make bench-marks that prove nothing, but seem to
> show that a read from memory is free. It can never be free. It
> will eventually show up. It was just deferred. Of course, if
> your computer is just going to run that single bench-mark, then
> return to a prompt, you can readily become victum of a very
> common error because there is now plenty of time available to
> just spin (or wait for an interrupt).
> 
> So, if you really want to make things fast, you keep your
> memory accesses to the absolute minimum. Poping something
> from the stack is the antithesis of what you want to do.
> 
> It's really amusing. Software development has devolved
> into some black magic where logic, mathematics, and
> physical testing no longer thrive.
> 
> Instead, we must listen to those who profess to know
> about this magic because of some innate enlightenment
> imparted to those favored few who are able to perceive
> the trueness of their intellectual perception without
> regard for contrary physical observations.
> 
> It's wonderful to not be bothered by tests, measurements,
> documentation, or other facts.
> 
> Wake up and don't be dragged into the black-magic trap.

The election is over, we can adopt a civil non-confrontational tone 
again... Linus is not always right, but like most people he responds 
better to "let me give you additional information" than "I know more 
than you, take my word for it."

In this case, I think Dick does have a point on memory to cache use. It 
appears from what little stuff I have here that with HT cache access is 
serialized, and that memory access, even to L1 cache, might under some 
circumstances be delayed. I won't guess if you would ever see that in 
practice.

Getting information out of noisy measurements is not easy, and while 
Dick is probably right that the lowest time is the "real" time, if the 
average is lower doing something else, isn't that what we want?

My response test reports low, high, average, median, and 90th percentile 
values, and depending on whether you want the best average, best 
typical, or worst case avoidance you might find any of them useful. Oh, 
and S.D. of the data to hint on how much you trust the results. I don't 
think any of the test programs produce the definitive result, and I see 
that results change depending on the CPU.

I think there are a lot of things more deserving this level of 
consideration.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

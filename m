Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSBRACe>; Sun, 17 Feb 2002 19:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293378AbSBRACX>; Sun, 17 Feb 2002 19:02:23 -0500
Received: from holomorphy.com ([216.36.33.161]:19844 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291624AbSBRACQ>;
	Sun, 17 Feb 2002 19:02:16 -0500
Date: Sun, 17 Feb 2002 16:02:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, phillips@bonn-fries.net,
        davem@redhat.com, anton@samba.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] [rmap] operator-sparse Fibonacci hashing of waitqueues
Message-ID: <20020218000202.GC3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rwhron@earthlink.net, linux-kernel@vger.kernel.org,
	riel@surriel.com, phillips@bonn-fries.net, davem@redhat.com,
	anton@samba.org, rusty@rustcorp.com.au
In-Reply-To: <20020217230159.GA17136@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020217230159.GA17136@rushmore>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Randy, any chance you could benchmark -rmap with this on top for
>> comparison against standard -rmap to ensure there is no regression?

On Sun, Feb 17, 2002 at 06:01:59PM -0500, rwhron@earthlink.net wrote:
> System is k6-2 475 mhz and 384 MB ram with IDE disks.
> Here it is with a few notes on things I looked at more closely.
> I also have the output of readprofile between each test.

Excellent! Thank you very much.

On Sun, Feb 17, 2002 at 06:01:59PM -0500, rwhron@earthlink.net wrote:
> pipe context switching in unixbench results initially looked concerning,
> but looking at how the test varies, and context switch and pipe tests
> in lmbench suggest that the lower number may not be significant.

It's unclear what effect, if any, the waitqueue hashing should have on
pipes and context switching in general. There are waitqueues involved
but they are not associated with pages.

On Sun, Feb 17, 2002 at 06:01:59PM -0500, rwhron@earthlink.net wrote:
> The TCP and AF bandwdith numbers vary a lot between tests.  Oddly, the TCP
> test appears to vary by almost 100% between iterations.  Here are the 
> individual test results;

I'm not sure why this would be affected either, but again, it's certainly
useful to check these things for unanticipated effects.

Dave, Rik, Dan, do you know of any reason why there would be an effect
here (or with pipes)?

On Sun, Feb 17, 2002 at 06:01:59PM -0500, rwhron@earthlink.net wrote:
> The tbench test below doesn't show a large variation between the
> two kernels.

This is excellent, and largely the desired result. This sort of benchmark
is what I believe what would demonstrate any degradation in performance
during a real workload.

More detailed analysis could show that I need to adjust the multipliers
to eliminate the ones I've chosen as one of the occasional poor
multipliers chosen by this process, but I have a steady and large
supply of these multipliers, and these macro-throughput results seem to
indicate it is almost certainly not one of those (bad ones should cause
noticeable degradation, especially with the wake-all then sleep if wrong
object semantics), so it's already fairly unlikely it's one of those.
I'll try to get whatever hash table profiling I can on this thing as well.

Anton, Rusty, I could use help on extracting hash table stats here,
I can compute confidernce intervals etc. at will but extraction...

Dave, it would be useful to hear from you on this issue as you have
closer connections to machines where multiplication is expensive.


Cheers,
Bill

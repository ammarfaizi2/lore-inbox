Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272279AbRHXRyo>; Fri, 24 Aug 2001 13:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272282AbRHXRye>; Fri, 24 Aug 2001 13:54:34 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:30217 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S272279AbRHXRy1>;
	Fri, 24 Aug 2001 13:54:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108241754.f7OHsLr94559@saturn.cs.uml.edu>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC
To: paubert@iram.es (Gabriel Paubert)
Date: Fri, 24 Aug 2001 13:54:21 -0400 (EDT)
Cc: paulus@samba.org (Paul Mackerras),
        cfriesen@nortelnetworks.com (Chris Friesen),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.21.0108240856370.1353-100000@ltgp.iram.es> from "Gabriel Paubert" at Aug 24, 2001 09:32:31 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert writes:
> On Thu, 23 Aug 2001, Paul Mackerras wrote:
>> Gabriel Paubert writes:

>>> As I said in an earlier message the __USE_RTC macro
>>> should be made dependent on whether the kernel supports 601 or not.
>>
>> We don't have USE_RTC in 2.2.  The proposed patch was for 2.2.19.
>
> Ok, I looked at the wrong tree in my small forest :-) My 2.2 tree has the
> timing/clock changes of 2.4 since it's actually where I first wrote them
> when chasing why NTP's PLL frequency error estimate varied according to
> system load. Nevertheless, Chris needs something similar to USE_RTC.
>
>>> No, this is not what they are trying to capture. Furthermore the 7 LSB of
>>> the decrementer on a 601 are not random (but they don't seem to be 0
>>> always despite the documentation) so you would have to shift the result
>>
>> Don't you mean that the 7 LSB of RTCL aren't random and are supposed
>> to be 0?  The decrementer should decrement by 1 at a rate of 7.8125MHz
>> and all the bits should be implemented.
>
> No, both the RTC and the decrementer count nanoseconds, except that the 7
> LSB are not implemented because the timebase clock should have a period of
> 128 ns (7.8125 MHz, but according to Takashi Oe, many 601 systems did not
> bother to provide the exact frequency and are off by 11 parts in 4096 or
> so). As such the LSB can't be used to estimate randomness and the value
> must be shifted right by 7. So you need some conditional code (or boot
> time patching). At this point you can throw in the high order part
> (RTCU/TBU) for additional randomization (RTCU changes much faster on 601,
> once per second, than on the other processors).

Note that you don't really need anything related to wall clock time.

You could use whatever performance counters the 601 has, if any.
That might be cache hits, cache misses, instructions dispatched,
correctly predicted branches, cycles spent waiting for a load...
The memory controller and host bridge might have useful stuff too.

You could use registers from whatever was most recently interrupted.
That might include the CR, LR, and instruction pointer. One might
exclude data from non-root user processes if being overly paranoid.


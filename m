Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268827AbTBZQmq>; Wed, 26 Feb 2003 11:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268828AbTBZQmq>; Wed, 26 Feb 2003 11:42:46 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58269 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268827AbTBZQmo>; Wed, 26 Feb 2003 11:42:44 -0500
Date: Wed, 26 Feb 2003 08:52:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Mikael Pettersson <mikpe@csd.uu.se>,
       Asit Mallick <asit.k.mallick@intel.com>, jamesclv@us.ibm.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <8750000.1046278359@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302260813510.1423-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302260813510.1423-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, after having re-read the ESR description in the Intel manuals, and 
> looking at our code, I think the code has always been crap.

Personally I'd point the finger more in the direction of the hardware for
that remark, but still ;-)
 
> The manual clearly states that you clear the ESR by doing back-to-back
> writes, and that you read it by writing to it and then reading it. That's
> not at _all_ what we do at bootup. It's _also_ not what we do at 
> "clear_local_apic()".

Right ... not sure what they were smoking when they wrote / implemented
that, but yes, that's what it says.
 
> Also, I would _assume_ that the error interrupt is active based on the
> bit-wise "or" of both the latched and the real value, since the docs
> clearly say that it must be cleared by sw by back-to-back writes
> (rationale: if the error interrupt is only triggered by the latch it is
> obviously useless, since we wouldn't get an interrupt for new events. If
> the error interrupt is only triggered by the real value, we'd only need a
> single write to clear it).
> 
> Anyway, the above is clearly not what we're doing with the ESR right now.
> 
> Martin: in the esr disable case you clearly write the ESR multiple times
> ("over the head with a big hammer"), and you must do that because you
> noticed that a single write was insufficient. Why four? Did you just
> decide that as long as you're doing multiple writes, you might as well
> just do "several". Or did four writes work and two didn't?

The latter, IIRC, 2 writes worked most of the time, but never really fixed
it. Using any kind of logical analysis never seemed to work on that chip
... brute force, trial and error, and 3 months of tearing my hair out was
the only thing that suceeded in the end. A time I have no wish to revisit
;-)

cc'ed James Cleverdon ... he was involved in this with PTX, and gave me
some  pointers to hair-restorer during the Linux timeframe. 

M.

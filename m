Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271230AbRHTOCD>; Mon, 20 Aug 2001 10:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271216AbRHTOBx>; Mon, 20 Aug 2001 10:01:53 -0400
Received: from waste.org ([209.173.204.2]:48417 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S271234AbRHTOBk>;
	Mon, 20 Aug 2001 10:01:40 -0400
Date: Mon, 20 Aug 2001 09:01:36 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Theodore Tso <tytso@mit.edu>, David Wagner <daw@mozart.cs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <3B80BEE3.4C9A0A76@idb.hist.no>
Message-ID: <Pine.LNX.4.30.0108200856390.4612-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Helge Hafting wrote:

> Oliver Xymoron wrote:
> >
> > Can I propose an add_untrusted_randomness()? This would work identically
> > to add_timer_randomness but would pass batch_entropy_store() 0 as the
> > entropy estimate. The store would then be made to drop 0-entropy elements
> > on the floor if the queue was more than, say, half full. This would let us
> > take advantage of 'potential' entropy sources like network interrupts and
> > strengthen /dev/urandom without weakening /dev/random.
>
> It seems to me that it'd be better with an
> add_interrupt_timing_randomness() function.
>
> This one should modify the entropy pool, and add no more to the
> entropy count than the internal interrupt timing allow,
> i.e. assume that "the ouside" observed the event that
> trigged the interrupt.   How much is architecture dependent:
>
> A machine with a clock-counter, like a pentium, can add
> a number of bits from the counter, as the timing is
> documented variable.  (There could be several interrupts
> queued up, the interrupt stacks and routines
> may or may not be in level-1 cache)  Even a conservative approach
> assuming a lot of worst cases would end up adding _some_.

Until you've spent a while trying to mount a serious timing attack, I
think any arguments as to how much entropy is there are just a bunch of
handwaving. Interrupt generation on an otherwise quiescent machine is
extremely deterministic.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


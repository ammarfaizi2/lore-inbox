Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271112AbRHTHlo>; Mon, 20 Aug 2001 03:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271113AbRHTHle>; Mon, 20 Aug 2001 03:41:34 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7952 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271112AbRHTHl3>; Mon, 20 Aug 2001 03:41:29 -0400
Message-ID: <3B80BEE3.4C9A0A76@idb.hist.no>
Date: Mon, 20 Aug 2001 09:40:19 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>, Theodore Tso <tytso@mit.edu>,
        David Wagner <daw@mozart.cs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.30.0108191808350.740-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Sun, 19 Aug 2001, Theodore Tso wrote:
> 
> > The bottom line is it really depends on how paranoid you want to be,
> > and how much and how closely you want /dev/random to reliably replace
> > a true hardware random number generator which relies on some physical
> > process (by measuring quantum noise using a noise diode, or by
> > measuring radioactive decay).  For most purposes, and against most
> > adversaries, it's probably acceptable to depend on network interrupts,
> > even if the entropy estimator may be overestimating things.
> 
> Can I propose an add_untrusted_randomness()? This would work identically
> to add_timer_randomness but would pass batch_entropy_store() 0 as the
> entropy estimate. The store would then be made to drop 0-entropy elements
> on the floor if the queue was more than, say, half full. This would let us
> take advantage of 'potential' entropy sources like network interrupts and
> strengthen /dev/urandom without weakening /dev/random.

It seems to me that it'd be better with an
add_interrupt_timing_randomness() function.

This one should modify the entropy pool, and add no more to the
entropy count than the internal interrupt timing allow,
i.e. assume that "the ouside" observed the event that
trigged the interrupt.   How much is architecture dependent:

A machine with a clock-counter, like a pentium, can add
a number of bits from the counter, as the timing is
documented variable.  (There could be several interrupts
queued up, the interrupt stacks and routines
may or may not be in level-1 cache)  Even a conservative approach
assuming a lot of worst cases would end up adding _some_.

A 386 may have to add 0to the count, as it don't have a high-speed
timer.
People who have a network-only machine can go for
something better than 386 though.

Helge Hafting

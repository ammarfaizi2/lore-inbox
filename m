Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277552AbRJKASg>; Wed, 10 Oct 2001 20:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJKAS0>; Wed, 10 Oct 2001 20:18:26 -0400
Received: from [208.129.208.52] ([208.129.208.52]:18950 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277552AbRJKASM>;
	Wed, 10 Oct 2001 20:18:12 -0400
Date: Wed, 10 Oct 2001 17:24:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: yodaiken@fsmlabs.com, <kaos@ocs.com.au>, <paulus@samba.org>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <20011010.164628.39155290.davem@redhat.com>
Message-ID: <Pine.LNX.4.40.0110101715180.972-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, David S. Miller wrote:

>    From: Victor Yodaiken <yodaiken@fsmlabs.com>
>    Date: Wed, 10 Oct 2001 16:24:19 -0600
>
>    In general you're right, and always its better to
>    reduce contention than to come up with silly algorithms for
>    reducing the cost of contention,
>
> I want to second this and remind people that the "cost" of spinlocks
> is mostly not "spinning idly waiting for lock", rather the big cost
> is shuffling the dirty cacheline ownership between the processors.
>
> Any scheme involving shared data which is written (the read counts
> in the various "lockless" schemes are examples) have the same "cost"
> assosciated with them.
>
> In short, I see no performance gain from the lockless algorithms
> even in the places where they can be applied.
>
> I spent some time oogling over lockless algorithms a few years ago,
> but I stopped once I realized where the true costs were.  In my view,
> the lockless algorithms perhaps are a win in parallel processing
> environments (in fact, the supercomputing field is where a lot of the
> lockless algorithm research comes from) but not in the kinds of places
> and with the kinds of data structure usage the Linux kernel has.

Agree.
To have a complete list handling you've to end up locking or
write stressing counter variables to simulate locks.
Just only having special handled lists that removes write ops from irq
handlers can make you save a big cost of ..._irqsave()/restore().
And these can be realized by having an extra list of insert/remove ops
that is filled with no locks by irq handlers and is truncated/flushed by a
__xchg() done by readers.




- Davide



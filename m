Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277540AbRJJXrX>; Wed, 10 Oct 2001 19:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJJXrN>; Wed, 10 Oct 2001 19:47:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19335 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277540AbRJJXq5>;
	Wed, 10 Oct 2001 19:46:57 -0400
Date: Wed, 10 Oct 2001 16:46:28 -0700 (PDT)
Message-Id: <20011010.164628.39155290.davem@redhat.com>
To: yodaiken@fsmlabs.com
Cc: kaos@ocs.com.au, paulus@samba.org, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of
 lists with insertion
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011010162419.A13116@hq2>
In-Reply-To: <16510.1002751003@ocs3.intra.ocs.com.au>
	<20011010162419.A13116@hq2>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Victor Yodaiken <yodaiken@fsmlabs.com>
   Date: Wed, 10 Oct 2001 16:24:19 -0600
   
   In general you're right, and always its better to 
   reduce contention than to come up with silly algorithms for 
   reducing the cost of contention,

I want to second this and remind people that the "cost" of spinlocks
is mostly not "spinning idly waiting for lock", rather the big cost
is shuffling the dirty cacheline ownership between the processors.

Any scheme involving shared data which is written (the read counts
in the various "lockless" schemes are examples) have the same "cost"
assosciated with them.

In short, I see no performance gain from the lockless algorithms
even in the places where they can be applied.

I spent some time oogling over lockless algorithms a few years ago,
but I stopped once I realized where the true costs were.  In my view,
the lockless algorithms perhaps are a win in parallel processing
environments (in fact, the supercomputing field is where a lot of the
lockless algorithm research comes from) but not in the kinds of places
and with the kinds of data structure usage the Linux kernel has.

Franks a lot,
David S. Miller
davem@redhat.com


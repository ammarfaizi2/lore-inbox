Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277567AbRJMRXj>; Sat, 13 Oct 2001 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRJMRX3>; Sat, 13 Oct 2001 13:23:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18443 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277567AbRJMRXV>; Sat, 13 Oct 2001 13:23:21 -0400
Date: Sat, 13 Oct 2001 10:23:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
cc: <dipankar@beaverton.ibm.com>, <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <OF8D375F1C.810E1992-ON88256AE4.0050CCA0@boulder.ibm.com>
Message-ID: <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Paul McKenney wrote:
>
> The reference counts are needed -only- in cases where references to an
> RCU-protected data structure may be held across a sleep.

My point is that
 (a) such uses are not very common.
 (b) the whole notiong of "scheduling point" is a lot too fragile to be
     acceptable for important data structures. It breaks with the
     pre-emption patches on UP, and we've seen many times how hard it is
     for developers to notice even when there _is_ an explicit "end
     critical region now"  kind of thing

Have you seen how many uses of implicitly blocking operations there have
been with interrupts disabled or spinlocks held? Now, if the data
structure doesn't even have a "ok, I'm done with you" thing, then those
kinds of mistakes are going to be not only impossible to find
automatically, but they are going to be even easier to make by mistake.

In short, RCU has several problems in my opinion:

 - nobody has shown a case where existing normal locking ends up being
   really a huge problem, and where RCU clearly helps.

 - RCU obviously has major subtle issues, ranging from memory ordering to
   "what is quiescent", ie the scheduling points. And "subtlety" directly
   translates into bugs and hard-to-debug seldom-seen problems that end up
   being "unexplainable".

In short, RCU seems to be a case of "hey, that's cool", but it's a
solution in search of a problem so severe that it is worth it.

		Linus


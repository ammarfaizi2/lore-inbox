Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRDEH72>; Thu, 5 Apr 2001 03:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRDEH7S>; Thu, 5 Apr 2001 03:59:18 -0400
Received: from out2.prserv.net ([32.97.166.32]:54495 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S132571AbRDEH7D>;
	Thu, 5 Apr 2001 03:59:03 -0400
Message-Id: <m14krZM-001PKdC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Mon, 02 Apr 2001 12:56:14 MST."
             <3AC8D95E.7E3A68B0@mvista.com> 
Date: Thu, 05 Apr 2001 03:59:48 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3AC8D95E.7E3A68B0@mvista.com> you write:
> On a higher level, I think the scanning of the run list to set flags and
> counters is a bit off.

[snip standard refcnt scheme]

For most things, refcnts are great.  I use them in connection
tracking.  But when writes can be insanely slow (eg. once per hour),
those two atomic ops just hurt scalability, and are invasive.

In particular, they suck HARD for modules, which is where my initial
quiescent wait implementation came from, only I didn't call it that
because Andi hadn't posted the Sequent paper URL yet and I hadn't
figured out that this was a generically useful scheme that can be
implemented in 20 lines...

Rusty.
--
Premature optmztion is rt of all evl. --DK

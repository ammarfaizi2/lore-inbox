Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318081AbSGMAur>; Fri, 12 Jul 2002 20:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSGMAuq>; Fri, 12 Jul 2002 20:50:46 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:15040 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318081AbSGMAuY>;
	Fri, 12 Jul 2002 20:50:24 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207130050.EAA32540@sex.inr.ac.ru>
Subject: Re: 64 bit netdev stats counter
To: davem@redhat.COM (David S. Miller)
Date: Sat, 13 Jul 2002 04:50:18 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020712.145835.91443486.davem@redhat.com> from "David S. Miller" at Jul 13, 2 02:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 32-bit values aren't atomic either, what is the issue?
...
> output "incl MEM" or similar for net_stats->counter++, since
> it lacks the 'lock;' prefix it is not atomic.

The issue is that this does not matter, all the updates to counters
are serialized by driver logic in any case.

The counters were atomic wrt _read_ i.e. read used to produce valid result
rather than a garbage. We have discussed this some time ago, someone
proposed to use pair of 32bit numbers and prohibiting direct read,
fetching  the result with a macro sort of

	  do {
	     result_lo = lo;
	     result_hi = hi;
	  } while (lo != result_lo);

or something similar. Well, plus some barriers when/if needed.

Honestly, I do not feel any enthusiasm about doing this in kernel.
Some small bit of useless work each packet, some minor waste of memory,
some minor crap in code... All this is not essential, but does not cause any
enthisiasm yet. :-)

Alexey


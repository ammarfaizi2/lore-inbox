Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbSIST7i>; Thu, 19 Sep 2002 15:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272723AbSIST7i>; Thu, 19 Sep 2002 15:59:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22658 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272682AbSIST7h>; Thu, 19 Sep 2002 15:59:37 -0400
Date: Thu, 19 Sep 2002 16:07:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Martin Mares <mj@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
In-Reply-To: <20020919192758.GA430@ucw.cz>
Message-ID: <Pine.LNX.3.95.1020919155422.16070A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Martin Mares wrote:

> Hello, world!\n
> 
> > nevertheless we do lock up for 32 seconds if there are 32K PIDs allocated
> > in a row and last_pid hits that range - regardless of pid_max. (Depending
> > on the cache architecture it could take significantly more.)
> 
> What about randomizing the PID selection a bit? I.e., allocate PIDs
> consecutively as long as they are free; if you hit an already used
> PID, roll dice to find a new position where the search should be
> continued. As long as the allocated fraction of PID space is reasonably
> small, this algorithm should be very quick in average case.
> 
> Another possible solution: Divide PID space to blocks and for each
> block, keep a counter of PID's available in this block and when
> allocating, just skip blocks which are full. Runs in O(sqrt(PID space
> size)) in the worst case.
> 
> 				Have a nice fortnight

I remember something like the pid problem a few years ago when
somebody needed to get a unique 'key' value. The 'key' value was
used by a lock manager. It was not random, it just needed to be
unique, sort of like a pid. As I recall, the selection went something
like this:

(1)	When keys were given up (released), the key value was compared
with the last, lowest-key value given up. If this was lower, the last
lowest key-value was substituted.

(2)	When keys were allocated, the last lowest key-value was used.
Upon its use, the next available highest key-value was substituted.

(3)	Somehow, I don't remember the alogrithm, the highest key-
value became the lowest key-value when all the higher keys were
released. At this time, everything was free.

Nobody ever had to scan anything to get the next-available key.
So what was saved in memory was, the highest key-value allocated, and
the lowest key-value allocated.

Anybody here work on the Cluster Lock Manager for DEC?  That's what
used the keys.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


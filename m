Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263449AbRFCQVS>; Sun, 3 Jun 2001 12:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263504AbRFCQGv>; Sun, 3 Jun 2001 12:06:51 -0400
Received: from cs.huji.ac.il ([132.65.16.10]:60609 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id <S263338AbRFCQGm>;
	Sun, 3 Jun 2001 12:06:42 -0400
Message-ID: <3B1A608E.21AE7C5B@cs.huji.ac.il>
Date: Sun, 03 Jun 2001 19:06:38 +0300
From: Tsafrir Dan <dants@cs.huji.ac.il>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-6.2.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: etsman@cs.huji.ac.il, feit@cs.huji.ac.il
Subject: the value of PROC_CHANGE_PENALTY
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as I understand, for i386 in Linux-2.2.x the default length
of a quantum was 200ms, and in 2.4.x it had changed to 50ms
(
 according to the following 2.4.5 sched.c code:

    #if HZ < 200
    #define TICK_SCALE(x)   ((x) >> 2)
    ...
    #define NICE_TO_TICKS(nice)     (TICK_SCALE(20-(nice))+1)
    ...
    /* in the `recalculate' portion of schedule(): ... */
    for_each_task(p)
        p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
)

But, 
the value of PROC_CHANGE_PENALTY was not changed accordingly, and is 
still 15. This means that the result of the following goodness() code:
    if (p->processor == this_cpu)
        weight += PROC_CHANGE_PENALTY;
is that any task that executed on `this_cpu' (goodness > 15) 
will always be more "desirable" then a task that executed on 
another cpu (goodness <= 6) which was not the case in 2.2.x .

am I correct ?
and if so, is this what the authors meant, or did they simply forget
to update PROC_CHANGE_PENALTY's value when moving from 2.2 to 2.4 ?

please cc me: dants@cs.huji.ac.il
thanks, dan.

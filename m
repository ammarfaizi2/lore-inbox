Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283857AbRLABF7>; Fri, 30 Nov 2001 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281297AbRLABFu>; Fri, 30 Nov 2001 20:05:50 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:38388 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283857AbRLABFi>; Fri, 30 Nov 2001 20:05:38 -0500
Message-ID: <3C082CBA.B66BF30F@mvista.com>
Date: Fri, 30 Nov 2001 17:04:58 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David C. Hansen" <dave@sr71.net>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [LART] pc_keyb.c changes
In-Reply-To: <Pine.GSO.4.21.0111300252030.13367-100000@weyl.math.psu.edu> <3C07FB73.9030708@sr71.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David C. Hansen" wrote:
> 
> Alexander Viro wrote:
> 
> >       Could the person who switched from BKL to spin_lock_irqsave() in
> > pc_keyb.c please share whatever the hell he had been smoking?  Free clue:
> > disabling interrupts for long intervals to improve scalability is right up
> > there with fighting for peace and fucking for virginity.
> As I slowly raise my hand to take, um credit....
> 
> This is definitely one of the drivers I to take a second look at, now
> that I know about the BKL being held for block and char device opens.
> Do you have any ideas how else to do this safely since aux_count is
> referenced during an interrupt?
> 
Um, staying as far away from that bit of source as possible, I will
offer:

It depends on how it is referenced.  If it is just a counter, you may be
able to just make it atomic.  If it needs to "stick" for a little
longer, then consider if there are many readers and only a few writers,
in which case look at the read/write_lockirq code, however, this does
have the down side of irq off.  BKL did not protect against interrupts,
so one wonders if the irq bit is needed at all.  
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/

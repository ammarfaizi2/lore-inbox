Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSD1VvF>; Sun, 28 Apr 2002 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSD1VvE>; Sun, 28 Apr 2002 17:51:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29432 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S310435AbSD1VvD>;
	Sun, 28 Apr 2002 17:51:03 -0400
Message-ID: <3CCC6EAD.22A439F7@mvista.com>
Date: Sun, 28 Apr 2002 14:50:37 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <E171ttN-0004YP-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > We do anyway
> >
> > Yes, but now we do all this in the timer tick, not in schedule().  This
> > occures much less often.
> 
> Well in the timer tick code we already hold the locks needed to check
> the front of the timer queue safely, we already have current and the top
> timer needing to touch cache (current for accounting stats at the least).
> So thats what an extra compare and cmov - 1 clock maybe 2 ?

The problem is the extra code in the schedule() path, not in the timer
tick path.  It is traversed FAR more often.

The current tick at 1/HZ is really quite relaxed.  Given the PIT (ugh!)
the longest we can put off a tick is about 50 ms.  This means that any
time greater than this will require more than one interrupt, i.e. the
best case improvement by going tick less (again given the PIT) is about
5 times.  Other platforms/ hardware, of course, change this.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274667AbRJEXtA>; Fri, 5 Oct 2001 19:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274669AbRJEXsu>; Fri, 5 Oct 2001 19:48:50 -0400
Received: from mailf.telia.com ([194.22.194.25]:14289 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S274667AbRJEXsk>;
	Fri, 5 Oct 2001 19:48:40 -0400
Message-Id: <200110052348.f95NmhP04437@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        davidel@xmailserver.org (Davide Libenzi)
Subject: Re: Context switch times
Date: Sat, 6 Oct 2001 01:43:37 +0200
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), george@mvista.com (george anzinger),
        bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <E15pe0t-0007wz-00@the-village.bc.nu>
In-Reply-To: <E15pe0t-0007wz-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 October 2001 01:04, Alan Cox wrote:
> > > This damps down task thrashing a bit, and for the cpu hogs it gets the
> > > desired behaviour - which is that the all run their full quantum in the
> > > background one after another instead of thrashing back and forth
> >
> > What if we give to  prev  a priority boost P=F(T) where T is the time
> > prev  is ran before the current schedule ?
>
> That would be the wrong key. You can argue certainly that it is maybe
> appropriate to use some function based on remaining scheduler ticks, but
> that already occurs as the scheduler ticks is the upper bound for priority
> band

How about a LIFO list for each processor where preempted (count != 0) tasks
go?

When a preemption occurs the current goes to the LIFO.
When a process has run whole of its time slot - it can be moved to an usedup
queue. (No point in keeping it on the generic run queue, but remember
it when giving out new ticks, could also be on a per CPU basis).
Now select what to do next..
The first on the LIFO can be moved in as "current" before checking the rest
of the run queue...

Pros:
+ The LIFO will be sorted with highest prio on top - no need to search 'em all
+ a process that starts a time slot on one CPU stays the whole slot.

Cons:
- A process might get stuck waiting for the processor in the FIFO while the
  other CPU is idle (but that was the point, wasn't it...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

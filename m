Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSANPcz>; Mon, 14 Jan 2002 10:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSANPcp>; Mon, 14 Jan 2002 10:32:45 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:5126 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286925AbSANPcg>; Mon, 14 Jan 2002 10:32:36 -0500
Date: Mon, 14 Jan 2002 07:38:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Jeff Dike <jdike@karaya.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: The O(1) scheduler breaks UML
In-Reply-To: <Pine.LNX.4.33.0201141043320.2248-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201140737520.1486-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Ingo Molnar wrote:

>
> On Sun, 13 Jan 2002, Davide Libenzi wrote:
>
> > > So, is it possible to enable IRQs across the call to _switch_to?
> >
> > Yes, this should work :
> >
> >     if (likely(prev != next)) {
> >         rq->nr_switches++;
> >         rq->curr = next;
> >         next->cpu = prev->cpu;
> >         spin_unlock_irq(&rq->lock);
> >         context_switch(prev, next);
> >     } else
> >         spin_unlock_irq(&rq->lock);
>
> this change is incredibly broken on SMP - eg. what protects 'prev' from
> being executed on another CPU prematurely. It's even broken on UP:
> interrupt context that changes current->need_resched needs to be aware of
> nonatomic context switches. See my previous mail.

yup, true. no more schedule_tail()



- Davide



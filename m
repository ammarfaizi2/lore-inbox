Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSJGRlz>; Mon, 7 Oct 2002 13:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261687AbSJGRlz>; Mon, 7 Oct 2002 13:41:55 -0400
Received: from pop.gmx.net ([213.165.64.20]:47945 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261662AbSJGRlV>;
	Mon, 7 Oct 2002 13:41:21 -0400
Message-Id: <5.1.0.14.2.20021007191310.00b4e268@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Oct 2002 19:44:10 +0200
To: Amol Lad <dal_loma@yahoo.com>, Arjan van de Ven <arjanv@redhat.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: wake_up from interrupt handler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007142520.56164.qmail@web12406.mail.yahoo.com>
References: <1033995858.2798.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:25 AM 10/7/2002 -0700, Amol Lad wrote:
>In this code too.. lost-wakeup problem is not solved
>
>if (event_occured)
>   else
>     schedule();
>
>what if in check ' if(event_occured) ' goes to 'else'
>and before calling schedule() my ISR interrupted this
>thread and set the event..

(yes, this is what I was thinking about)

>Also Mike told to disable the interrupt before
>checking for event... So When to enable interrupts
>then ??

(this mike)

Well, disabling interrupts as a solution aside :), why are you checking for 
event in the kthread?  It seems to me that receipt of wakeup has to be the 
sole knowledge that the event happened, else a race is a done deal. (no?)

         -Mike

>
>--- Arjan van de Ven <arjanv@redhat.com> wrote:
> > On Mon, 2002-10-07 at 14:41, Amol Lad wrote:
> > > Hi,
> > >  I have a kernel thread which did
> > add_to_wait_queue()
> > > to wait for an event.
> > > The event for which above thread is waiting occurs
> > in
> > > an interrupt handler that calls wake_up() to wake
> > the
> > > above thread.
> > > Now I am faced with a 'lost wakeup' problem, in
> > which
> > > the
> > > kernel thread checks whether event occured, he
> > finds
> > > it to be 'not-occured' but before calling
> > > add_to_wait_queue(), interrupt handler detects
> > that
> > > the event has occured and calls wake_up().
> > > My thread sleeps forever.
> >
> > set_current_state(TASK_INTERRUPTIBLE);
> > add_to_wait_queue(...);
> > if (even_occured) { ...}
> >   else
> >      schedule();
> >
> > remove_from_wait_queue(..);
> > set_current_state(TASK_RUNNABLE);
> >
> >
> > >
> >
> >
>
> > ATTACHMENT part 2 application/pgp-signature
>name=signature.asc
>
>
>
>__________________________________________________
>Do you Yahoo!?
>Faith Hill - Exclusive Performances, Videos & More
>http://faith.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


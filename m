Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbSJGOTp>; Mon, 7 Oct 2002 10:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbSJGOTp>; Mon, 7 Oct 2002 10:19:45 -0400
Received: from web12406.mail.yahoo.com ([216.136.173.133]:57720 "HELO
	web12406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263065AbSJGOTm>; Mon, 7 Oct 2002 10:19:42 -0400
Message-ID: <20021007142520.56164.qmail@web12406.mail.yahoo.com>
Date: Mon, 7 Oct 2002 07:25:20 -0700 (PDT)
From: Amol Lad <dal_loma@yahoo.com>
Subject: Re: wake_up from interrupt handler
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1033995858.2798.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this code too.. lost-wakeup problem is not solved

if (event_occured)
  else 
    schedule();

what if in check ' if(event_occured) ' goes to 'else'
and before calling schedule() my ISR interrupted this
thread and set the event..

Also Mike told to disable the interrupt before
checking for event... So When to enable interrupts
then ??
 
--- Arjan van de Ven <arjanv@redhat.com> wrote:
> On Mon, 2002-10-07 at 14:41, Amol Lad wrote:
> > Hi,
> >  I have a kernel thread which did
> add_to_wait_queue()
> > to wait for an event. 
> > The event for which above thread is waiting occurs
> in
> > an interrupt handler that calls wake_up() to wake
> the
> > above thread. 
> > Now I am faced with a 'lost wakeup' problem, in
> which
> > the    
> > kernel thread checks whether event occured, he
> finds
> > it to be 'not-occured' but before calling
> > add_to_wait_queue(), interrupt handler detects
> that
> > the event has occured and calls wake_up().
> > My thread sleeps forever.
> 
> set_current_state(TASK_INTERRUPTIBLE);
> add_to_wait_queue(...);
> if (even_occured) { ...} 
>   else
>      schedule();
>  
> remove_from_wait_queue(..);
> set_current_state(TASK_RUNNABLE);
> 
> 
> > 
> 
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc



__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318948AbSICWJN>; Tue, 3 Sep 2002 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSICWJN>; Tue, 3 Sep 2002 18:09:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25848 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318948AbSICWJM>;
	Tue, 3 Sep 2002 18:09:12 -0400
Message-ID: <3D7533F5.F00BB8E6@mvista.com>
Date: Tue, 03 Sep 2002 15:13:09 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: Thunder from the hill <thunder@lightweight.ods.org>,
       Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
Subject: Re: question on spinlocks
References: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm> <200209020033.23113.oliver@neukum.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> Am Montag, 2. September 2002 00:09 schrieb Thunder from the hill:
> > Hi,
> >
> > On Mon, 2 Sep 2002, Oliver Neukum wrote:
> > > > > No; spin_lock_irqsave/spin_unlock_irqrestore and
> > > > > spin_lock/spin_unlock have to be used in matching pairs.
> > > >
> > > > If it was his least problem! He'll run straight into a "schedule
> > > > w/IRQs disabled" bug.
> > >
> > > OK, how do I drop an irqsave spinlock if I don't have flags?
> >
> > IMHO you might even ask "How do I start a car when I don't have the
> > keys?"
> 
> Break off the lock, touch some cables ... ;-)
> 
> > You might find a way, but it's not desired. Are you sure you want to
> > reschedule in an interrupt handler? If it's none, are you sure you want
> > to disable interrupts?
> 
> I am not in an interrupt handler. It's not my fault that the scsi layer
> calls queuecommand with a spinlock held. But I need to sleep,
> I have to get rid of that spinlock's effects. If possible I even want
> interrupts to be enabled.

I don't know scsi, but if the coder decided that the lock
and irq were needed, I suspect that messing with them will
get you in big trouble.  I think you need to rethink this
thing at the scsi layer...

-g
> 
>         Regards
>                 Oliver
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSIFMAj>; Fri, 6 Sep 2002 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318519AbSIFMAj>; Fri, 6 Sep 2002 08:00:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318518AbSIFMAi>; Fri, 6 Sep 2002 08:00:38 -0400
Date: Fri, 6 Sep 2002 08:06:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Peter Surda <shurdeek@panorama.sth.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: Uptime timer-wrap
In-Reply-To: <20020905212516.GN7887@clusterfs.com>
Message-ID: <Pine.LNX.3.95.1020906075225.3143A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Andreas Dilger wrote:

> On Sep 05, 2002  16:16 -0400, Richard B. Johnson wrote:
> > I tried to simulate your observation by making a driver that
> > set the 'jiffies' count upon an 'open'. The idea was to get
> > the jiffies count to something close to wrap so I didn't have to
> > wait a long time.
> > 
> > Anyway, I found that setting the jiffies count to more than a
> > few hundred counts into the future, causes the machine to halt
> > with no interrupts (no Capslock, no NumLock, no network ping, etc).
> > 
> > The machine just stops and I don't understand why. 
> > 
> > 
> > 	spin_lock_irqsave(&xlock, flags);
> >         jiffies += 0x1000;
> > 	spin_lock_irqrestore(&xlock, flags);
> > 
> > 	... works just fine, but, changing 0x1000 to 0x7fffffff causes
> > the machine to stop as reported. 
> > 
> > Does anybody have a clue?
> 
> Yes, because now some kernel code is going to wait 147 days - 1s
> or something like that to finish.
> 

Yes. And isn't this a bug? I fear some code is waiting for some
hardware timer value with the interrupts disabled. Since the CPU(s)
are not the only user's of I/O (bus-masters), they may miss completely
whatever they are spinning for. This could be the reason many
machines simply "stop", could it not?

Do you have an idea where to look? I need to prevent the possibility
of waiting forever for an event that may never occur, with interrupts
disabled, on at least one embedded system. Any wait-forever possibility
must be interruptible because any watch-dog timer that re-boots will end
up destroying data that must never be lost.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318354AbSG3RK4>; Tue, 30 Jul 2002 13:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSG3RK4>; Tue, 30 Jul 2002 13:10:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31616 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318354AbSG3RKz>; Tue, 30 Jul 2002 13:10:55 -0400
Date: Tue, 30 Jul 2002 13:14:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
In-Reply-To: <3D46C6AB.1000103@deming-os.org>
Message-ID: <Pine.LNX.3.95.1020730131210.5530A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Russell Lewis wrote:

> Richard B. Johnson wrote:
> 
> >On Tue, 30 Jul 2002, Russell Lewis wrote:
> >
> >You need to gain a lock just to read the bias field. You can't read
> >something that somebody else will change while you are deciding
> >upon what you read. It just can't work.
> >
> I intentionally made bias a non-precise field.  It really doesn't matter 
> if it gets corrupted; it is just a rough idea of what's going on.  So 
> there's no problem reading it without a lock.  If the value you read is 
> wrong (or partial), then the worst that happends is bunch of NOPs before 
> you try for the lock (an undesirable, but not disastrous occurance).
> 
> >If we presume that it did work. What problem are you attempting
> >to fix?  FYI, there are no known 'lock-hogs'. Unlike a wait on
> >a semaphore, where a task waiting will sleep (give up the CPU), a
> >deadlock on a spin-lock isn't possible. A task will eventually
> >get the resource. Because of the well-known phenomena of "locality",
> >every possible 'attack' on the spin-lock variable will become
> >ordered and the code waiting on the locked resource will get
> >it in a first-come-first-served basis. This, of course, assumes
> >that the code isn't broken by attempts to change the natural
> >order.
> >
> Check out the title of the thread...  Somebody has a real, reproducible 
> deadlock on a rw_lock where many readers are starving out a writer, and 
> the system hangs.
> 

They have, as you say, "real reproducible" deadlocks because they are
not using straight spin-locks. Sombody tried to use cute queued locks.
This invention is the cause of the problem. The solution is to not
try to play tricks on "Mother Nature".


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbRBYXLQ>; Sun, 25 Feb 2001 18:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129918AbRBYXLG>; Sun, 25 Feb 2001 18:11:06 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:59839 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129915AbRBYXKt>; Sun, 25 Feb 2001 18:10:49 -0500
Message-ID: <3A9990EF.8D4ECF49@uow.edu.au>
Date: Sun, 25 Feb 2001 23:10:39 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: timing out on a semaphore
In-Reply-To: <20010225224039.W13721@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> I'm trying to chase down a semaphore time-out problem.  I want to
> sleep on a semaphore until either
> 
> (a) it's signalled, or
> (b) some amount of time has elapsed.
> 
> What I'm doing is calling add_timer, and then down_interruptible, and
> finally del_timer.  The timer's function ups the semaphore.
> 
> The code is in parport_wait_event, in drivers/parport/ieee1284.c.
> 
> Can anyone see anything obviously wrong with it?  It seems to
> sometimes get stuck.

I think there might be a bogon in __down_interruptible's
handling of the semaphore state in this case.  I remember
spotting something a few months back but I can't immediately
remember what it was :(

I'd suggest you slot a

	sema_init(&port->physport->ieee1284.irq, 1);

into parport_wait_event() prior to adding the timer.  If that
fixes it I'll go back through my patchpile, see if I can
resurrect that grey cell.

-

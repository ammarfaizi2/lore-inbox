Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131364AbRCKHqX>; Sun, 11 Mar 2001 02:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRCKHqN>; Sun, 11 Mar 2001 02:46:13 -0500
Received: from chiara.elte.hu ([157.181.150.200]:18701 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131364AbRCKHqC>;
	Sun, 11 Mar 2001 02:46:02 -0500
Date: Sun, 11 Mar 2001 08:44:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog
In-Reply-To: <3AA8E6E5.A4AD5035@uow.edu.au>
Message-ID: <Pine.LNX.4.30.0103110841110.987-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

your patch looks too complex, and doesnt cover the case of the serial
driver deadlocking. Why not add a "touch_nmi_watchdog_counter()" function
that just changes last_irq_sums instead of adding locking? This way
deadlocks will be caught in the serial code too. (because touch_nmi() will
only "postpone" the NMI watchdog lockup event, not disable it.) This
should be a matter of 5 lines ...

	Ingo



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbQLGXjF>; Thu, 7 Dec 2000 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbQLGXiz>; Thu, 7 Dec 2000 18:38:55 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:31748 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S130320AbQLGXij>; Thu, 7 Dec 2000 18:38:39 -0500
Message-ID: <3A301826.B483D19D@mvista.com>
Date: Thu, 07 Dec 2000 15:07:18 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Lock ordering, inquiring minds want to know.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In looking over sched.c I find:

	spin_lock_irq(&runqueue_lock);
	read_lock(&tasklist_lock);


This seems to me to be the wrong order of things.  The read lock
unavailable (some one holds a write lock) for relatively long periods of
time, for example, wait holds it in a while loop.  On the other hand the
runqueue_lock, being a "irq" lock will always be held for short periods
of time.  It would seem better to wait for the runqueue lock while
holding the read_lock with the interrupts on than to wait for the
read_lock with interrupts off.  As near as I can tell this is the only
place in the system that both of these locks are held (of course, all
cases of two locks being held at the same time, both locker must use the
same order).  So...


What am I missing here? 

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbTESRdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTESRdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:33:32 -0400
Received: from almesberger.net ([63.105.73.239]:38921 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262528AbTESRdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:33:31 -0400
Date: Mon, 19 May 2003 14:46:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-cleanup-2.5.69-A0
Message-ID: <20030519144605.B1432@almesberger.net>
References: <20030519135144.A1432@almesberger.net> <Pine.LNX.4.44.0305191900400.14615-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305191900400.14615-100000@localhost.localdomain>; from mingo@elte.hu on Mon, May 19, 2003 at 07:02:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> so you really want to run every time there's idle time, but you also want
> to sleep until the event that causes some other thread to run, right?

Basically yes. When my idle thread has decided that the system
is really idle (i.e. if there are pending softirqs, it generates
an interrupt and yields), it contacts the simulator process
(outside the UML system), and puts the entire UML system to
sleep.

The simulator can then mess with the UML system through ptrace.
When it's done, it may advance the time, and let the UML system
run again. If the time has changed, the UML system will
fast-forward jiffies, and possibly generate a timer interrupt.
Then it yields its timeslice, and the cycle begins anew.

There are no "outside" interrupts, so ultimately, the event
causing other threads to run also comes from my idle thread.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

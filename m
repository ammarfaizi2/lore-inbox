Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTC3XGb>; Sun, 30 Mar 2003 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbTC3XGb>; Sun, 30 Mar 2003 18:06:31 -0500
Received: from [12.47.58.85] ([12.47.58.85]:61781 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261312AbTC3XGb>;
	Sun, 30 Mar 2003 18:06:31 -0500
Date: Sun, 30 Mar 2003 15:17:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: roland@topspin.com, rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New
 OOPS w/ timer
Message-Id: <20030330151746.4394dd2e.akpm@digeo.com>
In-Reply-To: <000701c2f703$58f50390$030aa8c0@unknown>
References: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
	<52he9k4lgc.fsf@topspin.com>
	<000701c2f703$58f50390$030aa8c0@unknown>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2003 23:17:44.0709 (UTC) FILETIME=[91C84B50:01C2F712]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shawn Starr" <spstarr@sh0n.net> wrote:
>
> drivers/char/tty_io.c - Only
> 
> I bet it's this function, there's only a kfree, not destruction of any
> timers.
> 

This is fairly foul.

--- 25/drivers/char/tty_io.c~a	2003-03-30 15:12:37.000000000 -0800
+++ 25-akpm/drivers/char/tty_io.c	2003-03-30 15:16:59.000000000 -0800
@@ -1288,6 +1288,8 @@ static void release_dev(struct file * fi
 	/*
 	 * Make sure that the tty's task queue isn't activated. 
 	 */
+	clear_bit(TTY_DONT_FLIP, &tty->flags);
+	del_timer_sync(&tty->flip.work.timer);
 	flush_scheduled_work();
 
 	/* 

_


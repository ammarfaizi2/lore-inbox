Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTDFAXq (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 19:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTDFAXq (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 19:23:46 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:6148
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S262739AbTDFAXp (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 19:23:45 -0500
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Andrew Morton'" <akpm@digeo.com>
Cc: <roland@topspin.com>, <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [OOPS][2.5.66bk9+] run_timer_softirq - IRQ Mishandlings - New OOPS w/ timer
Date: Sat, 5 Apr 2003 19:35:24 -0500
Message-ID: <000001c2fbd4$6ae9f030$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <20030330151746.4394dd2e.akpm@digeo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, since the new timer changes made, Things are looking solid so far.
We might want to begin adding things into BK-current no?

Sshd hasn't hung, ttys haven't hung either.

Shawn.


-----Original Message-----
From: Andrew Morton [mailto:akpm@digeo.com] 
Sent: Sunday, March 30, 2003 6:18 PM
To: Shawn Starr
Cc: roland@topspin.com; rml@tech9.net; linux-kernel@vger.kernel.org
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New
OOPS w/ timer

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



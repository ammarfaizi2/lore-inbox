Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLODbh>; Thu, 14 Dec 2000 22:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLODb1>; Thu, 14 Dec 2000 22:31:27 -0500
Received: from www.wen-online.de ([212.223.88.39]:49682 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129257AbQLODbV>;
	Thu, 14 Dec 2000 22:31:21 -0500
Date: Fri, 15 Dec 2000 04:00:47 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Joseph Cheek <joseph@cheek.com>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: test12 + initrd = swapper at 99.8% CPU timer
In-Reply-To: <3A391E9F.CAF42006@cheek.com>
Message-ID: <Pine.Linu.4.10.10012150341210.1165-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Joseph Cheek wrote:

> hi,
> 
> ps axufw shows it as pid 1.

Interesting.. init running out of control.  I've seen that, and it
was init taking endless page faults.

I wager (one virtual brew) that you'll see an endless stream of output
if you apply this.

--- kernel/signal.c.org	Fri Dec 15 03:36:59 2000
+++ kernel/signal.c	Fri Dec 15 03:39:36 2000
@@ -564,6 +564,9 @@
 {
 	unsigned long int flags;
 
+	if (sig == SIGSEGV)
+		printk(KERN_ERR "SIGSEGV pid %d\n", t->pid);
+
 	spin_lock_irqsave(&t->sigmask_lock, flags);
 	if (t->sig == NULL) {
 		spin_unlock_irqrestore(&t->sigmask_lock, flags);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

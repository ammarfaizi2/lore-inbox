Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTFQTPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTFQTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:15:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1751 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264891AbTFQTPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:15:41 -0400
Date: Tue, 17 Jun 2003 21:29:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: [2.5 patch] 2.5.72: moxa.c doesn't compile
Message-ID: <20030617192929.GB26107@fs.tum.de>
References: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 02:17:32PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.70 to v2.5.71
> ============================================
>...
> Alexander Viro:
>...
>   o tty_driver refcounting
>...

This change caused the following compile error:


<--  snip  -->

...
  CC      drivers/char/moxa.o
drivers/char/moxa.c: In function `moxa_init':
drivers/char/moxa.c:342: warning: unused variable `ret1'
drivers/char/moxa.c:342: warning: unused variable `ret2'
drivers/char/moxa.c: In function `moxa_close':
drivers/char/moxa.c:618: error: invalid type argument of `unary *'
make[2]: *** [drivers/char/moxa.o] Error 1

<--  snip  -->


The following patch fixes it. Additionally, it kills two unused 
variables. I've tested the compilation with 2.5.72.


--- linux-2.5.72/drivers/char/moxa.c.old	2003-06-17 21:22:23.000000000 +0200
+++ linux-2.5.72/drivers/char/moxa.c	2003-06-17 21:26:56.000000000 +0200
@@ -339,7 +339,6 @@
 {
 	int i, n, numBoards;
 	struct moxa_str *ch;
-	int ret1, ret2;
 
 	printk(KERN_INFO "MOXA Intellio family driver version %s\n", MOXA_VERSION);
 	moxaDriver = alloc_tty_driver(MAX_PORTS + 1);
@@ -615,7 +614,7 @@
 	}
 	ch->asyncflags |= ASYNC_CLOSING;
 
-	ch->cflag = *tty->termios->c_cflag;
+	ch->cflag = tty->termios->c_cflag;
 	if (ch->asyncflags & ASYNC_INITIALIZED) {
 		setup_empty_event(tty);
 		tty_wait_until_sent(tty, 30 * HZ);	/* 30 seconds timeout */



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


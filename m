Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264027AbRFKUol>; Mon, 11 Jun 2001 16:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264035AbRFKUob>; Mon, 11 Jun 2001 16:44:31 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:39439 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S264027AbRFKUo0>;
	Mon, 11 Jun 2001 16:44:26 -0400
Date: Mon, 11 Jun 2001 22:42:42 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Debian's gcc-3.0-20010609 refuses to compile kernel :-(
Message-ID: <20010611224242.A21413@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
  latest gcc-3.0 snapshot in Debian just decided that:

extern struct timeval xtime;   /* linux/sched.h */
volatile struct timeval xtime; /* kernel/timer.c */

is incorrect - which is probably correct idea. So please apply
following patch. As 'jiffies' variable uses extern + volatile,
there is already precedent for doing this. Patch was generated
from 2.4.5-ac13.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/include/linux/sched.h linux/include/linux/sched.h
--- linux/include/linux/sched.h	Mon Jun 11 19:41:46 2001
+++ linux/include/linux/sched.h	Mon Jun 11 20:20:35 2001
@@ -539,7 +539,7 @@
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern struct timeval xtime;
+extern volatile struct timeval xtime;
 extern void do_timer(struct pt_regs *);
 
 extern unsigned int * prof_buffer;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263825AbRFLX20>; Tue, 12 Jun 2001 19:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbRFLX2R>; Tue, 12 Jun 2001 19:28:17 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:62099 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S263825AbRFLX2E>;
	Tue, 12 Jun 2001 19:28:04 -0400
Date: Tue, 12 Jun 2001 16:27:33 -0700
From: Richard Henderson <rth@redhat.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.5 gcc3 build patch
Message-ID: <20010612162733.D26637@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We fixed a bug in cv-qualification checking.

timer.c:35: conflicting types for `xtime'
include/linux/sched.h:540: previous declaration of `xtime'

There's no need for the volatile qualification here.  One, being a
struct it doesn't do any good, and two it's protected by xtime_lock.


r~


--- kernel/timer.c.orig	Tue Jun 12 16:22:27 2001
+++ kernel/timer.c	Tue Jun 12 16:24:06 2001
@@ -32,7 +32,7 @@
 long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
 
 /* The current time */
-volatile struct timeval xtime __attribute__ ((aligned (16)));
+struct timeval xtime __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */

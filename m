Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280289AbRLDDCE>; Mon, 3 Dec 2001 22:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284610AbRLCXrG>; Mon, 3 Dec 2001 18:47:06 -0500
Received: from zodiac.mimuw.edu.pl ([193.0.99.1]:42927 "EHLO
	students.mimuw.edu.pl") by vger.kernel.org with ESMTP
	id <S285299AbRLCWlV>; Mon, 3 Dec 2001 17:41:21 -0500
From: Filip Kalinski <fk181140@zodiac.mimuw.edu.pl>
Message-Id: <200112032246.fB3MkZVf022727@fk.filipnet>
Date: Mon, 03 Dec 2001 23:46:35 +0100
To: linux-kernel@vger.kernel.org
Subject: (PATCH) small fix for building with new gcc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes problem with compiling the kernel with gcc 3.x.
It does not like that xtime is defined differently in linux/sched.h
(as "volatile"), and doesn't want to proceed.

Filip Kaliñski <filon@pld.org.pl>

--- linux-vanilla/kernel/timer.c	Sun Nov  4 16:27:47 2001
+++ linux-modfied/kernel/timer.c	Fri Nov 23 23:58:34 2001
@@ -32,7 +32,7 @@
 long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
 
 /* The current time */
-struct timeval xtime __attribute__ ((aligned (16)));
+volatile struct timeval xtime __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274492AbRJACS6>; Sun, 30 Sep 2001 22:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274495AbRJACSi>; Sun, 30 Sep 2001 22:18:38 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:25216
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S274492AbRJACSd>; Sun, 30 Sep 2001 22:18:33 -0400
Date: Sun, 30 Sep 2001 19:18:54 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200110010218.f912Isc10156@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Alan Cox <laughing@shared-source.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-ac1
In-Reply-To: <20011001001519.A30470@lightning.swansea.linux.org.uk>
In-Reply-To: <20011001001519.A30470@lightning.swansea.linux.org.uk>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

gcc 3.0.2 20010905 (Red Hat Linux 7.1 3.0.1-3) complains about
conflicting definitions of xtime in 2.4.10-ac1:

kernel/timer.c:		struct timeval xtime __attribute__ ((aligned (16)));
include/linux/sched.h:	extern volatile struct timeval xtime;

So I used the trivial patch below to get it to compile, I'm no C
expert so I don't know if I chose the correct definition.  Hopefully
my mailer won't screw up the whitespace.

Cheers, Wayne


--- linux-2.4.10-ac1/kernel/timer.c.orig	Sun Sep 30 19:01:12 2001
+++ linux-2.4.10-ac1/kernel/timer.c	Sun Sep 30 19:06:29 2001
@@ -32,7 +32,7 @@
 long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
 
 /* The current time */
-struct timeval xtime __attribute__ ((aligned (16)));
+volatile struct timeval xtime __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */

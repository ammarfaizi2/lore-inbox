Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282402AbRK2G4m>; Thu, 29 Nov 2001 01:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282377AbRK2G4c>; Thu, 29 Nov 2001 01:56:32 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:47372 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP
	id <S282349AbRK2G43>; Thu, 29 Nov 2001 01:56:29 -0500
Message-ID: <3C05DC1D.7071FC6B@yahoo.com>
Date: Thu, 29 Nov 2001 01:56:29 -0500
From: Michael Arras <mkarras110@yahoo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for sys_nanosleep() in 2.4.16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

For many of us, the kernel thread scheduling resolution is
10ms (see getitimer(2)).  By adding 1 jiffy to the time to
sleep in sys_nanosleep(), threads are sleeping 10ms too long.
timespec_to_jiffies() does a good job at returning the
appropriate number of jiffies to sleep.  There is no need to
add one for good measure.

Mike Arras
mkarras110@yahoo.com

diff -urN linux-2.4.16/kernel/timer.c linux/kernel/timer.c
--- linux-2.4.16/kernel/timer.c Mon Oct  8 13:41:41 2001
+++ linux/kernel/timer.c        Wed Nov 28 00:23:15 2001
@@ -825,7 +825,7 @@
                return 0;
        }
 
-       expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
+       expire = timespec_to_jiffies(&t);
 
        current->state = TASK_INTERRUPTIBLE;
        expire = schedule_timeout(expire);

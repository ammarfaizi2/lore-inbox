Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTIJCwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTIJCwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:52:35 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:42667
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264450AbTIJCwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:52:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O20.1int
Date: Wed, 10 Sep 2003 13:00:20 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EPpX/xg8EOXez9x"
Message-Id: <200309101300.20634.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_EPpX/xg8EOXez9x
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Should be the last of the O1int patches.

Tiny tweak to keep top two interactive levels round robin at the fastest 
(10ms) which keeps X smooth when another interactive task is also using 
bursts of cpu (eg web browser).

Credit. Is this too bold?

Con

--Boundary-00=_EPpX/xg8EOXez9x
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O20-O20.1int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O20-O20.1int"

--- linux-2.6.0-test5-mm1-O20/kernel/sched.c	2003-09-10 11:15:45.000000000 +1000
+++ linux-2.6.0-test5-mm1/kernel/sched.c	2003-09-10 11:51:38.000000000 +1000
@@ -14,6 +14,7 @@
  *		an array-switch method of distributing timeslices
  *		and per-CPU runqueues.  Cleanups and useful suggestions
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
+ *  2003-09-03	Interactivity tuning by Con Kolivas.
  */
 
 #include <linux/mm.h>
@@ -122,12 +123,12 @@
 		MAX_SLEEP_AVG)
 
 #ifdef CONFIG_SMP
-#define TIMESLICE_GRANULARITY(p) \
-	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * \
-		num_online_cpus())
+#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
+		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)) * \
+			num_online_cpus())
 #else
-#define TIMESLICE_GRANULARITY(p) \
-	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))))
+#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
+		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)))
 #endif
 
 #define SCALE(v1,v1_max,v2_max) \

--Boundary-00=_EPpX/xg8EOXez9x--


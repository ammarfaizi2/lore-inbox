Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTHWFtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 01:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTHWFtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 01:49:03 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:37795
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263358AbTHWFs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 01:48:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O18.1int
Date: Sat, 23 Aug 2003 15:55:14 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CHwR/7W16E8wd3A"
Message-Id: <200308231555.24530.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_CHwR/7W16E8wd3A
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Some high credit tasks were being missed due to their prolonged cpu burn at=
=20
startup flagging them as low credit tasks.

Low credit tasks can now recover to become high credit.

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/RwHDZUg7+tp6mRURAie7AJ43egdTeSapoX1D0aJQcEksBTkKdwCfcyHZ
cD1TMt7oFNXvmSrqnJe7Z+E=3D
=3D41zp
=2D----END PGP SIGNATURE-----

--Boundary-00=_CHwR/7W16E8wd3A
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O18-O18.1int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O18-O18.1int"

--- linux-2.6.0-test3-mm3-O18/kernel/sched.c	2003-08-23 15:28:47.000000000 +1000
+++ linux-2.6.0-test3-mm3/kernel/sched.c	2003-08-23 15:30:16.000000000 +1000
@@ -140,9 +140,6 @@
 #define LOW_CREDIT(p) \
 	((p)->interactive_credit < -MAX_SLEEP_AVG)
 
-#define VARYING_CREDIT(p) \
-	(!(HIGH_CREDIT(p) || LOW_CREDIT(p)))
-
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
@@ -434,7 +431,7 @@ static void recalc_task_prio(task_t *p, 
 
 			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				p->interactive_credit += VARYING_CREDIT(p);
+				p->interactive_credit += !(HIGH_CREDIT(p));
 			}
 		}
 	}
@@ -1548,7 +1545,8 @@ switch_tasks:
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0){
 		prev->sleep_avg = 0;
-		prev->interactive_credit -= VARYING_CREDIT(prev);
+		prev->interactive_credit -=
+			!(HIGH_CREDIT(prev) || LOW_CREDIT(prev));
 	}
 	prev->timestamp = now;
 

--Boundary-00=_CHwR/7W16E8wd3A--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbTHVMux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTHVMuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:50:24 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:65231
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263194AbTHVMYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:24:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O18int
Date: Fri, 22 Aug 2003 22:31:20 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y0gR/6qCS75acy8"
Message-Id: <200308222231.25059.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Y0gR/6qCS75acy8
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a small patchlet.

It is possible tasks were getting more sleep_avg credit on requeuing than t=
hey=20
could burn off while running so I've removed the on runqueue bonus to=20
requeuing task.=20

Note this applies onto O16.3 or 2.6.0-test3-mm3 as O17 was dropped.

This patch is also available here along with a patch against 2.6.0-test3:
http://kernel.kolivas.org/2.5

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Rg0aZUg7+tp6mRURAhw+AJ9s3xwkNodB280E81VZnizvSRU0RQCghKT/
IN6uMO2E4heihDxjBE/JG7c=3D
=3D5G4+
=2D----END PGP SIGNATURE-----

--Boundary-00=_Y0gR/6qCS75acy8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O16.3-O18int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O16.3-O18int"

--- linux-2.6.0-test3-mm2-O16.3/kernel/sched.c	2003-08-18 21:02:15.000000000 +1000
+++ linux-2.6.0-test3-mm3/kernel/sched.c	2003-08-22 22:06:46.000000000 +1000
@@ -1418,12 +1418,6 @@ void scheduler_tick(int user_ticks, int 
 
 			dequeue_task(p, rq->active);
 			set_tsk_need_resched(p);
-			/*
-			 * Tasks with interactive credit get all their
-			 * time waiting on the run queue credited as sleep
-			 */
-			if (HIGH_CREDIT(p))
-				p->activated = 2;
 			p->prio = effective_prio(p);
 			enqueue_task(p, rq->active);
 		}

--Boundary-00=_Y0gR/6qCS75acy8--


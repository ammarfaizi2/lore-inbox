Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbTAJMgw>; Fri, 10 Jan 2003 07:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAJMgv>; Fri, 10 Jan 2003 07:36:51 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:33938 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265002AbTAJMgu>; Fri, 10 Jan 2003 07:36:50 -0500
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: small migration thread fix
Date: Fri, 10 Jan 2003 13:46:03 +0100
User-Agent: KMail/1.4.3
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RS0INCOSRJY45JH5GL4F"
Message-Id: <200301101346.03653.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RS0INCOSRJY45JH5GL4F
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

the small patch fixes a potential problem in the migration thread for
the case that the first CPU in the cpus_allowed mask of a process is
offline. Please consider applying it to your trees.

Thanks!
Regards,
Erich


--------------Boundary-00=_RS0INCOSRJY45JH5GL4F
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="migration-fix-2.5.55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="migration-fix-2.5.55.patch"

diff -urNp linux-2.5.55/kernel/sched.c linux-2.5.55-fix/kernel/sched.c
--- linux-2.5.55/kernel/sched.c	2003-01-09 05:04:22.000000000 +0100
+++ linux-2.5.55-fix/kernel/sched.c	2003-01-10 13:37:40.000000000 +0100
@@ -2108,7 +2108,7 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);

--------------Boundary-00=_RS0INCOSRJY45JH5GL4F--


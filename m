Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314232AbSEMQbO>; Mon, 13 May 2002 12:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314228AbSEMQbO>; Mon, 13 May 2002 12:31:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28912 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314232AbSEMQam>; Mon, 13 May 2002 12:30:42 -0400
Subject: [PATCH] 2.4-ac: sched.c compile fix
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-GeUrR7cLEx1WvnRhy5xy"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 May 2002 09:30:33 -0700
Message-Id: <1021307433.30314.2590.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GeUrR7cLEx1WvnRhy5xy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

This fixes the compile error under SMP for 2.4.19-pre8-ac2 in sched.c
due to the latest scheduling changes.

I do not know how I missed this - much apologies.  Please apply.

	Robert Love




--=-GeUrR7cLEx1WvnRhy5xy
Content-Disposition: attachment; filename=sched-compile-fix-rml-2.4.19-pre8-ac2-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-compile-fix-rml-2.4.19-pre8-ac2-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac2/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac2/kernel/sched.c	Mon May 13 09:15:12 2002
+++ linux/kernel/sched.c	Mon May 13 09:19:32 2002
@@ -1592,18 +1592,18 @@
 		cpu_dest =3D __ffs(p->cpus_allowed);
 		rq_dest =3D cpu_rq(cpu_dest);
 repeat:
-		cpu_src =3D p->thread_info->cpu;
+		cpu_src =3D p->cpu;
 		rq_src =3D cpu_rq(cpu_src);
=20
 		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
-		if (p->thread_info->cpu !=3D cpu_src) {
+		if (p->cpu !=3D cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
 			local_irq_restore(flags);
 			goto repeat;
 		}
 		if (rq_src =3D=3D rq) {
-			p->thread_info->cpu =3D cpu_dest;
+			p->cpu =3D cpu_dest;
 			if (p->array) {
 				deactivate_task(p, rq_src);
 				activate_task(p, rq_dest);

--=-GeUrR7cLEx1WvnRhy5xy--


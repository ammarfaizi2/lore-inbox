Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315832AbSENQtd>; Tue, 14 May 2002 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315839AbSENQtb>; Tue, 14 May 2002 12:49:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39412 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315832AbSENQtZ>; Tue, 14 May 2002 12:49:25 -0400
Subject: [PATCH] 2.4-ac resend: SMP compile fix for sched.c
From: Robert Love <rml@tech9.net>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-aMXaJT07RqPEUQwnEPXR"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 May 2002 09:49:17 -0700
Message-Id: <1021394957.823.42.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aMXaJT07RqPEUQwnEPXR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Attached patch fixes the CONFIG_SMP compile error in kernel/sched.c due
to my latest O(1) scheduler patches that went into -ac2.  I apologize
for the slip - not sure how I missed the error.

Patch is against 2.4.19-pre8-ac3 - please apply.  Thanks,

	Robert Love



--=-aMXaJT07RqPEUQwnEPXR
Content-Disposition: attachment; filename=sched-compile-fix-rml-2.4.19-pre8-ac3-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-compile-fix-rml-2.4.19-pre8-ac3-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac3/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac3/kernel/sched.c	Tue May 14 09:40:05 2002
+++ linux/kernel/sched.c	Tue May 14 09:46:56 2002
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

--=-aMXaJT07RqPEUQwnEPXR--


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314063AbSDVGbI>; Mon, 22 Apr 2002 02:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSDVGbH>; Mon, 22 Apr 2002 02:31:07 -0400
Received: from support.kovair.com ([209.66.77.36]:20375 "EHLO tbdnetworks.com.")
	by vger.kernel.org with ESMTP id <S314063AbSDVGbG>;
	Mon, 22 Apr 2002 02:31:06 -0400
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam4
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: jamagallon@able.es
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-AIJmneUJg50kXqyfWGI6"
X-Mailer: Ximian Evolution 1.0.3 
Date: 21 Apr 2002 23:30:44 -0700
Message-Id: <1019457056.591.18.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AIJmneUJg50kXqyfWGI6
Content-Type: multipart/mixed; boundary="=-Ei6U7wx+8H0TMYoUb2zM"


--=-Ei6U7wx+8H0TMYoUb2zM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I had two compile problems:
1) sched.c complains about missing local_bh_count, TQUEUE_BH, ...
2) init/do_mounts.c complains about SCHED_YIELD (if initrd is enabled)

The following patch fixes both problems for me.

--nk

diff -ur linux/init/do_mounts.c linux-nk/init/do_mounts.c
--- linux/init/do_mounts.c	Sun Apr 21 23:04:20 2002
+++ linux-nk/init/do_mounts.c	Sun Apr 21 21:01:41 2002
@@ -775,8 +775,7 @@
 	pid =3D kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid !=3D wait(&i)) {
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		}
 	}
=20
diff -ur linux/kernel/sched.c linux-nk/kernel/sched.c
--- linux/kernel/sched.c	Sun Apr 21 23:16:06 2002
+++ linux-nk/kernel/sched.c	Sun Apr 21 21:24:59 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
 #include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
=20
 /*
  * Priority of a process goes from 0 to MAX_PRIO-1.  The

--=20
Key fingerprint =3D 6C58 F18D 4747 3295 F2DB  15C1 3882 4302 F8B4 C11C

--=-Ei6U7wx+8H0TMYoUb2zM
Content-Disposition: attachment; filename=diff.nk
Content-Type: text/x-patch; name=diff.nk; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -ur linux/init/do_mounts.c linux-nk/init/do_mounts.c
--- linux/init/do_mounts.c	Sun Apr 21 23:04:20 2002
+++ linux-nk/init/do_mounts.c	Sun Apr 21 21:01:41 2002
@@ -775,8 +775,7 @@
 	pid =3D kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid !=3D wait(&i)) {
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		}
 	}
=20
diff -ur linux/kernel/sched.c linux-nk/kernel/sched.c
--- linux/kernel/sched.c	Sun Apr 21 23:16:06 2002
+++ linux-nk/kernel/sched.c	Sun Apr 21 21:24:59 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
 #include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
=20
 /*
  * Priority of a process goes from 0 to MAX_PRIO-1.  The

--=-Ei6U7wx+8H0TMYoUb2zM--

--=-AIJmneUJg50kXqyfWGI6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8w64TOIJDAvi0wRwRAqktAJ9aJHjyCgClErbMVdZpc4UgPb3svwCdElnK
yIU2MsaAtd4sQDDZgM9YY0Q=
=8IqZ
-----END PGP SIGNATURE-----

--=-AIJmneUJg50kXqyfWGI6--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTEFIXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTEFIXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:23:52 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:11401 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262445AbTEFIXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:23:49 -0400
Date: Tue, 6 May 2003 11:36:17 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Rusty Russell - trivial patches <trivial@rustcorp.com.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove #ifdef CONFIG_PROC_FS from ipc/sem.c
Message-ID: <20030506083617.GE31585@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove #ifdef CONFIG_PROC_FS from a couple of place in ipc/sem.c, as
they aren't needed and #ifdefs are ugly.=20

[also make a couple of lines fit in 80 chars]=20

diff -Naur --exclude-from /home/mulix/dontdiff vanilla/ipc/sem.c 2.5.69-ipc=
/ipc/sem.c
--- vanilla/ipc/sem.c	2003-05-05 02:53:12.000000000 +0300
+++ 2.5.69-ipc/ipc/sem.c	2003-05-06 11:34:41.000000000 +0300
@@ -80,9 +80,8 @@
=20
 static int newary (key_t, int, int);
 static void freeary (int id);
-#ifdef CONFIG_PROC_FS
-static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset,=
 int length, int *eof, void *data);
-#endif
+static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset,=
=20
+				 int length, int *eof, void *data);
=20
 #define SEMMSL_FAST	256 /* 512 bytes on stack */
 #define SEMOPM_FAST	64  /* ~ 372 bytes on stack */
@@ -109,9 +108,7 @@
 	used_sems =3D 0;
 	ipc_init_ids(&sem_ids,sc_semmni);
=20
-#ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/sem", 0, 0, sysvipc_sem_read_proc, NULL);
-#endif
 }
=20
 static int newary (key_t key, int nsems, int semflg)
@@ -1292,21 +1289,23 @@
 	unlock_kernel();
 }
=20
-#ifdef CONFIG_PROC_FS
-static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset,=
 int length, int *eof, void *data)
+static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset,=
=20
+				 int length, int *eof, void *data)
 {
 	off_t pos =3D 0;
 	off_t begin =3D 0;
 	int i, len =3D 0;
=20
-	len +=3D sprintf(buffer, "       key      semid perms      nsems   uid   =
gid  cuid  cgid      otime      ctime\n");
+	len +=3D sprintf(buffer, "       key      semid perms      nsems   "
+		       "uid   gid  cuid  cgid      otime      ctime\n");
 	down(&sem_ids.sem);
=20
 	for(i =3D 0; i <=3D sem_ids.max_id; i++) {
 		struct sem_array *sma;
 		sma =3D sem_lock(i);
 		if(sma) {
-			len +=3D sprintf(buffer + len, "%10d %10d  %4o %10lu %5u %5u %5u %5u %1=
0lu %10lu\n",
+			len +=3D sprintf(buffer + len, "%10d %10d  %4o %10lu "
+				       "%5u %5u %5u %5u %10lu %10lu\n",
 				sma->sem_perm.key,
 				sem_buildid(i,sma->sem_perm.seq),
 				sma->sem_perm.mode,
@@ -1339,4 +1338,3 @@
 		len =3D 0;
 	return len;
 }
-#endif

--=20
Muli Ben-Yehuda
http://www.mulix.org


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t3QAKRs727/VN8sRAiiZAJ4+fRNy1HagEAKHjKrbtYyS2vM25gCfTiXv
YAJl7dSsF7400woDnPCGZq0=
=O8Yg
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--

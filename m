Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUBXCQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUBXCQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:16:56 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:36546 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262042AbUBXCQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:16:53 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Feb 2004 13:16:51 +1100
Subject: [PATCH] devpts_fs.h fails with "error: parameter name omitted"
Message-ID: <20040224021651.GF1200@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: multipart/mixed; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The change

http://linux.bkbits.net:8080/linux-2.5/cset@1.1595.1.6

caused my test build [1] to die with=20

In file included from drivers/char/tty_io.c:79:
include/linux/devpts_fs.h: In function `devpts_pty_new':
include/linux/devpts_fs.h:27: error: parameter name omitted
include/linux/devpts_fs.h: In function `devpts_get_tty':
include/linux/devpts_fs.h:28: error: parameter name omitted
include/linux/devpts_fs.h: In function `devpts_pty_kill':
include/linux/devpts_fs.h:29: error: parameter name omitted
make[2]: *** [drivers/char/tty_io.o] Error 1

suggested patch attached.

Thanks,

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au

[1] http://www.gelato.unsw.edu.au/kerncomp/results//2004-02-23-16-00/config=
-2.6.1-simulator-log.html#build
--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devpts_fs.h.patch"
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D include/linux/devpts_fs.h 1.3 vs edited =3D=3D=3D=3D=3D
--- 1.3/include/linux/devpts_fs.h	Mon Feb 23 16:24:03 2004
+++ edited/include/linux/devpts_fs.h	Tue Feb 24 13:04:26 2004
@@ -17,16 +17,16 @@
=20
 #if CONFIG_UNIX98_PTYS
=20
-int devpts_pty_new(struct tty_struct *); /* mknod in devpts */
-struct tty_struct *devpts_get_tty(int);	 /* get tty structure */
-void devpts_pty_kill(int);		 /* unlink */
+int devpts_pty_new(struct tty_struct *tty);      /* mknod in devpts */
+struct tty_struct *devpts_get_tty(int number);	 /* get tty structure */
+void devpts_pty_kill(int number);		 /* unlink */
=20
 #else
=20
 /* Dummy stubs in the no-pty case */
-static inline int devpts_pty_new(struct tty_struct *) { return -EINVAL; }
-static inline struct tty_struct *devpts_get_tty(int)  { return NULL; }
-static inline void devpts_pty_kill(int) { }
+static inline int devpts_pty_new(struct tty_struct *tty) { return -EINVAL;=
 }
+static inline struct tty_struct *devpts_get_tty(int number) { return NULL;=
 }
+static inline void devpts_pty_kill(int number) { }
=20
 #endif
=20

--XStn23h1fwudRqtG--

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAOrQTWDlSU/gp6ecRAvTxAKDppro8QiqaunPeAh3/C8JuZLyeowCePJ/z
6D9memUtgpdiVM39MKLyMHo=
=8b80
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--

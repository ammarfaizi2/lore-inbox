Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbRENMXO>; Mon, 14 May 2001 08:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbRENMXE>; Mon, 14 May 2001 08:23:04 -0400
Received: from orbita.don.sitek.net ([213.24.25.98]:40710 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261908AbRENMWt>;
	Mon, 14 May 2001 08:22:49 -0400
Date: Mon, 14 May 2001 16:21:18 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] small addition to <linux/init.h>
Message-ID: <20010514162118.C2912@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
User-Agent: Mutt/1.0.1i
X-Uptime: 1:51pm  up 16 days, 23:32,  3 users,  load average: 0.17, 0.20, 0.16
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: multipart/mixed; boundary="bajzpZikUji1w+G9"


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

please take a quick look at attached patch (IMHO it can be usefull :)

The code below is a common code pattern in Linux kernel:=20

static int __init foo(void)
{
	. . .
	printk("%s: blah blah blah\n", bar);
	. . .
}

this is bad because "blah blah blah\n" goes to .rodata section and plagues=
=20
the memory. With this small patch it's possibe to rewrite this fragment as:

static int __init foo(void)
{
	. . .
	printk(__init_msg("%s: blah blah blah\n"), bar);
	. . .
}

and thus "blah blah blah\n" goes to .data.init and then to bitbucket.
IMHO it can save some extra memory for us.

Best regadrs.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-__init_msg
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/include/linux/init.h linux/include/linux/init.h
--- linux.vanilla/include/linux/init.h	Mon May 14 15:51:20 2001
+++ linux/include/linux/init.h	Mon May 14 15:54:05 2001
@@ -155,4 +155,9 @@
 #define __devexitdata __exitdata
 #endif
=20
+#define __init_msg(x) ({ static char msg[] __initdata =3D (x); msg; })
+#define __exit_msg(x) ({ static char msg[] __exitdata =3D (x); msg; })
+#define __devinit_msg(x) ({ static char msg[] __devinitdata =3D (x); msg; =
})
+#define __devexit_msg(x) ({ static char msg[] __devexitdata =3D (x); msg; =
})
+
 #endif /* _LINUX_INIT_H */

--bajzpZikUji1w+G9--

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6/82+Bm4rlNOo3YgRAoFQAJ9eAqXlvGBXL2OVSJRwK9WMIdoZPQCggYXP
cCJQIPnAGbcTlsW+MSfx5rU=
=Lwxy
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129514AbQJZWp4>; Thu, 26 Oct 2000 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129959AbQJZWpq>; Thu, 26 Oct 2000 18:45:46 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:46607
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S129514AbQJZWpa>;
	Thu, 26 Oct 2000 18:45:30 -0400
Date: Thu, 26 Oct 2000 15:45:27 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
Subject: [PATCH] address-space identification for /proc
Message-ID: <20001026154527.A30463@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

/proc has no way to indicate whether tasks share an address space.
This one-liner patch adds a new ASID: field to /proc/<pid>/status so
there's some way to see address-space sharing between tasks.

While this is hardly a bug-fix, it is a pretty useful thing to know
which is otherwise completely absent.

	J

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asid.diff"
Content-Transfer-Encoding: quoted-printable

--- ../2.3/fs/proc/array.c	Mon Oct  9 17:03:53 2000
+++ linux/fs/proc/array.c	Thu Oct 26 15:20:52 2000
@@ -294,6 +294,7 @@
 	for(line=3D0;(len=3Dsprintf_regs(line,buffer,task,NULL,NULL))!=3D0;line++)
 		buffer+=3Dlen;
 #endif
+	buffer +=3D sprintf("ASID: %p\n", mm);
 	return buffer - orig;
 }
=20

--xHFwDpU9dbj6ez1V--

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjn4tAcACgkQf6p1nWJ6IgLJzgCffooO+7FQL1HAmF44JLKcmnkC
2lgAoJ4iYj+UN8RPKVesE/DhICJLz+f1
=jUhk
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

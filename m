Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319067AbSHFLQD>; Tue, 6 Aug 2002 07:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSHFLQD>; Tue, 6 Aug 2002 07:16:03 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:32746 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S319067AbSHFLQB>; Tue, 6 Aug 2002 07:16:01 -0400
Date: Tue, 6 Aug 2002 14:15:49 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: weird padding in linux/timex.h, struct timex
Message-ID: <20020806111549.GL29139@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dfmC41YZQlborXoK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dfmC41YZQlborXoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

struct timex in include/linux/timex.h is defined as=20

struct timex=20
{
	...
	int  :32; int  :32; int  :32; int  :32;
	int  :32; int  :32; int  :32; int  :32;
	int  :32; int  :32; int  :32; int  :32;
};=20

I assume that this is used as padding. Is there any reason for using
bitfields as padding? If there is, a comment to that effect would be
nice. If there isn't, the following patch makes the padding explicit.=20

--- 2.4.19-vanilla/include/linux/timex.h	Sun Aug  4 19:16:59 2002
+++ 2.4.19-mx/include/linux/timex.h	Tue Aug  6 13:49:32 2002
@@ -182,9 +182,7 @@
 	long errcnt;            /* calibration errors (ro) */
 	long stbcnt;            /* stability limit exceeded (ro) */
=20
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
+	char __pad[12 * 4];     /* padding */=20
 };
=20
 /*


--=20
I am PINK, hear me ROAR

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--dfmC41YZQlborXoK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9T6/lKRs727/VN8sRAsU0AJ4sn6YEcEhMk37bhlc75uHyKHwweQCfWXXI
rGHPI3UA565u3xFVvQ9u5Rk=
=u0Ui
-----END PGP SIGNATURE-----

--dfmC41YZQlborXoK--

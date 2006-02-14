Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWBNBhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWBNBhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 20:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWBNBhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 20:37:52 -0500
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:24073 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750890AbWBNBhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 20:37:51 -0500
Message-ID: <43F1345A.1090907@poczta.fm>
Date: Tue, 14 Feb 2006 02:37:30 +0100
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] RTC_ALM_SET ioctl secured
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig11477DD2C548737520DF2B25"
X-EMID: a671138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig11477DD2C548737520DF2B25
Content-Type: multipart/mixed;
 boundary="------------010106000008050707000800"

This is a multi-part message in MIME format.
--------------010106000008050707000800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings.

In 2.6.15 every Joe User can set up alarm on RTC chip with RTC_ALM_SET. I=
MHO
there should be a check agains CAP_SYS_TIME before it is done.

PS, please CC, I'm not a subscriber.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP



-------------------------------------------------------------------
Fotoerotica! >>> http://link.interia.pl/f1904

--------------010106000008050707000800
Content-Type: text/x-patch;
 name="rtc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc.diff"

--- rtc.c~	2006-02-14 02:31:51.000000000 +0100
+++ rtc.c	2006-02-14 02:32:48.000000000 +0100
@@ -478,6 +478,9 @@
 		unsigned char hrs, min, sec;
 		struct rtc_time alm_tm;

+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
 		if (copy_from_user(&alm_tm, (struct rtc_time __user *)arg,
 				   sizeof(struct rtc_time)))
 			return -EFAULT;

--------------010106000008050707000800--
--------------enig11477DD2C548737520DF2B25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD8TRkNdzY8sm9K9wRAp73AJ9xVLQMUwu3SgAP9iM0GICnBL2/PgCePYmR
PZt8JWk6WpuD5Og6+4WDpvw=
=ATgn
-----END PGP SIGNATURE-----

--------------enig11477DD2C548737520DF2B25--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUANXsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266455AbUANXsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:48:14 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:25485 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266448AbUANXrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:47:45 -0500
Subject: [PATCH] Same keyboard.c as in 2.6.0
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kQObtfPoVxe/ZDFKOG0G"
Message-Id: <1074124061.1278.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 01:47:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kQObtfPoVxe/ZDFKOG0G
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi list,
I think many of you have run into this problem:
Some of your keys doesn't work in 2.6.1.=20

If you linux gurus know a better way to do this - please tell.

Compiled and tested against 2.6.1-bk2

I made a small patch that makes them work as in 2.6.0:
--- CUT HERE ---
--- linux-2.6.1/drivers/char/keyboard.c 2004-01-09 08:59:26.000000000
+0200
+++ linux-2.6.0/drivers/char/keyboard.c 2003-12-18 04:58:46.000000000
+0200
@@ -941,16 +941,16 @@ static unsigned short x86_keycodes[256]=20
         32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
         48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
         64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-        80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
-       284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
-       367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
-       360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
+        80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
+       284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
+       367,288,302,304,350, 92,334,512,116,377,109,111,373,347,348,349,
+       360, 93, 94, 95, 98,376,100,101,321,316,354,286,289,102,351,355,
        103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
-       291,108,381,281,290,272,292,305,280, 99,112,257,258,359,113,114,
-       264,117,271,374,379,115,125,273,121,123, 92,265,266,267,268,269,
-       120,119,118,277,278,282,283,295,296,297,299,300,301,293,303,307,
-       308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
-       332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372
};
+       291,108,381,281,290,272,292,305,280, 99,112,257,258,359,270,114,
+       118,117,125,374,379,115,112,125,121,123,264,265,266,267,268,269,
+       271,273,276,277,278,282,283,295,296,297,299,300,301,293,303,307,
+       308,310,313,314,315,317,318,319,320,357,322,323,324,325,326,330,
+       332,340,365,342,343,344,345,346,356,113,341,368,369,370,371,372
};
=20
 #ifdef CONFIG_MAC_EMUMOUSEBTN
 extern int mac_hid_mouse_emulate_buttons(int, int, int);
@@ -972,18 +972,11 @@ static int emulate_raw(struct vc_data *v
        if (keycode > 255 || !x86_keycodes[keycode])
                return -1;=20
=20
-       switch (keycode) {
-               case KEY_PAUSE:
-                       put_queue(vc, 0xe1);
-                       put_queue(vc, 0x1d | up_flag);
-                       put_queue(vc, 0x45 | up_flag);
-                       return 0;
-               case KEY_LANG1:
-                       if (!up_flag) put_queue(vc, 0xf1);
-                       return 0;
-               case KEY_LANG2:
-                       if (!up_flag) put_queue(vc, 0xf2);
-                       return 0;
+       if (keycode =3D=3D KEY_PAUSE) {
+               put_queue(vc, 0xe1);
+               put_queue(vc, 0x1d | up_flag);
+               put_queue(vc, 0x45 | up_flag);
+               return 0;
        }=20
=20
        if (keycode =3D=3D KEY_SYSRQ && sysrq_alt) {
--- CUT HERE ---
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-kQObtfPoVxe/ZDFKOG0G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBABdUc3+NhIWS1JHARAuiSAJ99zA+MmsHZqVaAJszyntC1N8XYVQCgko2d
fpdOPLD+UjKwLRSLPFWwGQI=
=nwY/
-----END PGP SIGNATURE-----

--=-kQObtfPoVxe/ZDFKOG0G--


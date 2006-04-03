Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWDCLVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWDCLVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 07:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWDCLVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 07:21:12 -0400
Received: from lug-owl.de ([195.71.106.12]:65187 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751266AbWDCLVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 07:21:11 -0400
Date: Mon, 3 Apr 2006 13:21:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Silence a const vs non-const warning
Message-ID: <20060403112107.GQ1259@lug-owl.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MM5RgFPKyuP3gDcV"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MM5RgFPKyuP3gDcV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This patch silences a const vs. non-const warning issued by very
recent GCC versions:

$ vax-linux-uclibc-gcc -v 2>&1 | grep version
gcc version 4.2.0 20060331 (experimental)

$ make CROSS_COMPILE=3Dvax-linux-uclibc- ARCH=3Dvax mopboot
[...]
  CC      lib/string.o
lib/string.c: In function 'memcpy':
lib/string.c:470: warning: initialization discards qualifiers from pointer =
target type
[...]

Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>

----

 string.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index b3c28a3..dd2bfdd 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -467,7 +467,7 @@ EXPORT_SYMBOL(memset);
 void *memcpy(void *dest, const void *src, size_t count)
 {
 	char *tmp =3D dest;
-	char *s =3D src;
+	const char *s =3D src;
=20
 	while (count--)
 		*tmp++ =3D *s++;
--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--MM5RgFPKyuP3gDcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEMQUjHb1edYOZ4bsRAnGvAJ4uw9lPhoNSuLYtwliagmghB+5xPwCfT+wS
7VAl2YQ1PHqvJvjxsWcJP64=
=jB3a
-----END PGP SIGNATURE-----

--MM5RgFPKyuP3gDcV--

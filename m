Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUG3Raf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUG3Raf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUG3Rae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:30:34 -0400
Received: from webmail-benelux.tiscali.be ([62.235.14.106]:42847 "EHLO
	mail.tiscali.be") by vger.kernel.org with ESMTP id S267764AbUG3R3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:29:51 -0400
Date: Fri, 30 Jul 2004 19:29:40 +0200
Message-ID: <40FB9ACA00005770@ocpmta1.freegates.net>
In-Reply-To: <40FB9ACA00005567@ocpmta1.freegates.net>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
To: "Jon Oberheide" <jon@oberheide.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Daniel Jacobowitz" <dan@debian.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========/40FB9ACA00005770/mail.tiscali.be"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--========/40FB9ACA00005770/mail.tiscali.be
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

And finaly may be lib/crc32.c diff like:
--- linux-2.4.27-rc3-pa6mm/lib/crc32.c.Orig	2004-06-29 11:29:31.000000000=

+0200
+++ linux-2.4.27-rc3-pa6mm/lib/crc32.c	2004-07-30 17:17:56.143095488 +020=
0
@@ -99,7 +99,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *pb =3D (u8 *)b;
+			DO_CRC(*pb++);
+			b =3D (u32 *)pb;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >=3D 4)){
@@ -120,7 +122,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *pb =3D (u8 *)b;
+			DO_CRC(*pb++);
+			b =3D (u32 *)pb;
 		} while (--len);
 	}
 
@@ -200,7 +204,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *pb =3D (u8 *)b;
+			DO_CRC(*pb++);
+			b =3D (u32 *)pb;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >=3D 4)){
@@ -221,7 +227,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *pb =3D (u8 *)b;
+			DO_CRC(*pb++);
+			b =3D (u32 *)pb;
 		} while (--len);
 	}
 	return __be32_to_cpu(crc);
=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D

(i prefer pb to avoid possible reading confusion with outer p parameter?
and replace usage of (void *) by (u32 *) as the actual b type)

Thanks for additional attention,
    Joel

-------------------------------------------------------------------------=
--
Tiscali ADSL LIGHT, 19,95 EUR/mois pendant 6 mois, c'est le moment de fai=
re
le pas!
http://reg.tiscali.be/default.asp?lg=3Dfr





--========/40FB9ACA00005770/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lib-crc32.c.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzMtcGE2bW0vbGliL2NyYzMyLmMuT3JpZwkyMDA0LTA2LTI5IDEx
OjI5OjMxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi40LjI3LXJjMy1wYTZtbS9saWIvY3Jj
MzIuYwkyMDA0LTA3LTMwIDE3OjE3OjU2LjE0MzA5NTQ4OCArMDIwMApAQCAtOTksNyArOTksOSBA
QAogCS8qIEFsaWduIGl0ICovCiAJaWYodW5saWtlbHkoKChsb25nKWIpJjMgJiYgbGVuKSl7CiAJ
CWRvIHsKLQkJCURPX0NSQygqKCh1OCAqKWIpKyspOworCQkJdTggKnBiID0gKHU4ICopYjsKKwkJ
CURPX0NSQygqcGIrKyk7CisJCQliID0gKHUzMiAqKXBiOwogCQl9IHdoaWxlICgoLS1sZW4pICYm
ICgobG9uZyliKSYzICk7CiAJfQogCWlmKGxpa2VseShsZW4gPj0gNCkpewpAQCAtMTIwLDcgKzEy
Miw5IEBACiAJLyogQW5kIHRoZSBsYXN0IGZldyBieXRlcyAqLwogCWlmKGxlbil7CiAJCWRvIHsK
LQkJCURPX0NSQygqKCh1OCAqKWIpKyspOworCQkJdTggKnBiID0gKHU4ICopYjsKKwkJCURPX0NS
QygqcGIrKyk7CisJCQliID0gKHUzMiAqKXBiOwogCQl9IHdoaWxlICgtLWxlbik7CiAJfQogCkBA
IC0yMDAsNyArMjA0LDkgQEAKIAkvKiBBbGlnbiBpdCAqLwogCWlmKHVubGlrZWx5KCgobG9uZyli
KSYzICYmIGxlbikpewogCQlkbyB7Ci0JCQlET19DUkMoKigodTggKiliKSsrKTsKKwkJCXU4ICpw
YiA9ICh1OCAqKWI7CisJCQlET19DUkMoKnBiKyspOworCQkJYiA9ICh1MzIgKilwYjsKIAkJfSB3
aGlsZSAoKC0tbGVuKSAmJiAoKGxvbmcpYikmMyApOwogCX0KIAlpZihsaWtlbHkobGVuID49IDQp
KXsKQEAgLTIyMSw3ICsyMjcsOSBAQAogCS8qIEFuZCB0aGUgbGFzdCBmZXcgYnl0ZXMgKi8KIAlp
ZihsZW4pewogCQlkbyB7Ci0JCQlET19DUkMoKigodTggKiliKSsrKTsKKwkJCXU4ICpwYiA9ICh1
OCAqKWI7CisJCQlET19DUkMoKnBiKyspOworCQkJYiA9ICh1MzIgKilwYjsKIAkJfSB3aGlsZSAo
LS1sZW4pOwogCX0KIAlyZXR1cm4gX19iZTMyX3RvX2NwdShjcmMpOwo=

--========/40FB9ACA00005770/mail.tiscali.be--

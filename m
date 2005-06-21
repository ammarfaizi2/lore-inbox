Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFULXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFULXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFULXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:23:21 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:23558 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261172AbVFUKtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 06:49:53 -0400
Message-Id: <42B802F2020000780001CEAB@lyle.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 21 Jun 2005 04:07:14 -0600
From: "Jan Beulich" <JBeulich@novell.com>
To: "Gerd Knorr" <kraxel@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] allow vesafb to build when no CONFIG_MTRR
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB99A41C2.38__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=__PartB99A41C2.38__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

vesafb didn't build when CONFIG_MTRR wasn't set.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- /home/jbeulich/tmp/linux-2.6.12/drivers/video/vesafb.c	2005-06-17 =
21:48:29.000000000 +0200
+++ 2.6.12/drivers/video/vesafb.c	2005-06-21 09:56:14.572032960 =
+0200
@@ -45,7 +45,9 @@ static struct fb_fix_screeninfo vesafb_f
 };
=20
 static int             inverse   =3D 0;
+#ifdef CONFIG_MTRR
 static int             mtrr      =3D 1;
+#endif
 static int	       vram_remap __initdata =3D 0; /* Set amount of =
memory to be used */
 static int	       vram_total __initdata =3D 0; /* Set total amount of =
memory */
 static int             pmi_setpal =3D 0;	/* pmi for palette changes =
??? */
@@ -204,10 +206,12 @@ static int __init vesafb_setup(char *opt
 			pmi_setpal=3D0;
 		else if (! strcmp(this_opt, "pmipal"))
 			pmi_setpal=3D1;
+#ifdef CONFIG_MTRR
 		else if (! strcmp(this_opt, "mtrr"))
 			mtrr=3D1;
 		else if (! strcmp(this_opt, "nomtrr"))
 			mtrr=3D0;
+#endif
 		else if (! strncmp(this_opt, "vtotal:", 7))
 			vram_total =3D simple_strtoul(this_opt+7, NULL, =
0);
 		else if (! strncmp(this_opt, "vremap:", 7))
@@ -385,8 +389,9 @@ static int __init vesafb_probe(struct de
 	 * region already (FIXME) */
 	request_region(0x3c0, 32, "vesafb");
=20
+#ifdef CONFIG_MTRR
 	if (mtrr) {
-		int temp_size =3D size_total;
+		unsigned int temp_size =3D size_total;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
                 	temp_size &=3D (temp_size - 1);
@@ -396,6 +401,7 @@ static int __init vesafb_probe(struct de
 			temp_size >>=3D 1;
 		}
 	}
+#endif
 =09
 	info->fbops =3D &vesafb_ops;
 	info->var =3D vesafb_defined;



--=__PartB99A41C2.38__=
Content-Type: application/octet-stream; name="linux-2.6.12-vesafb-no-mtrr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.12-vesafb-no-mtrr.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCnZlc2FmYiBkaWRuJ3QgYnVpbGQgd2hlbiBD
T05GSUdfTVRSUiB3YXNuJ3Qgc2V0LgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVs
aWNoQG5vdmVsbC5jb20+CgotLS0gL2hvbWUvamJldWxpY2gvdG1wL2xpbnV4LTIuNi4xMi9kcml2
ZXJzL3ZpZGVvL3Zlc2FmYi5jCTIwMDUtMDYtMTcgMjE6NDg6MjkuMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTIvZHJpdmVycy92aWRlby92ZXNhZmIuYwkyMDA1LTA2LTIxIDA5OjU2OjE0LjU3MjAz
Mjk2MCArMDIwMApAQCAtNDUsNyArNDUsOSBAQCBzdGF0aWMgc3RydWN0IGZiX2ZpeF9zY3JlZW5p
bmZvIHZlc2FmYl9mCiB9OwogCiBzdGF0aWMgaW50ICAgICAgICAgICAgIGludmVyc2UgICA9IDA7
CisjaWZkZWYgQ09ORklHX01UUlIKIHN0YXRpYyBpbnQgICAgICAgICAgICAgbXRyciAgICAgID0g
MTsKKyNlbmRpZgogc3RhdGljIGludAkgICAgICAgdnJhbV9yZW1hcCBfX2luaXRkYXRhID0gMDsg
LyogU2V0IGFtb3VudCBvZiBtZW1vcnkgdG8gYmUgdXNlZCAqLwogc3RhdGljIGludAkgICAgICAg
dnJhbV90b3RhbCBfX2luaXRkYXRhID0gMDsgLyogU2V0IHRvdGFsIGFtb3VudCBvZiBtZW1vcnkg
Ki8KIHN0YXRpYyBpbnQgICAgICAgICAgICAgcG1pX3NldHBhbCA9IDA7CS8qIHBtaSBmb3IgcGFs
ZXR0ZSBjaGFuZ2VzID8/PyAqLwpAQCAtMjA0LDEwICsyMDYsMTIgQEAgc3RhdGljIGludCBfX2lu
aXQgdmVzYWZiX3NldHVwKGNoYXIgKm9wdAogCQkJcG1pX3NldHBhbD0wOwogCQllbHNlIGlmICgh
IHN0cmNtcCh0aGlzX29wdCwgInBtaXBhbCIpKQogCQkJcG1pX3NldHBhbD0xOworI2lmZGVmIENP
TkZJR19NVFJSCiAJCWVsc2UgaWYgKCEgc3RyY21wKHRoaXNfb3B0LCAibXRyciIpKQogCQkJbXRy
cj0xOwogCQllbHNlIGlmICghIHN0cmNtcCh0aGlzX29wdCwgIm5vbXRyciIpKQogCQkJbXRycj0w
OworI2VuZGlmCiAJCWVsc2UgaWYgKCEgc3RybmNtcCh0aGlzX29wdCwgInZ0b3RhbDoiLCA3KSkK
IAkJCXZyYW1fdG90YWwgPSBzaW1wbGVfc3RydG91bCh0aGlzX29wdCs3LCBOVUxMLCAwKTsKIAkJ
ZWxzZSBpZiAoISBzdHJuY21wKHRoaXNfb3B0LCAidnJlbWFwOiIsIDcpKQpAQCAtMzg1LDggKzM4
OSw5IEBAIHN0YXRpYyBpbnQgX19pbml0IHZlc2FmYl9wcm9iZShzdHJ1Y3QgZGUKIAkgKiByZWdp
b24gYWxyZWFkeSAoRklYTUUpICovCiAJcmVxdWVzdF9yZWdpb24oMHgzYzAsIDMyLCAidmVzYWZi
Iik7CiAKKyNpZmRlZiBDT05GSUdfTVRSUgogCWlmIChtdHJyKSB7Ci0JCWludCB0ZW1wX3NpemUg
PSBzaXplX3RvdGFsOworCQl1bnNpZ25lZCBpbnQgdGVtcF9zaXplID0gc2l6ZV90b3RhbDsKIAkJ
LyogRmluZCB0aGUgbGFyZ2VzdCBwb3dlci1vZi10d28gKi8KIAkJd2hpbGUgKHRlbXBfc2l6ZSAm
ICh0ZW1wX3NpemUgLSAxKSkKICAgICAgICAgICAgICAgICAJdGVtcF9zaXplICY9ICh0ZW1wX3Np
emUgLSAxKTsKQEAgLTM5Niw2ICs0MDEsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB2ZXNhZmJfcHJv
YmUoc3RydWN0IGRlCiAJCQl0ZW1wX3NpemUgPj49IDE7CiAJCX0KIAl9CisjZW5kaWYKIAkKIAlp
bmZvLT5mYm9wcyA9ICZ2ZXNhZmJfb3BzOwogCWluZm8tPnZhciA9IHZlc2FmYl9kZWZpbmVkOwo=

--=__PartB99A41C2.38__=--

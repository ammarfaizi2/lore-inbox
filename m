Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVFUMfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFUMfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFUMfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:35:42 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:24074 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261348AbVFUMZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:25:25 -0400
Message-Id: <42B82360020000780001CECB@lyle.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 21 Jun 2005 06:25:36 -0600
From: "Jan Beulich" <JBeulich@novell.com>
To: "Gerd Knorr" <kraxel@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] allow vesafb to build when no CONFIG_MTRR
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC5E63250.18__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=__PartC5E63250.18__=
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>> Gerd Knorr <kraxel@suse.de> 21.06.05 13:14:05 >>>
>> +#ifdef CONFIG_MTRR
>>  	if (mtrr) {
>> -		int temp_size =3D size_total;
>> +		unsigned int temp_size =3D size_total;
>>  		/* Find the largest power-of-two */
>>  		while (temp_size & (temp_size - 1))
>>                  	temp_size &=3D (temp_size - 1);
>> @@ -396,6 +401,7 @@ static int __init vesafb_probe(struct de
>>  			temp_size >>=3D 1;
>>  		}
>>  	}
>> +#endif
>
>I'd just do that to avoid cluttering up the source with
>#ifdef's, otherwise it looks ok to me ;)

Ok, then here is the minimalist alternative (also realized that the int *> =
unsigned int change doesn't belong here):

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

vesafb didn't build when CONFIG_MTRR wasn't set.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- /home/jbeulich/tmp/linux-2.6.12/drivers/video/vesafb.c	2005-06-17 =
21:48:29.000000000 +0200
+++ 2.6.12/drivers/video/vesafb.c	2005-06-21 13:56:14.572032960 =
+0200
@@ -385,6 +385,7 @@ static int __init vesafb_probe(struct de
 	 * region already (FIXME) */
 	request_region(0x3c0, 32, "vesafb");
=20
+#ifdef CONFIG_MTRR
 	if (mtrr) {
 		int temp_size =3D size_total;
 		/* Find the largest power-of-two */
@@ -396,6 +397,7 @@ static int __init vesafb_probe(struct de
 			temp_size >>=3D 1;
 		}
 	}
+#endif
 =09
 	info->fbops =3D &vesafb_ops;
 	info->var =3D vesafb_defined;





--=__PartC5E63250.18__=
Content-Type: application/octet-stream; name="linux-2.6.12-vesafb-no-mtrr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.12-vesafb-no-mtrr.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCnZlc2FmYiBkaWRuJ3QgYnVpbGQgd2hlbiBD
T05GSUdfTVRSUiB3YXNuJ3Qgc2V0LgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVs
aWNoQG5vdmVsbC5jb20+CgotLS0gL2hvbWUvamJldWxpY2gvdG1wL2xpbnV4LTIuNi4xMi9kcml2
ZXJzL3ZpZGVvL3Zlc2FmYi5jCTIwMDUtMDYtMTcgMjE6NDg6MjkuMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTIvZHJpdmVycy92aWRlby92ZXNhZmIuYwkyMDA1LTA2LTIxIDEzOjU2OjE0LjU3MjAz
Mjk2MCArMDIwMApAQCAtMzg1LDYgKzM4NSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHZlc2FmYl9w
cm9iZShzdHJ1Y3QgZGUKIAkgKiByZWdpb24gYWxyZWFkeSAoRklYTUUpICovCiAJcmVxdWVzdF9y
ZWdpb24oMHgzYzAsIDMyLCAidmVzYWZiIik7CiAKKyNpZmRlZiBDT05GSUdfTVRSUgogCWlmICht
dHJyKSB7CiAJCWludCB0ZW1wX3NpemUgPSBzaXplX3RvdGFsOwogCQkvKiBGaW5kIHRoZSBsYXJn
ZXN0IHBvd2VyLW9mLXR3byAqLwpAQCAtMzk2LDYgKzM5Nyw3IEBAIHN0YXRpYyBpbnQgX19pbml0
IHZlc2FmYl9wcm9iZShzdHJ1Y3QgZGUKIAkJCXRlbXBfc2l6ZSA+Pj0gMTsKIAkJfQogCX0KKyNl
bmRpZgogCQogCWluZm8tPmZib3BzID0gJnZlc2FmYl9vcHM7CiAJaW5mby0+dmFyID0gdmVzYWZi
X2RlZmluZWQ7Cg==

--=__PartC5E63250.18__=--

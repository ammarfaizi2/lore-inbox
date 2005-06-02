Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFBPgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFBPgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVFBPgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:36:03 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:57508 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbVFBPfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:35:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=Bzli26u0zFSJ/tkQet5LpEnNiaHUySfbMe4IHq8bzQoOFPBcjyO0loGH1mq0KMgdZeFHjRMKm+u64OcW8qwbL9O0M16d0DXVvrnjxAj6xSz2tR+LjKcV+eU7b49l3pXuFteBm2ooOhvcx3qO/7u8GA8GPus9gBMZQITMAgOnYdA=
Message-ID: <416f085805060208352de7e44e@mail.gmail.com>
Date: Thu, 2 Jun 2005 18:35:38 +0300
From: Kiril Jovchev <jovchev@gmail.com>
Reply-To: Kiril Jovchev <jovchev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Creative WebCam mini driver
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1156_29998617.1117726538824"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1156_29998617.1117726538824
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have send patch quite a while ago for 2.6.8 version of kernel and I
did not got any reply from the list.
So now I'm sending the patch again for 2.6.11.11 kernel what is latest stab=
le.

I am attaching the patch files and puting their code in the e-mail
body at the end of the e-mail.

I hope that I will get some reply this time.

Kiril Jovchev

--- linux-2.6.11.11/drivers/usb/media/stv680.c=092005-05-27
08:06:46.000000000 +0300
+++ linux/drivers/usb/media/stv680.c=092005-06-02 17:59:52.000000000 +0300
@@ -9,6 +9,9 @@
  * Endpoints (formerly known as AOX) se401 USB Camera Driver
  * Copyright (c) 2000 Jeroen B. Vreeken (pe1rxq@amsat.org)
  *
+ * Creative WebCam Go Mini Driver, modified by Kiril Jovchev=20
+ * (jovchev@gmail.com)
+ *
  * Still somewhat based on the Linux ov511 driver.
  *=20
  * This program is free software; you can redistribute it and/or modify it
@@ -56,6 +59,11 @@
  *=09=09=09   to set to a non-supported size. This allowed
  *=09=09=09   gnomemeeting to work.
  *=09=09=09   Fixed proc entry removal bug.
+ *
+ * ver 0.26 Sep, 2004 (kjv)=20
+ * =09=09=09   Added support for Creative WebCam Go mini.=20
+ * =09=09=09   Camera is based on same chip.=20
+ *=20
  */
=20
 #include <linux/config.h>
@@ -1375,9 +1383,14 @@
 =09    (le16_to_cpu(dev->descriptor.idProduct) =3D=3D USB_PENCAM_PRODUCT_I=
D)) {
 =09=09camera_name =3D "STV0680";
 =09=09PDEBUG (0, "STV(i): STV0680 camera found.");
-=09} else {
-=09=09PDEBUG (0, "STV(e): Vendor/Product ID do not match STV0680 values.")=
;
-=09=09PDEBUG (0, "STV(e): Check that the STV0680 camera is connected to
the computer.");
+=09} else if ((le16_to_cpu(dev->descriptor.idVendor) =3D=3D
USB_CREATIVEGOMINI_VENDOR_ID) &&
+            (le16_to_cpu(dev->descriptor.idProduct) =3D=3D
USB_CREATIVEGOMINI_PRODUCT_ID)) {
+                camera_name =3D "Creative WebCam Go Mini";
+                PDEBUG (0, "STV(i): Creative WebCam Go Mini found.");
+=09}=20
+=09else {
+=09=09PDEBUG (0, "STV(e): Vendor/Product ID do not match STV0680 or
Creative WebCam Go Mini values.");
+=09=09PDEBUG (0, "STV(e): Check that the STV0680 or Creative WebCam Go
Mini camera is connected to the computer.");
 =09=09retval =3D -ENODEV;
 =09=09goto error;
 =09}


--- linux-2.6.11.11/drivers/usb/media/stv680.h=092005-05-27
08:06:46.000000000 +0300
+++ linux/drivers/usb/media/stv680.h=092005-06-02 18:00:03.000000000 +0300
@@ -41,13 +41,19 @@
=20
 #define USB_PENCAM_VENDOR_ID=090x0553
 #define USB_PENCAM_PRODUCT_ID=090x0202
+
+#define USB_CREATIVEGOMINI_VENDOR_ID 0x041e=20
+#define USB_CREATIVEGOMINI_PRODUCT_ID 0x4007
+
 #define PENCAM_TIMEOUT          1000
 /* fmt 4 */
 #define STV_VIDEO_PALETTE       VIDEO_PALETTE_RGB24
=20
 static struct usb_device_id device_table[] =3D {
 =09{USB_DEVICE (USB_PENCAM_VENDOR_ID, USB_PENCAM_PRODUCT_ID)},
+=09{USB_DEVICE (USB_CREATIVEGOMINI_VENDOR_ID, USB_CREATIVEGOMINI_PRODUCT_I=
D)},
 =09{}
+=09
 };
 MODULE_DEVICE_TABLE (usb, device_table);

------=_Part_1156_29998617.1117726538824
Content-Type: application/octet-stream; name="stv680.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="stv680.c.patch"

LS0tIGxpbnV4LTIuNi4xMS4xMS9kcml2ZXJzL3VzYi9tZWRpYS9zdHY2ODAuYwkyMDA1LTA1LTI3
IDA4OjA2OjQ2LjAwMDAwMDAwMCArMDMwMAorKysgbGludXgvZHJpdmVycy91c2IvbWVkaWEvc3R2
NjgwLmMJMjAwNS0wNi0wMiAxNzo1OTo1Mi4wMDAwMDAwMDAgKzAzMDAKQEAgLTksNiArOSw5IEBA
CiAgKiBFbmRwb2ludHMgKGZvcm1lcmx5IGtub3duIGFzIEFPWCkgc2U0MDEgVVNCIENhbWVyYSBE
cml2ZXIKICAqIENvcHlyaWdodCAoYykgMjAwMCBKZXJvZW4gQi4gVnJlZWtlbiAocGUxcnhxQGFt
c2F0Lm9yZykKICAqCisgKiBDcmVhdGl2ZSBXZWJDYW0gR28gTWluaSBEcml2ZXIsIG1vZGlmaWVk
IGJ5IEtpcmlsIEpvdmNoZXYgCisgKiAoam92Y2hldkBnbWFpbC5jb20pCisgKgogICogU3RpbGwg
c29tZXdoYXQgYmFzZWQgb24gdGhlIExpbnV4IG92NTExIGRyaXZlci4KICAqIAogICogVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkgaXQKQEAgLTU2LDYgKzU5LDExIEBACiAgKgkJCSAgIHRvIHNldCB0byBhIG5vbi1zdXBw
b3J0ZWQgc2l6ZS4gVGhpcyBhbGxvd2VkCiAgKgkJCSAgIGdub21lbWVldGluZyB0byB3b3JrLgog
ICoJCQkgICBGaXhlZCBwcm9jIGVudHJ5IHJlbW92YWwgYnVnLgorICoKKyAqIHZlciAwLjI2IFNl
cCwgMjAwNCAoa2p2KSAKKyAqIAkJCSAgIEFkZGVkIHN1cHBvcnQgZm9yIENyZWF0aXZlIFdlYkNh
bSBHbyBtaW5pLiAKKyAqIAkJCSAgIENhbWVyYSBpcyBiYXNlZCBvbiBzYW1lIGNoaXAuIAorICog
CiAgKi8KIAogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgpAQCAtMTM3NSw5ICsxMzgzLDE0IEBA
CiAJICAgIChsZTE2X3RvX2NwdShkZXYtPmRlc2NyaXB0b3IuaWRQcm9kdWN0KSA9PSBVU0JfUEVO
Q0FNX1BST0RVQ1RfSUQpKSB7CiAJCWNhbWVyYV9uYW1lID0gIlNUVjA2ODAiOwogCQlQREVCVUcg
KDAsICJTVFYoaSk6IFNUVjA2ODAgY2FtZXJhIGZvdW5kLiIpOwotCX0gZWxzZSB7Ci0JCVBERUJV
RyAoMCwgIlNUVihlKTogVmVuZG9yL1Byb2R1Y3QgSUQgZG8gbm90IG1hdGNoIFNUVjA2ODAgdmFs
dWVzLiIpOwotCQlQREVCVUcgKDAsICJTVFYoZSk6IENoZWNrIHRoYXQgdGhlIFNUVjA2ODAgY2Ft
ZXJhIGlzIGNvbm5lY3RlZCB0byB0aGUgY29tcHV0ZXIuIik7CisJfSBlbHNlIGlmICgobGUxNl90
b19jcHUoZGV2LT5kZXNjcmlwdG9yLmlkVmVuZG9yKSA9PSBVU0JfQ1JFQVRJVkVHT01JTklfVkVO
RE9SX0lEKSAmJgorICAgICAgICAgICAgKGxlMTZfdG9fY3B1KGRldi0+ZGVzY3JpcHRvci5pZFBy
b2R1Y3QpID09IFVTQl9DUkVBVElWRUdPTUlOSV9QUk9EVUNUX0lEKSkgeworICAgICAgICAgICAg
ICAgIGNhbWVyYV9uYW1lID0gIkNyZWF0aXZlIFdlYkNhbSBHbyBNaW5pIjsKKyAgICAgICAgICAg
ICAgICBQREVCVUcgKDAsICJTVFYoaSk6IENyZWF0aXZlIFdlYkNhbSBHbyBNaW5pIGZvdW5kLiIp
OworCX0gCisJZWxzZSB7CisJCVBERUJVRyAoMCwgIlNUVihlKTogVmVuZG9yL1Byb2R1Y3QgSUQg
ZG8gbm90IG1hdGNoIFNUVjA2ODAgb3IgQ3JlYXRpdmUgV2ViQ2FtIEdvIE1pbmkgdmFsdWVzLiIp
OworCQlQREVCVUcgKDAsICJTVFYoZSk6IENoZWNrIHRoYXQgdGhlIFNUVjA2ODAgb3IgQ3JlYXRp
dmUgV2ViQ2FtIEdvIE1pbmkgY2FtZXJhIGlzIGNvbm5lY3RlZCB0byB0aGUgY29tcHV0ZXIuIik7
CiAJCXJldHZhbCA9IC1FTk9ERVY7CiAJCWdvdG8gZXJyb3I7CiAJfQo=
------=_Part_1156_29998617.1117726538824
Content-Type: application/octet-stream; name="stv680.h.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="stv680.h.patch"

LS0tIGxpbnV4LTIuNi4xMS4xMS9kcml2ZXJzL3VzYi9tZWRpYS9zdHY2ODAuaAkyMDA1LTA1LTI3
IDA4OjA2OjQ2LjAwMDAwMDAwMCArMDMwMAorKysgbGludXgvZHJpdmVycy91c2IvbWVkaWEvc3R2
NjgwLmgJMjAwNS0wNi0wMiAxODowMDowMy4wMDAwMDAwMDAgKzAzMDAKQEAgLTQxLDEzICs0MSwx
OSBAQAogCiAjZGVmaW5lIFVTQl9QRU5DQU1fVkVORE9SX0lECTB4MDU1MwogI2RlZmluZSBVU0Jf
UEVOQ0FNX1BST0RVQ1RfSUQJMHgwMjAyCisKKyNkZWZpbmUgVVNCX0NSRUFUSVZFR09NSU5JX1ZF
TkRPUl9JRCAweDA0MWUgCisjZGVmaW5lIFVTQl9DUkVBVElWRUdPTUlOSV9QUk9EVUNUX0lEIDB4
NDAwNworCiAjZGVmaW5lIFBFTkNBTV9USU1FT1VUICAgICAgICAgIDEwMDAKIC8qIGZtdCA0ICov
CiAjZGVmaW5lIFNUVl9WSURFT19QQUxFVFRFICAgICAgIFZJREVPX1BBTEVUVEVfUkdCMjQKIAog
c3RhdGljIHN0cnVjdCB1c2JfZGV2aWNlX2lkIGRldmljZV90YWJsZVtdID0gewogCXtVU0JfREVW
SUNFIChVU0JfUEVOQ0FNX1ZFTkRPUl9JRCwgVVNCX1BFTkNBTV9QUk9EVUNUX0lEKX0sCisJe1VT
Ql9ERVZJQ0UgKFVTQl9DUkVBVElWRUdPTUlOSV9WRU5ET1JfSUQsIFVTQl9DUkVBVElWRUdPTUlO
SV9QUk9EVUNUX0lEKX0sCiAJe30KKwkKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFICh1c2IsIGRl
dmljZV90YWJsZSk7CiAK
------=_Part_1156_29998617.1117726538824--

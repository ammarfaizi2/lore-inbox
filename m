Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSLBSiX>; Mon, 2 Dec 2002 13:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbSLBSiW>; Mon, 2 Dec 2002 13:38:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:64511 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264842AbSLBSiU>; Mon, 2 Dec 2002 13:38:20 -0500
From: Christian Borntraeger <linux@borntraeger.net>
To: <kai.germaschewski@gmx.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - EVALUATION VERSION
Date: Mon, 2 Dec 2002 18:45:46 GMT
X-URL: http://www.pocomail.com/
Subject: [PATCH] isdn-tty driver not HZ aware
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="24334047-POCO-62426320"
Message-Id: <E18IvZl-0000Lm-00@mrelayng.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format

--24334047-POCO-62426320
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch makes isdn_tty HZ aware.
The first change changes 3000 jiffies (now 3 seconds) to 30=
 seconds according to the comment.
I dont know, if the second change (schedule_timeout(50);) has to=
 be half a second but this was the value used in 2.4.

--- drivers/isdn/i4l/isdn_tty.c.org=092002-11-27 22:36:16.000000000=
 +0000
+++ drivers/isdn/i4l/isdn_tty.c=092002-12-01 19:03:15.000000000=
 +0000
@@ -1876,7 +1876,7 @@
 =09 * line status register.
 =09 */
 =09if (info->flags & ISDN_ASYNC_INITIALIZED) {
-=09=09tty_wait_until_sent(tty, 3000);=09/* 30 seconds timeout */
+=09=09tty_wait_until_sent(tty, 30 * HZ);=09/* 30 seconds timeout */
 =09=09/*
 =09=09 * Before we drop DTR, make sure the UART transmitter
 =09=09 * has completely drained; this is especially
@@ -1901,7 +1901,7 @@
 =09tty->closing =3D 0;
 =09if (info->blocked_open) {
 =09=09set_current_state(TASK_INTERRUPTIBLE);
-=09=09schedule_timeout(50);
+=09=09schedule_timeout(HZ/2);
 =09=09wake_up_interruptible(&info->open_wait);
 =09}
 =09info->flags &=3D ~(ISDN_ASYNC_NORMAL_ACTIVE |=
 ISDN_ASYNC_CALLOUT_ACTIVE |

--24334047-POCO-62426320
Content-Type: application/octet-stream; name="isdn.patch"
Content-Transfer-Encoding: Base64
Content-Disposition: attachment; filename="isdn.patch"

LS0tIGRyaXZlcnMvaXNkbi9pNGwvaXNkbl90dHkuYy5vcmcJMjAwMi0xMS0yNyAyMjozNjoxNi4w
MDAwMDAwMDAgKzAwMDAKKysrIGRyaXZlcnMvaXNkbi9pNGwvaXNkbl90dHkuYwkyMDAyLTEyLTAx
IDE5OjAzOjE1LjAwMDAwMDAwMCArMDAwMApAQCAtMTg3Niw3ICsxODc2LDcgQEAKIAkgKiBsaW5l
IHN0YXR1cyByZWdpc3Rlci4KIAkgKi8KIAlpZiAoaW5mby0+ZmxhZ3MgJiBJU0ROX0FTWU5DX0lO
SVRJQUxJWkVEKSB7Ci0JCXR0eV93YWl0X3VudGlsX3NlbnQodHR5LCAzMDAwKTsJLyogMzAgc2Vj
b25kcyB0aW1lb3V0ICovCisJCXR0eV93YWl0X3VudGlsX3NlbnQodHR5LCAzMCAqIEhaKTsJLyog
MzAgc2Vjb25kcyB0aW1lb3V0ICovCiAJCS8qCiAJCSAqIEJlZm9yZSB3ZSBkcm9wIERUUiwgbWFr
ZSBzdXJlIHRoZSBVQVJUIHRyYW5zbWl0dGVyCiAJCSAqIGhhcyBjb21wbGV0ZWx5IGRyYWluZWQ7
IHRoaXMgaXMgZXNwZWNpYWxseQpAQCAtMTkwMSw3ICsxOTAxLDcgQEAKIAl0dHktPmNsb3Npbmcg
PSAwOwogCWlmIChpbmZvLT5ibG9ja2VkX29wZW4pIHsKIAkJc2V0X2N1cnJlbnRfc3RhdGUoVEFT
S19JTlRFUlJVUFRJQkxFKTsKLQkJc2NoZWR1bGVfdGltZW91dCg1MCk7CisJCXNjaGVkdWxlX3Rp
bWVvdXQoSFovMik7CiAJCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmaW5mby0+b3Blbl93YWl0KTsK
IAl9CiAJaW5mby0+ZmxhZ3MgJj0gfihJU0ROX0FTWU5DX05PUk1BTF9BQ1RJVkUgfCBJU0ROX0FT
WU5DX0NBTExPVVRfQUNUSVZFIHwK

--24334047-POCO-62426320--


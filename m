Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSLBJUa>; Mon, 2 Dec 2002 04:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSLBJUa>; Mon, 2 Dec 2002 04:20:30 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:33928 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S261742AbSLBJU1>; Mon, 2 Dec 2002 04:20:27 -0500
From: Christian Borntraeger <christian@borntraeger.net>
To: <linux-kernel@vger.kernel.org>
CC: <linux390@de.ibm.com>
X-Mailer: PocoMail 2.63 (1077) - EVALUATION VERSION
Date: Mon, 2 Dec 2002 09:27:53 GMT
X-URL: http://www.pocomail.com/
Subject: [PATCH] 2.5.50 ctctty not aware of new HZ value
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="60736045-POCO-55883843"
Message-Id: <E18Imrr-0007EA-00@marl.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format

--60736045-POCO-55883843
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

this patch replaces 2 numeric values with a HZ-related version in=
 the ctc 
driver of the S/390.
Its obvious that the first one is wrong, but I am not sure if the=
 value of the 
timeout is important for the 2nd change. Nevertheless the HZ=
 value has 
changed, so should the timeout.


There are some changes neccessary in some other serial drivers. 
If there is interest, I will send patches for them as well.
cheers 

Christian

--- drivers/s390/net/ctctty.org=092002-11-27 22:36:02.000000000=
 +0000
+++ drivers/s390/net/ctctty.c=092002-12-01 17:45:09.000000000=
 +0000
@@ -1094,7 +1094,7 @@
 =09 * line status register.
 =09 */
 =09if (info->flags & CTC_ASYNC_INITIALIZED) {
-=09=09tty_wait_until_sent(tty, 3000);=09/* 30 seconds timeout */
+=09=09tty_wait_until_sent(tty, 30*HZ);=09/* 30 seconds timeout */
 =09=09/*
 =09=09 * Before we drop DTR, make sure the UART transmitter
 =09=09 * has completely drained; this is especially
@@ -1119,7 +1119,7 @@
 =09tty->closing =3D 0;
 =09if (info->blocked_open) {
 =09=09set_current_state(TASK_INTERRUPTIBLE);
-=09=09schedule_timeout(50);
+=09=09schedule_timeout(HZ/2);
 =09=09wake_up_interruptible(&info->open_wait);
 =09}
 =09info->flags &=3D ~(CTC_ASYNC_NORMAL_ACTIVE | CTC_ASYNC_CLOSING);

--- drivers/s390/net/ctctty.org=092002-11-27 22:36:02.000000000=
 +0000
+++ drivers/s390/net/ctctty.c=092002-12-01 17:45:09.000000000=
 +0000
@@ -1094,7 +1094,7 @@
 =09 * line status register.
 =09 */
 =09if (info->flags & CTC_ASYNC_INITIALIZED) {
-=09=09tty_wait_until_sent(tty, 3000);=09/* 30 seconds timeout */
+=09=09tty_wait_until_sent(tty, 30*HZ);=09/* 30 seconds timeout */
 =09=09/*
 =09=09 * Before we drop DTR, make sure the UART transmitter
 =09=09 * has completely drained; this is especially
@@ -1119,7 +1119,7 @@
 =09tty->closing =3D 0;
 =09if (info->blocked_open) {
 =09=09set_current_state(TASK_INTERRUPTIBLE);
-=09=09schedule_timeout(50);
+=09=09schedule_timeout(HZ/2);
 =09=09wake_up_interruptible(&info->open_wait);
 =09}
 =09info->flags &=3D ~(CTC_ASYNC_NORMAL_ACTIVE | CTC_ASYNC_CLOSING);



--60736045-POCO-55883843
Content-Type: application/octet-stream; name="ctc.patch"
Content-Transfer-Encoding: Base64
Content-Disposition: attachment; filename="ctc.patch"

LS0tIGRyaXZlcnMvczM5MC9uZXQvY3RjdHR5Lm9yZwkyMDAyLTExLTI3IDIyOjM2OjAyLjAwMDAw
MDAwMCArMDAwMAorKysgZHJpdmVycy9zMzkwL25ldC9jdGN0dHkuYwkyMDAyLTEyLTAxIDE3OjQ1
OjA5LjAwMDAwMDAwMCArMDAwMApAQCAtMTA5NCw3ICsxMDk0LDcgQEAKIAkgKiBsaW5lIHN0YXR1
cyByZWdpc3Rlci4KIAkgKi8KIAlpZiAoaW5mby0+ZmxhZ3MgJiBDVENfQVNZTkNfSU5JVElBTEla
RUQpIHsKLQkJdHR5X3dhaXRfdW50aWxfc2VudCh0dHksIDMwMDApOwkvKiAzMCBzZWNvbmRzIHRp
bWVvdXQgKi8KKwkJdHR5X3dhaXRfdW50aWxfc2VudCh0dHksIDMwICogSFopOwkvKiAzMCBzZWNv
bmRzIHRpbWVvdXQgKi8KIAkJLyoKIAkJICogQmVmb3JlIHdlIGRyb3AgRFRSLCBtYWtlIHN1cmUg
dGhlIFVBUlQgdHJhbnNtaXR0ZXIKIAkJICogaGFzIGNvbXBsZXRlbHkgZHJhaW5lZDsgdGhpcyBp
cyBlc3BlY2lhbGx5CkBAIC0xMTE5LDcgKzExMTksNyBAQAogCXR0eS0+Y2xvc2luZyA9IDA7CiAJ
aWYgKGluZm8tPmJsb2NrZWRfb3BlbikgewogCQlzZXRfY3VycmVudF9zdGF0ZShUQVNLX0lOVEVS
UlVQVElCTEUpOwotCQlzY2hlZHVsZV90aW1lb3V0KDUwKTsKKwkJc2NoZWR1bGVfdGltZW91dChI
Wi8yKTsKIAkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZpbmZvLT5vcGVuX3dhaXQpOwogCX0KIAlp
bmZvLT5mbGFncyAmPSB+KENUQ19BU1lOQ19OT1JNQUxfQUNUSVZFIHwgQ1RDX0FTWU5DX0NMT1NJ
TkcpOwo=

--60736045-POCO-55883843--


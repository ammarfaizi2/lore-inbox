Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWBITdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWBITdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWBITdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:33:05 -0500
Received: from mail0.lsil.com ([147.145.40.20]:62974 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750734AbWBITdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:33:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C62DAF.A256E329"
Subject: [PATCH 1/1] megaraid_legacy: kobject_register failure
Date: Thu, 9 Feb 2006 12:32:59 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C265142064@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_legacy: kobject_register failure
Thread-Index: AcYtr6IagO656D20Qb6s0BxMbob1uA==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Greg KH" <greg@kroah.com>, "Meelis Roos" <mroos@linux.ee>
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 09 Feb 2006 19:32:59.0393 (UTC) FILETIME=[A2689F10:01C62DAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C62DAF.A256E329
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached patch fixes problem that cause kobject_register failure during
loading.
Kobject_register would fail when there are more than 1 module with same
module name.
This patch will change module name of megaraid_legacy from 'megaraid' to
'megaraid_legacy'.

Thank you,

Signed-Off-by: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur old/drivers/scsi/megaraid.c new/drivers/scsi/megaraid.c
--- old/drivers/scsi/megaraid.c	2006-02-09 14:08:28.000000000 -0500
+++ new/drivers/scsi/megaraid.c	2006-02-09 14:10:10.000000000 -0500
@@ -5049,7 +5049,7 @@
 MODULE_DEVICE_TABLE(pci, megaraid_pci_tbl);
=20
 static struct pci_driver megaraid_pci_driver =3D {
-	.name		=3D "megaraid",
+	.name		=3D "megaraid_legacy",
 	.id_table	=3D megaraid_pci_tbl,
 	.probe		=3D megaraid_probe_one,
 	.remove		=3D __devexit_p(megaraid_remove_one),
diff -Naur old/drivers/scsi/megaraid.h new/drivers/scsi/megaraid.h
--- old/drivers/scsi/megaraid.h	2006-02-09 14:08:28.000000000 -0500
+++ new/drivers/scsi/megaraid.h	2006-02-09 14:09:34.000000000 -0500
@@ -5,7 +5,7 @@
 #include <linux/mutex.h>
=20
 #define MEGARAID_VERSION	\
-	"v2.00.3 (Release Date: Wed Feb 19 08:51:30 EST 2003)\n"
+	"v2.00.4 (Release Date: Thu Feb 9 08:51:30 EST 2006)\n"
=20
 /*
  * Driver features - change the values to enable or disable features in
the
---


------_=_NextPart_001_01C62DAF.A256E329
Content-Type: application/octet-stream;
	name="megaraid_legacy.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_legacy.patch
Content-Disposition: attachment;
	filename="megaraid_legacy.patch"

ZGlmZiAtTmF1ciBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMgbmV3L2RyaXZlcnMvc2NzaS9t
ZWdhcmFpZC5jCi0tLSBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMJMjAwNi0wMi0wOSAxNDow
ODoyOC4wMDAwMDAwMDAgLTA1MDAKKysrIG5ldy9kcml2ZXJzL3Njc2kvbWVnYXJhaWQuYwkyMDA2
LTAyLTA5IDE0OjEwOjEwLjAwMDAwMDAwMCAtMDUwMApAQCAtNTA0OSw3ICs1MDQ5LDcgQEAKIE1P
RFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBtZWdhcmFpZF9wY2lfdGJsKTsKIAogc3RhdGljIHN0cnVj
dCBwY2lfZHJpdmVyIG1lZ2FyYWlkX3BjaV9kcml2ZXIgPSB7Ci0JLm5hbWUJCT0gIm1lZ2FyYWlk
IiwKKwkubmFtZQkJPSAibWVnYXJhaWRfbGVnYWN5IiwKIAkuaWRfdGFibGUJPSBtZWdhcmFpZF9w
Y2lfdGJsLAogCS5wcm9iZQkJPSBtZWdhcmFpZF9wcm9iZV9vbmUsCiAJLnJlbW92ZQkJPSBfX2Rl
dmV4aXRfcChtZWdhcmFpZF9yZW1vdmVfb25lKSwKZGlmZiAtTmF1ciBvbGQvZHJpdmVycy9zY3Np
L21lZ2FyYWlkLmggbmV3L2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5oCi0tLSBvbGQvZHJpdmVycy9z
Y3NpL21lZ2FyYWlkLmgJMjAwNi0wMi0wOSAxNDowODoyOC4wMDAwMDAwMDAgLTA1MDAKKysrIG5l
dy9kcml2ZXJzL3Njc2kvbWVnYXJhaWQuaAkyMDA2LTAyLTA5IDE0OjA5OjM0LjAwMDAwMDAwMCAt
MDUwMApAQCAtNSw3ICs1LDcgQEAKICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgogCiAjZGVmaW5l
IE1FR0FSQUlEX1ZFUlNJT04JXAotCSJ2Mi4wMC4zIChSZWxlYXNlIERhdGU6IFdlZCBGZWIgMTkg
MDg6NTE6MzAgRVNUIDIwMDMpXG4iCisJInYyLjAwLjQgKFJlbGVhc2UgRGF0ZTogVGh1IEZlYiA5
IDA4OjUxOjMwIEVTVCAyMDA2KVxuIgogCiAvKgogICogRHJpdmVyIGZlYXR1cmVzIC0gY2hhbmdl
IHRoZSB2YWx1ZXMgdG8gZW5hYmxlIG9yIGRpc2FibGUgZmVhdHVyZXMgaW4gdGhlCg==

------_=_NextPart_001_01C62DAF.A256E329--

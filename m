Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUHDJR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUHDJR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUHDJR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:17:29 -0400
Received: from fmr05.intel.com ([134.134.136.6]:24765 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261987AbUHDJRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:17:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47A03.CA95D1AB"
Subject: [patch] pc100pad driver
Date: Wed, 4 Aug 2004 17:16:59 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F037BBE5A@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] pc100pad driver
Thread-Index: AcR6A8vGezVYrPL0TBK8UUS/3Wb09Q==
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <vojtech@ucw.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 09:16:58.0488 (UTC) FILETIME=[CB249780:01C47A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47A03.CA95D1AB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
'request_region' returns 0 if the request failed, but the code
(pc110pad.c) just does the contrary.=20

Thanks,
Shaohua


=3D=3D=3D=3D=3D drivers/input/mouse/pc110pad.c 1.9 vs edited =
=3D=3D=3D=3D=3D
--- 1.9/drivers/input/mouse/pc110pad.c	2004-07-27 05:27:05 +08:00
+++ edited/drivers/input/mouse/pc110pad.c	2004-08-04 16:56:17
+08:00
@@ -109,7 +109,7 @@ static int pc110pad_open(struct input_de
=20
 static int __init pc110pad_init(void)
 {
-	if (request_region(pc110pad_io, 4, "pc110pad"))
+	if (!request_region(pc110pad_io, 4, "pc110pad"))
 	{
 		printk(KERN_ERR "pc110pad: I/O area %#x-%#x in use.\n",
pc110pad_io, pc110pad_io + 4);
 		return -EBUSY;

------_=_NextPart_001_01C47A03.CA95D1AB
Content-Type: application/octet-stream;
	name="pc110pad.patch"
Content-Transfer-Encoding: base64
Content-Description: pc110pad.patch
Content-Disposition: attachment;
	filename="pc110pad.patch"

PT09PT0gZHJpdmVycy9pbnB1dC9tb3VzZS9wYzExMHBhZC5jIDEuOSB2cyBlZGl0ZWQgPT09PT0K
LS0tIDEuOS9kcml2ZXJzL2lucHV0L21vdXNlL3BjMTEwcGFkLmMJMjAwNC0wNy0yNyAwNToyNzow
NSArMDg6MDAKKysrIGVkaXRlZC9kcml2ZXJzL2lucHV0L21vdXNlL3BjMTEwcGFkLmMJMjAwNC0w
OC0wNCAxNjo1NjoxNyArMDg6MDAKQEAgLTEwOSw3ICsxMDksNyBAQCBzdGF0aWMgaW50IHBjMTEw
cGFkX29wZW4oc3RydWN0IGlucHV0X2RlCiAKIHN0YXRpYyBpbnQgX19pbml0IHBjMTEwcGFkX2lu
aXQodm9pZCkKIHsKLQlpZiAocmVxdWVzdF9yZWdpb24ocGMxMTBwYWRfaW8sIDQsICJwYzExMHBh
ZCIpKQorCWlmICghcmVxdWVzdF9yZWdpb24ocGMxMTBwYWRfaW8sIDQsICJwYzExMHBhZCIpKQog
CXsKIAkJcHJpbnRrKEtFUk5fRVJSICJwYzExMHBhZDogSS9PIGFyZWEgJSN4LSUjeCBpbiB1c2Uu
XG4iLCBwYzExMHBhZF9pbywgcGMxMTBwYWRfaW8gKyA0KTsKIAkJcmV0dXJuIC1FQlVTWTsK

------_=_NextPart_001_01C47A03.CA95D1AB--

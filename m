Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbTGHXCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267857AbTGHXCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:02:39 -0400
Received: from fmr03.intel.com ([143.183.121.5]:63430 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267852AbTGHXCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:02:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C345A7.0FAF303D"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Redundant memset in AIO read_events
Date: Tue, 8 Jul 2003 16:17:12 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A4889@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Redundant memset in AIO read_events
Thread-Index: AcNFpw+WoE2hkhMBRfCQ7mi+SkIgxQ==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-aio@kvack.org>
X-OriginalArrivalTime: 08 Jul 2003 23:17:12.0690 (UTC) FILETIME=[10019520:01C345A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C345A7.0FAF303D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

OK, here is another one.  In the top level read_events() function in
fs/aio.c, a struct io_event is instantiated on the stack (variable ent).
It calls aio_read_evt() function which will fill the entire io_event
structure into variable ent.  What's the point of zeroing when copy
covers the same memory area?  Possible a debug code left around?

- Ken
 <<aio.ent.patch>>=20

------_=_NextPart_001_01C345A7.0FAF303D
Content-Type: application/octet-stream;
	name="aio.ent.patch"
Content-Transfer-Encoding: base64
Content-Description: aio.ent.patch
Content-Disposition: attachment;
	filename="aio.ent.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNS43NC9mcy9haW8uYyBsaW51eC0yLjUuNzQuYWlvL2ZzL2Fpby5j
DQotLS0gbGludXgtMi41Ljc0L2ZzL2Fpby5jCVN1biBKdW4gMjIgMTE6MzI6NDMgMjAwMw0KKysr
IGxpbnV4LTIuNS43NC5haW8vZnMvYWlvLmMJVHVlIEp1bCAgOCAxNjoxMTo1MCAyMDAzDQpAQCAt
ODA1LDEwICs4MDUsNiBAQA0KIAlzdHJ1Y3QgaW9fZXZlbnQJCWVudDsNCiAJc3RydWN0IHRpbWVv
dXQJCXRvOw0KIA0KLQkvKiBuZWVkZWQgdG8gemVybyBhbnkgcGFkZGluZyB3aXRoaW4gYW4gZW50
cnkgKHRoZXJlIHNob3VsZG4ndCBiZSANCi0JICogYW55LCBidXQgQyBpcyBmdW4hDQotCSAqLw0K
LQltZW1zZXQoJmVudCwgMCwgc2l6ZW9mKGVudCkpOw0KIAlyZXQgPSAwOw0KIA0KIAl3aGlsZSAo
bGlrZWx5KGkgPCBucikpIHsNCg==

------_=_NextPart_001_01C345A7.0FAF303D--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTGGVsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbTGGVsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:48:41 -0400
Received: from fmr02.intel.com ([192.55.52.25]:47071 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264505AbTGGVsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:48:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C344D3.6E569D7A"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Bug fix in AIO initialization
Date: Mon, 7 Jul 2003 15:02:17 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A4880@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Bug fix in AIO initialization
Thread-Index: AcNE02460dsj9EWNS+eSjIYjoI2rUw==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-aio@kvack.org>
X-OriginalArrivalTime: 07 Jul 2003 22:02:18.0129 (UTC) FILETIME=[6EA04010:01C344D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C344D3.6E569D7A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We hit this bug when we have the following scenario:

One process initializes an AIO context and then forks out many child
processes.  When those child processes exit, many BUG checks
(effectively kernel oops) were triggered from put_ioctx(ctx) in function
exit_aio().

The issue was that the AIO context was incorrectly copied upon forking
and mislead all child processes to think they have an IO context and
trying to free it where they really don't own.  The following patch fix
the issue.

- Ken

------_=_NextPart_001_01C344D3.6E569D7A
Content-Type: application/octet-stream;
	name="aio.init.patch"
Content-Transfer-Encoding: base64
Content-Description: aio.init.patch
Content-Disposition: attachment;
	filename="aio.init.patch"

LS0tIGxpbnV4LTIuNS43NC9rZXJuZWwvZm9yay5jCU1vbiBKdWwgIDcgMTQ6MzU6MDcgMjAwMw0K
KysrIGxpbnV4LTIuNS43NC5haW8va2VybmVsL2ZvcmsuYwlNb24gSnVsICA3IDE0OjM1OjA3IDIw
MDMNCkBAIC0zNzUsNiArMzc1LDcgQEANCiAJbW0tPmNvcmVfd2FpdGVycyA9IDA7DQogCW1tLT5w
YWdlX3RhYmxlX2xvY2sgPSBTUElOX0xPQ0tfVU5MT0NLRUQ7DQogCW1tLT5pb2N0eF9saXN0X2xv
Y2sgPSBSV19MT0NLX1VOTE9DS0VEOw0KKwltbS0+aW9jdHhfbGlzdCA9IE5VTEw7DQogCW1tLT5k
ZWZhdWx0X2tpb2N0eCA9IChzdHJ1Y3Qga2lvY3R4KUlOSVRfS0lPQ1RYKG1tLT5kZWZhdWx0X2tp
b2N0eCwgKm1tKTsNCiAJbW0tPmZyZWVfYXJlYV9jYWNoZSA9IFRBU0tfVU5NQVBQRURfQkFTRTsN
CiANCg==

------_=_NextPart_001_01C344D3.6E569D7A--

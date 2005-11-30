Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVK3CEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVK3CEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVK3CEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:04:23 -0500
Received: from fmr20.intel.com ([134.134.136.19]:14992 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750796AbVK3CEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:04:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5F552.60F28067"
Subject: [BUG] Variable stopmachine_state should be volatile
Date: Wed, 30 Nov 2005 10:04:20 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84040B3069@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Variable stopmachine_state should be volatile
Thread-Index: AcX1UmCCnLYg3sUwS86y9GzCyvwSKQ==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>
X-OriginalArrivalTime: 30 Nov 2005 02:04:21.0485 (UTC) FILETIME=[611581D0:01C5F552]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F552.60F28067
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The model to access variable stopmachine_state is that a main thread
writes it and other threads read it. Its declaration has no sign
volatile. In the while loop in function stopmachine, this variable is
read, and compiler might optimize it by reading it once before the loop
and not reading it again in the loop, so the thread might enter dead
loop.

Here is the patch to fix it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>



------_=_NextPart_001_01C5F552.60F28067
Content-Type: application/octet-stream;
	name="stopmachine_state_volatile_2.6.15_rc3.patch"
Content-Transfer-Encoding: base64
Content-Description: stopmachine_state_volatile_2.6.15_rc3.patch
Content-Disposition: attachment;
	filename="stopmachine_state_volatile_2.6.15_rc3.patch"

ZGlmZiAtTnJhdXAgbGludXgtMi42LjE1LXJjMy9rZXJuZWwvc3RvcF9tYWNoaW5lLmMgbGludXgt
Mi42LjE1LXJjM19maXgva2VybmVsL3N0b3BfbWFjaGluZS5jCi0tLSBsaW51eC0yLjYuMTUtcmMz
L2tlcm5lbC9zdG9wX21hY2hpbmUuYwkyMDA1LTExLTI5IDAwOjAyOjQ0LjAwMDAwMDAwMCArMDgw
MAorKysgbGludXgtMi42LjE1LXJjM19maXgva2VybmVsL3N0b3BfbWFjaGluZS5jCTIwMDUtMTEt
MjkgMDA6MDM6NDcuMDAwMDAwMDAwICswODAwCkBAIC0yMCw3ICsyMCw3IEBAIGVudW0gc3RvcG1h
Y2hpbmVfc3RhdGUgewogCVNUT1BNQUNISU5FX0VYSVQsCiB9OwogCi1zdGF0aWMgZW51bSBzdG9w
bWFjaGluZV9zdGF0ZSBzdG9wbWFjaGluZV9zdGF0ZTsKK3N0YXRpYyB2b2xhdGlsZSBlbnVtIHN0
b3BtYWNoaW5lX3N0YXRlIHN0b3BtYWNoaW5lX3N0YXRlOwogc3RhdGljIHVuc2lnbmVkIGludCBz
dG9wbWFjaGluZV9udW1fdGhyZWFkczsKIHN0YXRpYyBhdG9taWNfdCBzdG9wbWFjaGluZV90aHJl
YWRfYWNrOwogc3RhdGljIERFQ0xBUkVfTVVURVgoc3RvcG1hY2hpbmVfbXV0ZXgpOwo=

------_=_NextPart_001_01C5F552.60F28067--

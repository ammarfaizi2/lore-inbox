Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbULQDHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbULQDHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 22:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbULQDHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 22:07:32 -0500
Received: from fmr17.intel.com ([134.134.136.16]:33184 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262729AbULQDHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 22:07:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4E3E5.8308A4E2"
Subject: [Patch] Fix a race condition in pty.c
Date: Fri, 17 Dec 2004 11:07:15 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA24@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] Fix a race condition in pty.c
Thread-Index: AcTj5YIXKQBpYynRTsy+kzR1YlqvQA==
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Lu, Hongjiu" <hongjiu.lu@intel.com>
X-OriginalArrivalTime: 17 Dec 2004 03:07:16.0433 (UTC) FILETIME=[835FDC10:01C4E3E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4E3E5.8308A4E2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 <<pty_close-race-fix.patch>> There is a race condition int pty.c=20
when pty_close wakes up waiter on its pair device before set
TTY_OTHER_CLOSED flag.

It is possible on SMP or preempt kernel, waiter wakes up too early that
it will not get TTY_OTHER_CLOSED flag then fall into sleep again.

Lu hong jiu report this bug will hang some expect scripts on SMP
machines.

Signed-off-by:	Zou Nan hai <Nanhai.zou@intel.com>

Zou Nan hai


------_=_NextPart_001_01C4E3E5.8308A4E2
Content-Type: application/octet-stream;
	name="pty_close-race-fix.patch"
Content-Transfer-Encoding: base64
Content-Description: pty_close-race-fix.patch
Content-Disposition: attachment;
	filename="pty_close-race-fix.patch"

LS0tIGxpbnV4LTIuNi4xMC1yYzMtbW0xL2RyaXZlcnMvY2hhci9wdHkuYwkyMDA0LTEyLTE2IDAx
OjMyOjU2Ljc2MTg4Njg0OCAtMDUwMAorKysgYi9kcml2ZXJzL2NoYXIvcHR5LmMJMjAwNC0xMi0x
NiAwMTozMzozMi4yMTc5NDExMDEgLTA1MDAKQEAgLTU1LDkgKzU1LDkgQEAKIAlpZiAoIXR0eS0+
bGluaykKIAkJcmV0dXJuOwogCXR0eS0+bGluay0+cGFja2V0ID0gMDsKKwlzZXRfYml0KFRUWV9P
VEhFUl9DTE9TRUQsICZ0dHktPmxpbmstPmZsYWdzKTsKIAl3YWtlX3VwX2ludGVycnVwdGlibGUo
JnR0eS0+bGluay0+cmVhZF93YWl0KTsKIAl3YWtlX3VwX2ludGVycnVwdGlibGUoJnR0eS0+bGlu
ay0+d3JpdGVfd2FpdCk7Ci0Jc2V0X2JpdChUVFlfT1RIRVJfQ0xPU0VELCAmdHR5LT5saW5rLT5m
bGFncyk7CiAJaWYgKHR0eS0+ZHJpdmVyLT5zdWJ0eXBlID09IFBUWV9UWVBFX01BU1RFUikgewog
CQlzZXRfYml0KFRUWV9PVEhFUl9DTE9TRUQsICZ0dHktPmZsYWdzKTsKICNpZmRlZiBDT05GSUdf
VU5JWDk4X1BUWVMK

------_=_NextPart_001_01C4E3E5.8308A4E2--

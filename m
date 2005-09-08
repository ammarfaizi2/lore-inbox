Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVIHQEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVIHQEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVIHQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:04:29 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:1900
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964874AbVIHQE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:04:29 -0400
Message-Id: <43207D6A020000780002453B@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 18:05:30 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] adjust x86-64 HPET definitions
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part30125E5A.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part30125E5A.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Adjust, correct, and complete the HPET definitions for x86-64.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/asm-x86_64/hpet.h
2.6.13-x86_64-hpet/include/asm-x86_64/hpet.h
--- 2.6.13/include/asm-x86_64/hpet.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-hpet/include/asm-x86_64/hpet.h	2005-03-18
14:29:36.000000000 +0100
@@ -14,18 +14,18 @@
 #define HPET_CFG	0x010
 #define HPET_STATUS	0x020
 #define HPET_COUNTER	0x0f0
-#define HPET_T0_CFG	0x100
-#define HPET_T0_CMP	0x108
-#define HPET_T0_ROUTE	0x110
-#define HPET_T1_CFG	0x120
-#define HPET_T1_CMP	0x128
-#define HPET_T1_ROUTE	0x130
-#define HPET_T2_CFG	0x140
-#define HPET_T2_CMP	0x148
-#define HPET_T2_ROUTE	0x150
+#define HPET_Tn_OFFSET	0x20
+#define HPET_Tn_CFG(n)	 (0x100 + (n) * HPET_Tn_OFFSET)
+#define HPET_Tn_ROUTE(n) (0x104 + (n) * HPET_Tn_OFFSET)
+#define HPET_Tn_CMP(n)	 (0x108 + (n) * HPET_Tn_OFFSET)
+#define HPET_T0_CFG	HPET_Tn_CFG(0)
+#define HPET_T0_CMP	HPET_Tn_CMP(0)
+#define HPET_T1_CFG	HPET_Tn_CFG(1)
+#define HPET_T1_CMP	HPET_Tn_CMP(1)
 
 #define HPET_ID_VENDOR	0xffff0000
 #define HPET_ID_LEGSUP	0x00008000
+#define HPET_ID_64BIT	0x00002000
 #define HPET_ID_NUMBER	0x00001f00
 #define HPET_ID_REV	0x000000ff
 #define	HPET_ID_NUMBER_SHIFT	8
@@ -38,11 +38,18 @@
 #define	HPET_LEGACY_8254	2
 #define	HPET_LEGACY_RTC		8
 
-#define HPET_TN_ENABLE		0x004
-#define HPET_TN_PERIODIC	0x008
-#define HPET_TN_PERIODIC_CAP	0x010
-#define HPET_TN_SETVAL		0x040
-#define HPET_TN_32BIT		0x100
+#define HPET_TN_LEVEL		0x0002
+#define HPET_TN_ENABLE		0x0004
+#define HPET_TN_PERIODIC	0x0008
+#define HPET_TN_PERIODIC_CAP	0x0010
+#define HPET_TN_64BIT_CAP	0x0020
+#define HPET_TN_SETVAL		0x0040
+#define HPET_TN_32BIT		0x0100
+#define HPET_TN_ROUTE		0x3e00
+#define HPET_TN_FSB		0x4000
+#define HPET_TN_FSB_CAP		0x8000
+
+#define HPET_TN_ROUTE_SHIFT	9
 
 extern int is_hpet_enabled(void);
 extern int hpet_rtc_timer_init(void);


--=__Part30125E5A.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-hpet.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-hpet.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkFkanVzdCwgY29ycmVjdCwgYW5kIGNvbXBs
ZXRlIHRoZSBIUEVUIGRlZmluaXRpb25zIGZvciB4ODYtNjQuCgpTaWduZWQtb2ZmLWJ5OiBKYW4g
QmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUv
YXNtLXg4Nl82NC9ocGV0LmggMi42LjEzLXg4Nl82NC1ocGV0L2luY2x1ZGUvYXNtLXg4Nl82NC9o
cGV0LmgKLS0tIDIuNi4xMy9pbmNsdWRlL2FzbS14ODZfNjQvaHBldC5oCTIwMDUtMDgtMjkgMDE6
NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0LWhwZXQvaW5jbHVkZS9hc20t
eDg2XzY0L2hwZXQuaAkyMDA1LTAzLTE4IDE0OjI5OjM2LjAwMDAwMDAwMCArMDEwMApAQCAtMTQs
MTggKzE0LDE4IEBACiAjZGVmaW5lIEhQRVRfQ0ZHCTB4MDEwCiAjZGVmaW5lIEhQRVRfU1RBVFVT
CTB4MDIwCiAjZGVmaW5lIEhQRVRfQ09VTlRFUgkweDBmMAotI2RlZmluZSBIUEVUX1QwX0NGRwkw
eDEwMAotI2RlZmluZSBIUEVUX1QwX0NNUAkweDEwOAotI2RlZmluZSBIUEVUX1QwX1JPVVRFCTB4
MTEwCi0jZGVmaW5lIEhQRVRfVDFfQ0ZHCTB4MTIwCi0jZGVmaW5lIEhQRVRfVDFfQ01QCTB4MTI4
Ci0jZGVmaW5lIEhQRVRfVDFfUk9VVEUJMHgxMzAKLSNkZWZpbmUgSFBFVF9UMl9DRkcJMHgxNDAK
LSNkZWZpbmUgSFBFVF9UMl9DTVAJMHgxNDgKLSNkZWZpbmUgSFBFVF9UMl9ST1VURQkweDE1MAor
I2RlZmluZSBIUEVUX1RuX09GRlNFVAkweDIwCisjZGVmaW5lIEhQRVRfVG5fQ0ZHKG4pCSAoMHgx
MDAgKyAobikgKiBIUEVUX1RuX09GRlNFVCkKKyNkZWZpbmUgSFBFVF9Ubl9ST1VURShuKSAoMHgx
MDQgKyAobikgKiBIUEVUX1RuX09GRlNFVCkKKyNkZWZpbmUgSFBFVF9Ubl9DTVAobikJICgweDEw
OCArIChuKSAqIEhQRVRfVG5fT0ZGU0VUKQorI2RlZmluZSBIUEVUX1QwX0NGRwlIUEVUX1RuX0NG
RygwKQorI2RlZmluZSBIUEVUX1QwX0NNUAlIUEVUX1RuX0NNUCgwKQorI2RlZmluZSBIUEVUX1Qx
X0NGRwlIUEVUX1RuX0NGRygxKQorI2RlZmluZSBIUEVUX1QxX0NNUAlIUEVUX1RuX0NNUCgxKQog
CiAjZGVmaW5lIEhQRVRfSURfVkVORE9SCTB4ZmZmZjAwMDAKICNkZWZpbmUgSFBFVF9JRF9MRUdT
VVAJMHgwMDAwODAwMAorI2RlZmluZSBIUEVUX0lEXzY0QklUCTB4MDAwMDIwMDAKICNkZWZpbmUg
SFBFVF9JRF9OVU1CRVIJMHgwMDAwMWYwMAogI2RlZmluZSBIUEVUX0lEX1JFVgkweDAwMDAwMGZm
CiAjZGVmaW5lCUhQRVRfSURfTlVNQkVSX1NISUZUCTgKQEAgLTM4LDExICszOCwxOCBAQAogI2Rl
ZmluZQlIUEVUX0xFR0FDWV84MjU0CTIKICNkZWZpbmUJSFBFVF9MRUdBQ1lfUlRDCQk4CiAKLSNk
ZWZpbmUgSFBFVF9UTl9FTkFCTEUJCTB4MDA0Ci0jZGVmaW5lIEhQRVRfVE5fUEVSSU9ESUMJMHgw
MDgKLSNkZWZpbmUgSFBFVF9UTl9QRVJJT0RJQ19DQVAJMHgwMTAKLSNkZWZpbmUgSFBFVF9UTl9T
RVRWQUwJCTB4MDQwCi0jZGVmaW5lIEhQRVRfVE5fMzJCSVQJCTB4MTAwCisjZGVmaW5lIEhQRVRf
VE5fTEVWRUwJCTB4MDAwMgorI2RlZmluZSBIUEVUX1ROX0VOQUJMRQkJMHgwMDA0CisjZGVmaW5l
IEhQRVRfVE5fUEVSSU9ESUMJMHgwMDA4CisjZGVmaW5lIEhQRVRfVE5fUEVSSU9ESUNfQ0FQCTB4
MDAxMAorI2RlZmluZSBIUEVUX1ROXzY0QklUX0NBUAkweDAwMjAKKyNkZWZpbmUgSFBFVF9UTl9T
RVRWQUwJCTB4MDA0MAorI2RlZmluZSBIUEVUX1ROXzMyQklUCQkweDAxMDAKKyNkZWZpbmUgSFBF
VF9UTl9ST1VURQkJMHgzZTAwCisjZGVmaW5lIEhQRVRfVE5fRlNCCQkweDQwMDAKKyNkZWZpbmUg
SFBFVF9UTl9GU0JfQ0FQCQkweDgwMDAKKworI2RlZmluZSBIUEVUX1ROX1JPVVRFX1NISUZUCTkK
IAogZXh0ZXJuIGludCBpc19ocGV0X2VuYWJsZWQodm9pZCk7CiBleHRlcm4gaW50IGhwZXRfcnRj
X3RpbWVyX2luaXQodm9pZCk7Cg==

--=__Part30125E5A.1__=--

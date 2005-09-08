Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVIHPqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVIHPqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVIHPqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:46:35 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2665
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932605AbVIHPqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:46:34 -0400
Message-Id: <4320793602000078000244D9@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:47:34 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] re-export genapic on i386
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part50723E06.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part50723E06.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

A change not too long ago made i386's genapic symbol no longer be
exported,
and thus certain low-level functions no longer be usable. Since
close-to-
the-hardware code may still be modular, this rectifies the situation.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/mach-generic/probe.c
2.6.13-i386-genapic/arch/i386/mach-generic/probe.c
--- 2.6.13/arch/i386/mach-generic/probe.c	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-i386-genapic/arch/i386/mach-generic/probe.c	2005-09-05
14:31:31.000000000 +0200
@@ -3,6 +3,7 @@
  * 
  * Generic x86 APIC driver probe layer.
  */  
+#define APIC_DEFINITION 1
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
@@ -10,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <asm/fixmap.h>
 #include <asm/mpspec.h>
 #include <asm/apicdef.h>
@@ -21,6 +23,7 @@ extern struct genapic apic_es7000;
 extern struct genapic apic_default;
 
 struct genapic *genapic = &apic_default;
+EXPORT_SYMBOL(genapic);
 
 struct genapic *apic_probe[] __initdata = { 
 	&apic_summit,


--=__Part50723E06.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-genapic.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-genapic.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkEgY2hhbmdlIG5vdCB0b28gbG9uZyBhZ28g
bWFkZSBpMzg2J3MgZ2VuYXBpYyBzeW1ib2wgbm8gbG9uZ2VyIGJlIGV4cG9ydGVkLAphbmQgdGh1
cyBjZXJ0YWluIGxvdy1sZXZlbCBmdW5jdGlvbnMgbm8gbG9uZ2VyIGJlIHVzYWJsZS4gU2luY2Ug
Y2xvc2UtdG8tCnRoZS1oYXJkd2FyZSBjb2RlIG1heSBzdGlsbCBiZSBtb2R1bGFyLCB0aGlzIHJl
Y3RpZmllcyB0aGUgc2l0dWF0aW9uLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVs
aWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYvbWFjaC1nZW5lcmlj
L3Byb2JlLmMgMi42LjEzLWkzODYtZ2VuYXBpYy9hcmNoL2kzODYvbWFjaC1nZW5lcmljL3Byb2Jl
LmMKLS0tIDIuNi4xMy9hcmNoL2kzODYvbWFjaC1nZW5lcmljL3Byb2JlLmMJMjAwNS0wOC0yOSAw
MTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LWdlbmFwaWMvYXJjaC9pMzg2
L21hY2gtZ2VuZXJpYy9wcm9iZS5jCTIwMDUtMDktMDUgMTQ6MzE6MzEuMDAwMDAwMDAwICswMjAw
CkBAIC0zLDYgKzMsNyBAQAogICogCiAgKiBHZW5lcmljIHg4NiBBUElDIGRyaXZlciBwcm9iZSBs
YXllci4KICAqLyAgCisjZGVmaW5lIEFQSUNfREVGSU5JVElPTiAxCiAjaW5jbHVkZSA8bGludXgv
Y29uZmlnLmg+CiAjaW5jbHVkZSA8bGludXgvdGhyZWFkcy5oPgogI2luY2x1ZGUgPGxpbnV4L2Nw
dW1hc2suaD4KQEAgLTEwLDYgKzExLDcgQEAKICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KICNp
bmNsdWRlIDxsaW51eC9jdHlwZS5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxhc20vZml4bWFwLmg+CiAjaW5jbHVkZSA8YXNt
L21wc3BlYy5oPgogI2luY2x1ZGUgPGFzbS9hcGljZGVmLmg+CkBAIC0yMSw2ICsyMyw3IEBAIGV4
dGVybiBzdHJ1Y3QgZ2VuYXBpYyBhcGljX2VzNzAwMDsKIGV4dGVybiBzdHJ1Y3QgZ2VuYXBpYyBh
cGljX2RlZmF1bHQ7CiAKIHN0cnVjdCBnZW5hcGljICpnZW5hcGljID0gJmFwaWNfZGVmYXVsdDsK
K0VYUE9SVF9TWU1CT0woZ2VuYXBpYyk7CiAKIHN0cnVjdCBnZW5hcGljICphcGljX3Byb2JlW10g
X19pbml0ZGF0YSA9IHsgCiAJJmFwaWNfc3VtbWl0LAo=

--=__Part50723E06.0__=--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264317AbTH1Xmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTH1Xmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:42:35 -0400
Received: from fmr09.intel.com ([192.52.57.35]:48361 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264317AbTH1Xma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:42:30 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DBE.054C6484"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6-test4][1/6]Support for HPET based timer
Date: Thu, 28 Aug 2003 16:42:19 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D212@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6-test4][1/6]Support for HPET based timer
Thread-Index: AcNtvgU6LZLlF7EsRH6Fjjr2d0pjnQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 28 Aug 2003 23:42:20.0013 (UTC) FILETIME=[058211D0:01C36DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DBE.054C6484
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

1/6 - hpet1.patch - main.c change to introduce late_time_init()





diff -purN linux-2.6.0-test4/init/main.c =
linux-2.6.0-test4-hpet/init/main.c
--- linux-2.6.0-test4/init/main.c	2003-08-22 16:52:56.000000000 -0700
+++ linux-2.6.0-test4-hpet/init/main.c	2003-08-28 12:18:15.000000000 =
-0700
@@ -106,6 +106,8 @@ int system_running =3D 0;
 #define MAX_INIT_ENVS 8
=20
 extern void time_init(void);
+/* Default late time init is NULL. archs can override this later. */
+void (*late_time_init)(void) =3D NULL;
 extern void softirq_init(void);
=20
 int rows, cols;
@@ -421,7 +423,6 @@ asmlinkage void __init start_kernel(void
 	console_init();
 	profile_init();
 	local_irq_enable();
-	calibrate_delay();
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 			initrd_start < min_low_pfn << PAGE_SHIFT) {
@@ -433,6 +434,9 @@ asmlinkage void __init start_kernel(void
 	page_address_init();
 	mem_init();
 	kmem_cache_init();
+	if (late_time_init)
+		late_time_init();
+	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
 	pte_chain_init();






------_=_NextPart_001_01C36DBE.054C6484
Content-Type: application/octet-stream;
	name="hpet01.patch"
Content-Transfer-Encoding: base64
Content-Description: hpet01.patch
Content-Disposition: attachment;
	filename="hpet01.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0NC9pbml0L21haW4uYyBsaW51eC0yLjYuMC10ZXN0
NC1ocGV0L2luaXQvbWFpbi5jCi0tLSBsaW51eC0yLjYuMC10ZXN0NC9pbml0L21haW4uYwkyMDAz
LTA4LTIyIDE2OjUyOjU2LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDQtaHBl
dC9pbml0L21haW4uYwkyMDAzLTA4LTI4IDEyOjE4OjE1LjAwMDAwMDAwMCAtMDcwMApAQCAtMTA2
LDYgKzEwNiw4IEBAIGludCBzeXN0ZW1fcnVubmluZyA9IDA7CiAjZGVmaW5lIE1BWF9JTklUX0VO
VlMgOAogCiBleHRlcm4gdm9pZCB0aW1lX2luaXQodm9pZCk7CisvKiBEZWZhdWx0IGxhdGUgdGlt
ZSBpbml0IGlzIE5VTEwuIGFyY2hzIGNhbiBvdmVycmlkZSB0aGlzIGxhdGVyLiAqLwordm9pZCAo
KmxhdGVfdGltZV9pbml0KSh2b2lkKSA9IE5VTEw7CiBleHRlcm4gdm9pZCBzb2Z0aXJxX2luaXQo
dm9pZCk7CiAKIGludCByb3dzLCBjb2xzOwpAQCAtNDIxLDcgKzQyMyw2IEBAIGFzbWxpbmthZ2Ug
dm9pZCBfX2luaXQgc3RhcnRfa2VybmVsKHZvaWQKIAljb25zb2xlX2luaXQoKTsKIAlwcm9maWxl
X2luaXQoKTsKIAlsb2NhbF9pcnFfZW5hYmxlKCk7Ci0JY2FsaWJyYXRlX2RlbGF5KCk7CiAjaWZk
ZWYgQ09ORklHX0JMS19ERVZfSU5JVFJECiAJaWYgKGluaXRyZF9zdGFydCAmJiAhaW5pdHJkX2Jl
bG93X3N0YXJ0X29rICYmCiAJCQlpbml0cmRfc3RhcnQgPCBtaW5fbG93X3BmbiA8PCBQQUdFX1NI
SUZUKSB7CkBAIC00MzMsNiArNDM0LDkgQEAgYXNtbGlua2FnZSB2b2lkIF9faW5pdCBzdGFydF9r
ZXJuZWwodm9pZAogCXBhZ2VfYWRkcmVzc19pbml0KCk7CiAJbWVtX2luaXQoKTsKIAlrbWVtX2Nh
Y2hlX2luaXQoKTsKKwlpZiAobGF0ZV90aW1lX2luaXQpCisJCWxhdGVfdGltZV9pbml0KCk7CisJ
Y2FsaWJyYXRlX2RlbGF5KCk7CiAJcGlkbWFwX2luaXQoKTsKIAlwZ3RhYmxlX2NhY2hlX2luaXQo
KTsKIAlwdGVfY2hhaW5faW5pdCgpOwo=

------_=_NextPart_001_01C36DBE.054C6484--

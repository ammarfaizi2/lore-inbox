Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTHSTXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTHSTWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:22:02 -0400
Received: from fmr03.intel.com ([143.183.121.5]:11466 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261316AbTHSTUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:20:18 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36686.EB39C552"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6][4/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 12:20:15 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C6@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][4/5]Support for HPET based timer
Thread-Index: AcNmhuryMxpIVe6KTNOBIrrVeBHopA==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 19 Aug 2003 19:20:16.0033 (UTC) FILETIME=[EB916110:01C36686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36686.EB39C552
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

4/5 - hpet4.patch - Miscallaneous makefile and config changes





diff -purN linux-2.6.0-test1/arch/i386/Kconfig =
linux-2.6.0-test1-hpet/arch/i386/Kconfig
--- linux-2.6.0-test1/arch/i386/Kconfig	2003-07-13 20:30:48.000000000 =
-0700
+++ linux-2.6.0-test1-hpet/arch/i386/Kconfig	2003-08-18 =
19:49:55.000000000 -0700
@@ -408,6 +408,17 @@ config HUGETLB_PAGE
=20
 	  Otherwise, say N.
=20
+config HPET_TIMER
+	bool "HPET Timer Support"
+	help
+	  This enables HPET timer usage for kernel internal timer.
+	  HPET is the next generation timer replacing legacy 8254s.
+	  You can safely choose Y here. However, HPET will be
+	  activated, only if platform and the BIOS supports the feature.
+	  Otherwise, 8254 will be used for timing services.
+
+	  Choose N, to continue using legacy 8254 timer.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -purN linux-2.6.0-test1/arch/i386/kernel/Makefile =
linux-2.6.0-test1-hpet/arch/i386/kernel/Makefile
--- linux-2.6.0-test1/arch/i386/kernel/Makefile	2003-07-13 =
20:31:20.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/Makefile	2003-07-16 =
12:44:33.000000000 -0700
@@ -31,6 +31,7 @@ obj-$(CONFIG_EDD)             	+=3D edd.o
 obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
+obj-$(CONFIG_HPET_TIMER) 	+=3D time_hpet.o
=20
 EXTRA_AFLAGS   :=3D -traditional
=20
diff -purN linux-2.6.0-test1/arch/i386/kernel/timers/Makefile =
linux-2.6.0-test1-hpet/arch/i386/kernel/timers/Makefile
--- linux-2.6.0-test1/arch/i386/kernel/timers/Makefile	2003-07-13 =
20:28:54.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/timers/Makefile	2003-07-16 =
12:44:33.000000000 -0700
@@ -5,3 +5,4 @@
 obj-y :=3D timer.o timer_none.o timer_tsc.o timer_pit.o
=20
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+=3D timer_cyclone.o
+obj-$(CONFIG_HPET_TIMER)	+=3D timer_hpet.o



------_=_NextPart_001_01C36686.EB39C552
Content-Type: application/x-zip-compressed;
	name="hpet4.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet4.ZIP
Content-Disposition: attachment;
	filename="hpet4.ZIP"

UEsDBBQAAAAIALClEi+54kaivAIAAPYGAAALAAAAaHBldDQucGF0Y2ilU11vokAUfYZfcdPswzYI
gqClJE1qLbVm/Uq1SftERrjobEfGwGDrv98BtB+6Te0uD844c+659845N6JxDPoqT4fAaJK/6A2j
ZZi6wExYdZKGizq13Vb9V8iTmM4PMfpiheIQqOq6fgyh0jBNWzfPdMuGhunZpue4hrn7QN6Ypqpp
2tGJt4SubrlgnXvOuddsHhBeXoLumG6tBVqxWGcgT7Yd3t53/Wn/Khi3u74KKigAI7HA9JlmWIOM
bGBoyHNtBx/702DaG/h3qqbMOGdwUhzBlC4xhUm+WvFUnMi7BbKVXACmC5oBJmTGMCvDQZTYPCNz
hJin8IRpggxoIuSGsOreKINLvIyXFUGCLwLmmGBKBOXJlibFFSMhTaRWOCfhBtxG08mq6EeeQ0gS
2UWMbAPhgvMM4RFke2jALX/GNaa1KskzZQxmWMaRUNA1ERjVgCcykMYgkwhZ6xJIEpXVXPVGE8iq
fqv6YiQil8Qlxbs3LAra0cuuMSqbltUXRWeYrmmIRcFlXKeqcVgDwQuJhPRBEbXX4OsbqTsdJ4Ox
FK9SZLJZLlGkNIRlzgTVVymXKUqObKcQKNKyhUhyUaPjpqISqj4gTxhThl+bdC/gyynZw+9Pi+U1
zH+blk+JW2A1PMfxbPuvU2NbxdDI33Jk+Oy3/uNnZzS86XUD//r6FN5/inYBGEUGVz8CB6Pr+74/
OVUKwJJHOcMdZqMo5Wm2ybBwv8FhLfchYeyApt0Z94LJXXt6WmbK5BRIjPYB8zadFahwSVA8RcGm
gv8wvWsH7Zt+uzuRBXsXoIuURLQYJ8Ik4ns+KD2Yfd8Oe3HHumIvbM8cDddrOv9ljk/5v/BIs2aD
1qw50iFbVYuXrQaUV2uQ8ARf/4gsfN2v6FabDzo+uK2g89jpj4b+Vs6dmmkQbkJWsn2u/Rt4q/0f
UEsBAhQLFAAAAAgAsKUSL7niRqK8AgAA9gYAAAsAAAAAAAAAAQAgAAAAAAAAAGhwZXQ0LnBhdGNo
UEsFBgAAAAABAAEAOQAAAOUCAAAAAA==

------_=_NextPart_001_01C36686.EB39C552--

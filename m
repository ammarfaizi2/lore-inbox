Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbTH1XoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTH1XoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:44:20 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:8416 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S264435AbTH1XoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:44:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DBE.3F76039A"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6-test4][3/6]Support for HPET based timer
Date: Thu, 28 Aug 2003 16:43:57 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D214@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6-test4][3/6]Support for HPET based timer
Thread-Index: AcNtvj9h4SpUaCz1RT6yCjmGzc+LhA==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 28 Aug 2003 23:43:57.0699 (UTC) FILETIME=[3FBBC530:01C36DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DBE.3F76039A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

3/6 - hpet3.patch - Miscallaneous makefile and config changes



diff -purN linux-2.6.0-test4/arch/i386/Kconfig =
linux-2.6.0-test4-hpet/arch/i386/Kconfig
--- linux-2.6.0-test4/arch/i386/Kconfig	2003-08-22 16:52:28.000000000 =
-0700
+++ linux-2.6.0-test4-hpet/arch/i386/Kconfig	2003-08-28 =
12:18:15.000000000 -0700
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
diff -purN linux-2.6.0-test4/arch/i386/kernel/Makefile =
linux-2.6.0-test4-hpet/arch/i386/kernel/Makefile
--- linux-2.6.0-test4/arch/i386/kernel/Makefile	2003-08-22 =
16:52:57.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/Makefile	2003-08-28 =
12:18:15.000000000 -0700
@@ -31,6 +31,7 @@ obj-$(CONFIG_EDD)             	+=3D edd.o
 obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
+obj-$(CONFIG_HPET_TIMER) 	+=3D time_hpet.o
=20
 EXTRA_AFLAGS   :=3D -traditional
=20
diff -purN linux-2.6.0-test4/arch/i386/kernel/timers/Makefile =
linux-2.6.0-test4-hpet/arch/i386/kernel/timers/Makefile
--- linux-2.6.0-test4/arch/i386/kernel/timers/Makefile	2003-08-22 =
16:50:23.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/timers/Makefile	2003-08-28 =
12:18:15.000000000 -0700
@@ -5,3 +5,4 @@
 obj-y :=3D timer.o timer_none.o timer_tsc.o timer_pit.o
=20
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+=3D timer_cyclone.o
+obj-$(CONFIG_HPET_TIMER)	+=3D timer_hpet.o
diff -purN linux-2.6.0-test4/Documentation/kernel-parameters.txt =
linux-2.6.0-test4-hpet/Documentation/kernel-parameters.txt
--- linux-2.6.0-test4/Documentation/kernel-parameters.txt	2003-08-22 =
17:03:21.000000000 -0700
+++ linux-2.6.0-test4-hpet/Documentation/kernel-parameters.txt	=
2003-08-28 12:18:15.000000000 -0700
@@ -215,7 +215,10 @@ running once the system is up.
 			when calculating gettimeofday(). If specicified timesource
 			is not avalible, it defaults to PIT.=20
 			Format: { pit | tsc | cyclone | ... }
-		=09
+
+	hpet=3D		[IA-32,HPET] option to disable HPET and use PIT.
+			Format: disable
+
 	cm206=3D		[HW,CD]
 			Format: { auto | [<io>,][<irq>] }
=20



------_=_NextPart_001_01C36DBE.3F76039A
Content-Type: application/x-zip-compressed;
	name="hpet03.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet03.ZIP
Content-Disposition: attachment;
	filename="hpet03.ZIP"

UEsDBBQAAAAIANZsHC/O5h4JtAMAAIsJAAAMAAAAaHBldDAzLnBhdGNopVVtb9pIEP5s/4pRdR8a
YTvGBILQpSoFkqBLAAWqa1RFaGOPYa/G6/OuSdH1/vvNriFpQBzkjg/exX7mZfd5ZibicQxuVuQD
SHhafHcDr+H5rkKpzk5ZHs5Pea3ZOP0tFGnMZ7sYd56h2gXaruse49AKfL/m+k03CKDaaNWDVtD0
/M0PXP/c9+1KpXJ04BeHTagGrWqzVa3vOPz4Edwzv+k0oKKX6jnQm/UJrz9f9SY3n6aj9lXPBhss
gKGaY/7EJTog2QoGHr2vbOCj3mQ66d/27uyK9ShEAu/0K5jwBeYwLrJM5OodfZtjktECMJlzCZiy
xwSlMQdlsIVkM4RY5PAN8xQT4KmiDUvK754xNniyp4wgxe8KZphizhQX6dpNjlnCQp4SVzhj4Qqa
Qf1Mltb3ooCQpXSKGJMVhHMhJMI90PHQg2vxhEvMnTLIE08SeERjx0LFl0xh5IBIyZDHQEEU5boA
lkYmm0/94Rhked4yvxiZKsixcfHTHeqENu7p1BiZQ1P2OmmJ+ZKHqBM2dp0yx4EDSmiKFOlAW20d
8PmO7A2P49sRkVcyMl4tFqhyHsKiSBR3s1xQCONDbhgCiySrSaLFjo6ripKo01v2DWOe4GGRbhkc
rJIt/G611M//W7XsdXygampVXTT0NCUjHv9wf3nfGQ4u+1fTXrd7Aj//rMoFYBR5wn4NvB12P9/0
xieWBixEVCS4wawsy7yVK4la/Z6AJe1DliQ7btqdUX86vmtPTkwkSVVAmMorzEt1liCtkqm+Cu3N
ht6XyV172r68aV+NKeHWBbgqZxHX5cQSQrxNB0aD8u1y2LI7VhVbZtvi8FtB7X+JY6//AxqpOzWo
1J0zUsiaVX2zZYGKcp2mIsXnP0qGz/uMr7l5xeOXZmPaue/cDAe9NZ0bNvNpuAoT420/9y/gNff/
ymtXhMWC5Ge66voy3IzljHoIXYinqO3uucMjTPewe4TlK4LPW36tFVTfQvCbQhzgOKjWqQVU9FL1
dSvIizTV/VSkIZruT2WrcKFnVZHRwKS6fppjSuMnCQuaHRo7Q6VZEXHEVu9PPOjHIDMMechjTlNB
f5OiyEM05uQpFQrYkiWcZqcDXEGEMaOOLvVwGPUnHhjkJc0lplrwF5Ca4AeQvui51gntPM+Dv22X
kGbI6Mu5sKyv/bZbCxwtmwcQWTlSBURc6lFdDkU97GhimVhk+RJqjdLzxwoXgd/QDq9/dzrdh62U
WEFOf8DXX7n44DzQkv/54YHSAfsfUEsBAhQLFAAAAAgA1mwcL87mHgm0AwAAiwkAAAwAAAAAAAAA
AQAgAAAAAAAAAGhwZXQwMy5wYXRjaFBLBQYAAAAAAQABADoAAADeAwAAAAA=

------_=_NextPart_001_01C36DBE.3F76039A--

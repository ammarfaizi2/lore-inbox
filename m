Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTH1Xny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264435AbTH1Xny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:43:54 -0400
Received: from fmr09.intel.com ([192.52.57.35]:8939 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264459AbTH1Xnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:43:50 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DBE.36046346"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6-test4][2/6]Support for HPET based timer
Date: Thu, 28 Aug 2003 16:43:41 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D213@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6-test4][2/6]Support for HPET based timer
Thread-Index: AcNtvjXxnLMCvbIESRqalANx/Fp2TQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 28 Aug 2003 23:43:42.0672 (UTC) FILETIME=[36C6D500:01C36DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DBE.36046346
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

2/6 - hpet2.patch - acpi boot time parsing changes to look for HPET



diff -purN linux-2.6.0-test4/arch/i386/kernel/acpi/boot.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/acpi/boot.c
--- linux-2.6.0-test4/arch/i386/kernel/acpi/boot.c	2003-08-22 =
16:59:02.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/acpi/boot.c	2003-08-28 =
12:18:15.000000000 -0700
@@ -269,6 +269,27 @@ acpi_scan_rsdp (
 	return 0;
 }
=20
+#ifdef CONFIG_HPET_TIMER
+extern unsigned long hpet_address;
+
+static int __init acpi_parse_hpet(unsigned long phys, unsigned long =
size)
+{
+	struct acpi_table_hpet *hpet_tbl;
+
+	hpet_tbl =3D __va(phys);
+
+	if (hpet_tbl->addr.space_id !=3D ACPI_SPACE_MEM) {
+		printk(KERN_WARNING PREFIX "HPET timers must be located in "
+		       "memory.\n");
+		return -1;
+	}
+
+	hpet_address =3D hpet_tbl->addr.addrl;
+	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n", hpet_tbl->id,=20
+	       hpet_address);
+	return 0;
+}
+#endif
=20
 unsigned long __init
 acpi_find_rsdp (void)
@@ -458,6 +479,9 @@ acpi_boot_init (void)
 		clustered_apic_check();
 	}
 #endif
+#ifdef CONFIG_HPET_TIMER
+	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
+#endif
=20
 	return 0;
 }



------_=_NextPart_001_01C36DBE.36046346
Content-Type: application/x-zip-compressed;
	name="hpet02.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet02.ZIP
Content-Disposition: attachment;
	filename="hpet02.ZIP"

UEsDBBQAAAAIAGFkHC98UoLXHAIAAEUEAAAMAAAAaHBldDAyLnBhdGNonZJdb9owFIavk19xBpoU
FhxCynfVqRUKHZpIEau0XUyyTOwUi2Ai21R0U//7bALjo1KlzRdJHNvv+/icl/IsA1RsZAI5F5st
ioJOECLNlG41iEwXDX7V6zSWTAqWN0ha8MZ8vdZB+nY7WhRMv3vGRQj9o40TheEVCnsoiqDZGbT7
gzAKwsMAFHbD0PV9/39wjto9aEaDZm/QbL/Rvr0FFHX69Q749hV1wfyxIlilRGCpaAGeC45keiMF
hNcuvLrg+lWeUZbB8CEZje/xl2n8iB/Hk3jm+myrDQpshOJPglHI1+IJLCwmlEqm1LXru77SRPMU
uNCAMRdcl6YFkYphu9s7FygWL6p+Iar4L1Zz/d+u7ygtN+leQ5N5XmrAp52vnuc7T+cwgxtj+kw8
K1orl3gG3mEZfbakgSpIyjCn8OEG7obTMf42vRvGeBJPamA9nUIa/KX3NZ4l+PvdLBkn9zCdxaPx
D6jYioDmKyYVrDZKw5wZ6JRoA88FVOx5KEdlxVZr+RL8FBUL4xxqjZp29nok39fP0F+Q2oe94hnR
OBk9nONwOoCP1S3MiWL2K98ay/qJGKd109oD16nnDuyYAd9QVZmgPDNZuOhK2U637EXGBd2H6HnN
aW2Xt1a7Z/PW6vbr/b9xs5ktg7DfCY6T5qZyTDKKScFTnC5YuvQMCpiqwN7/nSQ6J3HYBcvbtdFu
qV/GzV7weKPzuP8BUEsBAhQLFAAAAAgAYWQcL3xSgtccAgAARQQAAAwAAAAAAAAAAQAgAAAAAAAA
AGhwZXQwMi5wYXRjaFBLBQYAAAAAAQABADoAAABGAgAAAAA=

------_=_NextPart_001_01C36DBE.36046346--

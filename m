Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTHTBTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTHTBTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:19:45 -0400
Received: from fmr09.intel.com ([192.52.57.35]:24054 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261686AbTHTBTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:19:42 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C366B9.146B28CA"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6][1/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 18:19:19 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CC@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][1/5]Support for HPET based timer
Thread-Index: AcNmuRQ/ohCM40hwTsyXvRoaQmgRhA==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 20 Aug 2003 01:19:19.0734 (UTC) FILETIME=[149D4560:01C366B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C366B9.146B28CA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Resend - The original mail hasn't yet appeared on lkml, even 5 hours=20
after posting]

diff -purN linux-2.6.0-test1/arch/i386/kernel/acpi/boot.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/acpi/boot.c
--- linux-2.6.0-test1/arch/i386/kernel/acpi/boot.c	2003-07-13 =
20:37:31.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/acpi/boot.c	2003-08-18 =
19:54:47.000000000 -0700
@@ -289,6 +289,27 @@ acpi_find_rsdp (void)
 	return rsdp_phys;
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
+		printk(KERN_WARNING "acpi: HPET timers must be located in "
+		       "memory.\n");
+		return -1;
+	}
+
+	hpet_address =3D hpet_tbl->addr.addrl;
+	printk(KERN_INFO "acpi: HPET id: %#x base: %#lx\n", hpet_tbl->id,=20
+	       hpet_address);
+	return 0;
+}
+#endif
=20
 int __init
 acpi_boot_init (void)
@@ -426,6 +447,12 @@ acpi_boot_init (void)
 		clustered_apic_check();
 	}
 #endif
+#ifdef CONFIG_HPET_TIMER
+	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
+	if (hpet_address =3D=3D 0) {
+		printk("ACPI: no HPET table found\n");
+	}
+#endif
=20
 	return 0;
 }



------_=_NextPart_001_01C366B9.146B28CA
Content-Type: application/x-zip-compressed;
	name="hpet1.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet1.ZIP
Content-Disposition: attachment;
	filename="hpet1.ZIP"

UEsDBBQAAAAIAOWjEi/esubANQIAAJAEAAALAAAAaHBldDEucGF0Y2idk11v2jAYha+TX/EONCks
GJLAgGZiKkK0QxMUsUq7mWSF2CkWwYlsp6Kd+t9nk8D4kCptuYAkds55ct4TwpIEUF6IOaSMFzsU
tHotDykqld+ORLxus86g195QwWnajuKctVdZplrx9Xa0zql69xkbIfSPNlbgeR3k9ZHfgcALO/2w
47e8wwF6xfNs13X/B6fSHiB/AP5N+LkbdvtX2re3gILBTbMHrvkL+qDvGBGcME6wkCQH5zljpGGD
JagqBAdzE+frF/nFhjcbbLfOEkITGD/M76b3+Nti8ogfp7PJ0nbpTmkuKLhkT5wSSDP+BIYcR4QI
KrWEa7tSRYrFwLgCjBlnqiTIIyEpNrudcwHj3bwQleyVNmz3t+1aUokirjRUtEpLDfi091WrdO9p
Ha5gqE2fI8eINsolloBzWEZfDWlL5lFMMSPwYQij8WKKfyxG4wmeTWYNMJ5WLjT+xvk+Wc7xz9Fy
Pp3fQ80ghGACAcW2VEjYFlLBimrmOFKanXGomcehPGpbus3ES+sXrxkW6xA58s3V21/wKj4NfwFq
fswbngFN53cPZzSMhPCxvoNVJKk5S3fasXmixUhTD/aAdWq556qwPH2uoeqUE5boJpyM0C7zN1Us
R1q1yBSuG/RM4brdftMPjoW72gqWFac6LyoowVHOYhyvabxxNAHoLKCyfad+1kkH9m1y9rMzW5qX
Hdu/13Hyx3yH4J1PuGYkQuBZNVcjDklWcHIY2lkiJ1Hpj+UPUEsBAhQLFAAAAAgA5aMSL96y5sA1
AgAAkAQAAAsAAAAAAAAAAQAgAAAAAAAAAGhwZXQxLnBhdGNoUEsFBgAAAAABAAEAOQAAAF4CAAAA
AA==

------_=_NextPart_001_01C366B9.146B28CA--

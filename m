Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUEQM70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUEQM70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUEQM70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:59:26 -0400
Received: from panda.sul.com.br ([200.219.150.4]:38157 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S261206AbUEQM7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:59:24 -0400
Date: Mon, 17 May 2004 09:57:05 -0300
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
Message-ID: <20040517125705.GA23455@cathedrallabs.org>
References: <20040516025514.3fe93f0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +hpet-driver.patch
>=20
>  HPET clock driver (needs work)
this doesn't compiles if ACPI isn't present. patch attached.

--=20
Aristeu


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hpet-acpi.patch"
Content-Transfer-Encoding: quoted-printable

diff -uprN -X dontdiff 2.6-mm-clean/drivers/char/hpet.c 2.6-mm/drivers/char=
/hpet.c
--- 2.6-mm-clean/drivers/char/hpet.c	2004-05-17 09:38:03.000000000 -0300
+++ 2.6-mm/drivers/char/hpet.c	2004-05-17 09:23:04.000000000 -0300
@@ -976,6 +976,7 @@ hpet_alloc (struct hpet_data *hdp)
 	return 0;
 }
=20
+#ifdef ACPI
 static acpi_status __init
 hpet_resources (struct acpi_resource *res, void *data)
 {
@@ -1056,7 +1057,10 @@ static struct acpi_driver hpet_acpi_driv
 		.remove	=3D	hpet_acpi_remove,
 	},
 };
-
+#else	/* ACPI */
+#define acpi_bus_register_driver(x) do {} while(0)=20
+#define acpi_bus_unregister_driver(x) do {} while(0)
+#endif	/* ACPI */
=20
=20
 static int __init
@@ -1067,7 +1071,7 @@ hpet_init (void)
 	if (hpets)
 		hpet_post_platform();
=20
-	(void) acpi_bus_register_driver(&hpet_acpi_driver);
+	acpi_bus_register_driver(&hpet_acpi_driver);
=20
 	if (hpets) {
 		entry =3D create_proc_entry("driver/hpet", 0, 0);

--ADZbWkCsHQ7r3kzd--

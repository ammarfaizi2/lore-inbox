Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbTIAMYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 08:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTIAMYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 08:24:35 -0400
Received: from relay.rost.ru ([217.107.128.164]:50633 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262832AbTIAMYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 08:24:24 -0400
Date: Mon, 1 Sep 2003 16:24:15 +0400
To: jes@trained-monkey.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add config option for qla1280 SCSI MMIO/ioport selection
Message-ID: <20030901122415.GB23771@pazke>
Mail-Followup-To: jes@trained-monkey.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: multipart/mixed; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

attached patch adds config option which allows ioport/mmio
selection for QLA1280 SCSI driver.

With this patch applied QLA1280 can be used on Visws again.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-qla1280-mmio
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.6.0-test3.vanilla/drivers/scsi/Kco=
nfig linux-2.6.0-test3/drivers/scsi/Kconfig
--- linux-2.6.0-test3.vanilla/drivers/scsi/Kconfig	Sat Aug  9 08:40:56 2003
+++ linux-2.6.0-test3/drivers/scsi/Kconfig	Mon Sep  1 20:58:04 2003
@@ -1298,6 +1298,16 @@
 	  The module will be called qla1280. If you want to compile it as
 	  a module, say M here and read <file:Documentation/modules.txt>.
=20
+config SCSI_QLOGIC_1280_PIO
+	bool "Use PIO instead of MMIO" if !X86_VISWS
+	depends on SCSI_QLOGIC_1280
+	default y if X86_VISWS
+	help
+	  This instructs the driver to use programmed I/O ports (PIO) instead
+	  of PCI shared memory (MMIO).  This can possibly solve some problems
+	  in case your mainboard has memory consistency issues.  If unsure,
+	  say N.
+
 config SCSI_QLOGICPTI
 	tristate "PTI Qlogic, ISP Driver"
 	depends on SBUS && SCSI
diff -urN -X /usr/share/dontdiff linux-2.6.0-test3.vanilla/drivers/scsi/qla=
1280.c linux-2.6.0-test3/drivers/scsi/qla1280.c
--- linux-2.6.0-test3.vanilla/drivers/scsi/qla1280.c	Mon Sep  1 21:50:04 20=
03
+++ linux-2.6.0-test3/drivers/scsi/qla1280.c	Mon Sep  1 21:21:33 2003
@@ -331,11 +331,17 @@
  */
 #define  QL1280_LUN_SUPPORT	0
 #define  WATCHDOGTIMER		0
-#define  MEMORY_MAPPED_IO	1
+
 #define  DEBUG_QLA1280_INTR	0
 #define  DEBUG_PRINT_NVRAM	0
 #define  DEBUG_QLA1280		0
=20
+#ifdef	CONFIG_SCSI_QLOGIC_1280_PIO
+#define	MEMORY_MAPPED_IO	0
+#else
+#define	MEMORY_MAPPED_IO	1
+#endif
+
 #define UNIQUE_FW_NAME
 #include "qla1280.h"
 #include "ql12160_fw.h"		/* ISP RISC codes */

--MfFXiAuoTsnnDAfZ--

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE/Uzpvby9O0+A2ZecRAiQxAJYqS829gmY7OimqoeO3OvqNJCJZAKCgx05p
ExdEvJp9zLmabkpxLV5sxA==
=+QD+
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

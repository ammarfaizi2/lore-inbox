Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUECSiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUECSiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUECSiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:38:15 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:53121 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S263845AbUECSiH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:38:07 -0400
Message-Id: <200405031836.i43IaoXc002664@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Harald Arnesen <harald@skogtun.org>, len.brown@intel.com,
       luming.yu@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.6-rc3-mm1: modular ACPI button broken 
In-Reply-To: Your message of "Sat, 01 May 2004 13:44:21 +0200."
             <20040501114420.GF2541@fs.tum.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040430014658.112a6181.akpm@osdl.org> <87ad0sshku.fsf@basilikum.skogtun.org>
            <20040501114420.GF2541@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1384125462P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 May 2004 14:36:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1384125462P
Content-Type: text/plain; charset=us-ascii

On Sat, 01 May 2004 13:44:21 +0200, Adrian Bunk said:

> This seems to be introduced by the button driver unload unload patch 
> (Bugzilla #2281) included in the ACPI BK patch.
> 
> It seems two EXPORT_SYMBOL's are missing in scan.c?

And a needed #include, as well (found that out the hard way).  Here's
the "works for me" patch...

--- linux-2.6.6-rc3-mm1/drivers/acpi/scan.c.modules	2004-04-30 21:45:27.348492000 -0400
+++ linux-2.6.6-rc3-mm1/drivers/acpi/scan.c	2004-04-30 23:26:24.994263676 -0400
@@ -4,6 +4,7 @@
 
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/module.h>
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
@@ -16,7 +17,9 @@ ACPI_MODULE_NAME		("scan")
 
 extern struct acpi_device		*acpi_root;
 struct acpi_device 		*acpi_fixed_pwr_button;
+EXPORT_SYMBOL(acpi_fixed_pwr_button);
 struct acpi_device 		*acpi_fixed_sleep_button;
+EXPORT_SYMBOL(acpi_fixed_sleep_button);
 
 
 #define ACPI_BUS_CLASS			"system_bus"


--==_Exmh_1384125462P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAlpFCcC3lWbTT17ARAjO7AKDSMHdBYhr3rO9BsY/CtfEHjQsxsQCdHtpL
W5+TAaN9aaF/VroxzC6HeXw=
=PhST
-----END PGP SIGNATURE-----

--==_Exmh_1384125462P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUFVRIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUFVRIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUFVRHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:07:33 -0400
Received: from linux.us.dell.com ([143.166.224.162]:42379 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264922AbUFVQ6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:58:12 -0400
Date: Tue, 22 Jun 2004 11:58:08 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH 2.4: edd.c display %u, remove REPORT_URL
Message-ID: <20040622165808.GA25586@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marcelo,

Patch against 2.4.27-rc1.  This removes the REPORT_URL string and
message telling people to send me their BIOS info.  I've got a huge
number of reports, and virtually all show that EDD 3.0 is not
supported, or if supported, is likely implemented in ways contrary to
the spec.  In 2.7.x I may bring the REPORT_URL back once I've got a
better way to track the data being sent to me.

Also, this now reports the EDD geometry (if known) and number of
sectors using %u instead of %x, to be consistent with what is in 2.6.7
now.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


=3D=3D=3D=3D=3D arch/i386/kernel/edd.c 1.3 vs edited =3D=3D=3D=3D=3D
--- 1.3/arch/i386/kernel/edd.c	2003-12-05 12:46:25 -06:00
+++ edited/arch/i386/kernel/edd.c	2004-06-21 15:41:01 -05:00
@@ -46,9 +46,8 @@
 MODULE_DESCRIPTION("proc interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
=20
-#define EDD_VERSION "0.10 2003-Dec-05"
+#define EDD_VERSION "0.11 2004-Jun-21"
 #define EDD_DEVICE_NAME_SIZE 16
-#define REPORT_URL "http://domsch.com/linux/edd30/results.html"
=20
 #define left (count - (p - page) - 1)
=20
@@ -312,10 +311,6 @@
 	}
=20
 out:
-	p +=3D snprintf(p, left, "\nPlease check %s\n", REPORT_URL);
-	p +=3D snprintf(p, left, "to see if this device has been reported.  If no=
t,\n");
-	p +=3D snprintf(p, left, "please send the information requested there.\n"=
);
-
 	return proc_calc_metrics(page, start, off, count, eof, (p - page));
 }
=20
@@ -405,7 +400,7 @@
 		return proc_calc_metrics(page, start, off, count, eof, 0);
 	}
=20
-	p +=3D snprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
+	p +=3D snprintf(p, left, "%u\n", info->params.num_default_cylinders);
 	return proc_calc_metrics(page, start, off, count, eof, (p - page));
 }
=20
@@ -418,7 +413,7 @@
 		return proc_calc_metrics(page, start, off, count, eof, 0);
 	}
=20
-	p +=3D snprintf(p, left, "0x%x\n", info->params.num_default_heads);
+	p +=3D snprintf(p, left, "%u\n", info->params.num_default_heads);
 	return proc_calc_metrics(page, start, off, count, eof, (p - page));
 }
=20
@@ -431,7 +426,7 @@
 		return proc_calc_metrics(page, start, off, count, eof, 0);
 	}
=20
-	p +=3D snprintf(p, left, "0x%x\n", info->params.sectors_per_track);
+	p +=3D snprintf(p, left, "%u\n", info->params.sectors_per_track);
 	return proc_calc_metrics(page, start, off, count, eof, (p - page));
 }
=20
@@ -444,7 +439,7 @@
 		return proc_calc_metrics(page, start, off, count, eof, 0);
 	}
=20
-	p +=3D snprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
+	p +=3D snprintf(p, left, "%llu\n", info->params.number_of_sectors);
 	return proc_calc_metrics(page, start, off, count, eof, (p - page));
 }
=20

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2GUgIavu95Lw/AkRAgpzAJ9YfCTJJ9AdejAA6t7OFuH8jeRRsACfSeO+
7YB1/qgngLsByfio3phPTgI=
=HrZ8
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

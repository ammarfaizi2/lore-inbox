Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTBUMvp>; Fri, 21 Feb 2003 07:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBUMvp>; Fri, 21 Feb 2003 07:51:45 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:37579 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267425AbTBUMvn>; Fri, 21 Feb 2003 07:51:43 -0500
Message-Id: <200302211301.h1LD1jZ05730@rumms.uni-mannheim.de>
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] add some missing gloabl_flush_tlb() calls
Date: Fri, 21 Feb 2003 13:58:58 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_TKiV+Ny/J8k7qdc";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_TKiV+Ny/J8k7qdc
Content-Type: multipart/mixed;
  boundary="Boundary-01=_SKiV+0051hNYPu/"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_SKiV+0051hNYPu/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: body text
Content-Disposition: inline

I found some places where change_page_attr() is called without the corresponding global_flush_tlb(). This patch should fix it...

  Thomas Schlichter

P.S.: I hope this fix is correct at the first try...
--Boundary-01=_SKiV+0051hNYPu/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="missing_global_flush_tlb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="missing_global_flush_tlb.patch"

=2D-- linux-2.5.62/arch/i386/mm/ioremap.c.orig	Fri Feb 21 12:26:36 2003
+++ linux-2.5.62/arch/i386/mm/ioremap.c	Fri Feb 21 12:28:44 2003
@@ -205,6 +205,7 @@
 			iounmap(p);=20
 			p =3D NULL;
 		}
+		global_flush_tlb();
 	}=20
=20
 	return p;				=09
@@ -226,6 +227,7 @@
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				=20
+		global_flush_tlb();
 	}=20
 	kfree(p);=20
 }
=2D-- linux-2.5.62/arch/x86_64/mm/ioremap.c.orig	Fri Feb 21 12:25:54 2003
+++ linux-2.5.62/arch/x86_64/mm/ioremap.c	Fri Feb 21 12:27:58 2003
@@ -205,6 +205,7 @@
 			iounmap(p);=20
 			p =3D NULL;
 		}
+		global_flush_tlb();
 	}=20
=20
 	return p;				=09
@@ -226,6 +227,7 @@
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				=20
+		global_flush_tlb();
 	}=20
 	kfree(p);=20
 }
=2D-- linux-2.5.62/arch/x86_64/kernel/pci-gart.c.orig	Fri Feb 21 12:39:40 2=
003
+++ linux-2.5.62/arch/x86_64/kernel/pci-gart.c	Fri Feb 21 12:43:13 2003
@@ -437,6 +437,7 @@
 	}
 	flush_gart();=20
 =09
+	global_flush_tlb();
 	=09
 	printk("PCI-DMA: aperture base @ %x size %u KB\n", aper_base, aper_size>>=
10);=20
 	return 0;

--Boundary-01=_SKiV+0051hNYPu/--

--Boundary-03=_TKiV+Ny/J8k7qdc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ViKTYAiN+WRIZzQRAiSTAKDBT/iY0temEjipahbcpFkkzYSoXQCgyuI/
/vkJQkpqqmCw6oxbYR/PZ4w=
=Cra3
-----END PGP SIGNATURE-----

--Boundary-03=_TKiV+Ny/J8k7qdc--


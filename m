Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268711AbTBZLHZ>; Wed, 26 Feb 2003 06:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbTBZLHZ>; Wed, 26 Feb 2003 06:07:25 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:51342 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268711AbTBZLHX>; Wed, 26 Feb 2003 06:07:23 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] add missing global_flush_tlb() after change_page_attr() calls
Date: Wed, 26 Feb 2003 12:17:28 +0100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_JJKX+y6njy07/g7";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302261217.29084.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_JJKX+y6njy07/g7
Content-Type: multipart/mixed;
  boundary="Boundary-01=_IJKX+BYuUvEQJWO"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_IJKX+BYuUvEQJWO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

After calling change_page_attr() global_flush_tlb() has to be called to=20
kfree() some structures and make the changed page attributes visible by=20
flushing the relevant TLB entries.

This is not done in some places and this patch should fix it...

   Thomas Schlichter

P.S.: I sent this patch on friday yet, but I think friday is a bad day for=
=20
sending patches... ;-)
--Boundary-01=_IJKX+BYuUvEQJWO
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

--Boundary-01=_IJKX+BYuUvEQJWO--

--Boundary-03=_JJKX+y6njy07/g7
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+XKJJYAiN+WRIZzQRAoNhAKDN7xGjX1/YLUeAN5Mspjf2yVhsWwCgoR/e
S5SBVcFP+7POG74JvmmQels=
=72HX
-----END PGP SIGNATURE-----

--Boundary-03=_JJKX+y6njy07/g7--


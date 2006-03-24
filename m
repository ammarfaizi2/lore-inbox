Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWCZXDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWCZXDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWCZXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:03:25 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:46734 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932164AbWCZXDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:03:20 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix x86_64 compilation breakage caused by 92c05fc1a32e5ccef5e0e8201f32dcdab041524c
Date: Fri, 24 Mar 2006 19:52:43 +1000
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1193231.Ix4SUjcpzU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603241952.50754.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1193231.Ix4SUjcpzU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

This patch fixes x86_64 compilation, which was broken by git patch
92c05fc1a32e5ccef5e0e8201f32dcdab041524c. It makes the same
sorts of changes that were made for the i386 version in that patch.

Please apply.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 mmconfig.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)
diff -ruNp 9906.patch-old/arch/x86_64/pci/mmconfig.c 9906.patch-new/arch/x8=
6_64/pci/mmconfig.c
=2D-- 9906.patch-old/arch/x86_64/pci/mmconfig.c	2006-03-24 12:11:33.0000000=
00 +1000
+++ 9906.patch-new/arch/x86_64/pci/mmconfig.c	2006-03-24 16:13:24.000000000=
 +1000
@@ -148,24 +148,24 @@ static __init void unreachable_devices(v
 	}
 }
=20
=2Dstatic int __init pci_mmcfg_init(void)
+void __init pci_mmcfg_init(void)
 {
 	int i;
=20
 	if ((pci_probe & PCI_PROBE_MMCONF) =3D=3D 0)
=2D		return 0;
+		return;
=20
 	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
 	if ((pci_mmcfg_config_num =3D=3D 0) ||
 	    (pci_mmcfg_config =3D=3D NULL) ||
 	    (pci_mmcfg_config[0].base_address =3D=3D 0))
=2D		return 0;
+		return;
=20
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt =3D kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num=
, GFP_KERNEL);
 	if (pci_mmcfg_virt =3D=3D NULL) {
 		printk("PCI: Can not allocate memory for mmconfig structures\n");
=2D		return 0;
+		return;
 	}
 	for (i =3D 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg =3D &pci_mmcfg_config[i];
@@ -173,7 +173,7 @@ static int __init pci_mmcfg_init(void)
 		if (!pci_mmcfg_virt[i].virt) {
 			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
=2D			return 0;
+			return;
 		}
 		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base=
_address);
 	}
@@ -182,8 +182,4 @@ static int __init pci_mmcfg_init(void)
=20
 	raw_pci_ops =3D &pci_mmcfg;
 	pci_probe =3D (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
=2D
=2D	return 0;
 }
=2D
=2Darch_initcall(pci_mmcfg_init);

--nextPart1193231.Ix4SUjcpzU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEI8FyN0y+n1M3mo0RAnthAKCbXOk7vVod/zGhCegdqOiQBxkUdgCg8Y3o
Q/YvyjHYfT8nB0hInhiK/DU=
=X9YA
-----END PGP SIGNATURE-----

--nextPart1193231.Ix4SUjcpzU--

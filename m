Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317496AbSFMIWy>; Thu, 13 Jun 2002 04:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSFMIWy>; Thu, 13 Jun 2002 04:22:54 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:24080 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S317496AbSFMIWw>;
	Thu, 13 Jun 2002 04:22:52 -0400
Date: Thu, 13 Jun 2002 12:20:53 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020613082053.GA614@pazke.ipt>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200206091754.g59Hs0d08560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Attached patch is needed to compile kernel with Voyager patch applied
for the SMP PC machine.

Also some questions, mostly related to arch-split patch:

[Q1] Will it be better to  create separate directory for PC architecture
and split some PC'isms from arch/i386/generic ? Right now it contains
acpi.c, bootflag.c and dmi_scan.c which are not generic in any way :)

[Q2] May be directory naming like mach-visws, mach-voyager and possible=20
mach-pc will be more convinent ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-voyager
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/arch/i386/config.in linux/ar=
ch/i386/config.in
--- linux.vanilla/arch/i386/config.in	Thu Jun 13 00:30:57 2002
+++ linux/arch/i386/config.in	Wed Jun 12 20:25:15 2002
@@ -425,11 +425,6 @@
    fi
 fi
=20
-if [ "$CONFIG_X86_LOCAL_APIC" =3D "y" ]; then
-   define_bool CONFIG_X86_EXTRA_IRQS y
-   define_bool CONFIG_X86_FIND_SMP_CONFIG y
-fi
-
 endmenu
=20
 source lib/Config.in
@@ -443,6 +438,13 @@
    if [ "$CONFIG_SMP" =3D "y" ]; then
       define_bool CONFIG_X86_SMP y
       define_bool CONFIG_X86_HT y
+      define_bool CONFIG_X86_IO_APIC y
+      define_bool CONFIG_X86_LOCAL_APIC y
    fi
    define_bool CONFIG_X86_BIOS_REBOOT y
+fi
+
+if [ "$CONFIG_X86_LOCAL_APIC" =3D "y" ]; then
+   define_bool CONFIG_X86_EXTRA_IRQS y
+   define_bool CONFIG_X86_FIND_SMP_CONFIG y
 fi
diff -urN -X /usr/share/dontdiff linux.vanilla/arch/i386/generic/Makefile l=
inux/arch/i386/generic/Makefile
--- linux.vanilla/arch/i386/generic/Makefile	Thu Jun 13 00:30:50 2002
+++ linux/arch/i386/generic/Makefile	Thu Jun 13 00:38:25 2002
@@ -18,7 +18,6 @@
=20
 obj-y				:=3D setup.o
=20
-obj-$(CONFIG_PCI)		+=3D pci-pc.o pci-irq.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+=3D mpparse.o
=20
 include $(TOPDIR)/Rules.make

--7AUc2qLy4jB3hD7Z--

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9CFXlBm4rlNOo3YgRAtbZAJ90cPsfWZkqYkXeyR9/ARkdGEjJnQCbBWcn
HtiJiLOllecys8U8br7tPIY=
=vvWC
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

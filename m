Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279457AbRJXH4g>; Wed, 24 Oct 2001 03:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279484AbRJXH41>; Wed, 24 Oct 2001 03:56:27 -0400
Received: from gatekeeper.bm.ipex.cz ([212.71.138.4]:5883 "EHLO v0jta.net")
	by vger.kernel.org with ESMTP id <S279457AbRJXH4R>;
	Wed, 24 Oct 2001 03:56:17 -0400
Date: Wed, 24 Oct 2001 09:54:23 +0200
From: Robert Vojta <robert@v0jta.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: SiS630S FrameBuffer & LCD
Message-ID: <20011024095423.E1178@ipex.cz>
In-Reply-To: <20011023153015.F4709@khazad-dum> <E15w5Yw-0000Q5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15w5Yw-0000Q5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 23, 2001 at 06:42:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> SiS actually had a much updated frame buffer console driver that never ma=
de
> it into the kernel (stuff needed fixing and I never got a reply so it
> dropped out of the tree)

  AFAIK the new informations from SiS are still doesn't working. I have this
SiS630 chipset too and I must use VesaFB for correct chipset initialization
and correct settings. VesaFB must have the same resolution and bpp which
I want in X. And I can use accelerated functions in X (not FB) by ugly hack
in sis_driver.c like, so it leaves settings from VesaFB and functions like
SiSPreSetMode(pScrn) and SiSSetMode(xf86Screens[scrnIndex], mode) are
skipped. I have this driver (precompiled) available on my pages
http://www.v0jta.net/gericom/gericom.php3?&menu=3D4#vga with all steps how
to make this chipset working with linux.

---
XFree86-4.1.0/xc/programs/Xserver/hw/xfree86/drivers/sis/sis_driver.c.orig
Fri Jul 13 20:42:56 2001
+++
XFree86-4.1.0/xc/programs/Xserver/hw/xfree86/drivers/sis/sis_driver.c
@@ -1210,7 +1210,9 @@
     vgaHWRestore(pScrn, vgaReg, VGA_SR_MODE);

     if ((pSiS->Chipset =3D=3D PCI_CHIP_SIS300) ||
+#if 0
             (pSiS->Chipset =3D=3D PCI_CHIP_SIS630) ||
+#endif
             (pSiS->Chipset =3D=3D PCI_CHIP_SIS540)) {
         SiSPreSetMode(pScrn);
         SiSSetMode(pScrn, pScrn->currentMode);
@@ -1550,7 +1552,9 @@
     ScrnInfoPtr pScrn =3D xf86Screens[scrnIndex];
     SISPtr pSiS =3D SISPTR(pScrn);
     if ((pSiS->Chipset =3D=3D PCI_CHIP_SIS300) ||
+#if 0
             (pSiS->Chipset =3D=3D PCI_CHIP_SIS630) ||
+#endif
             (pSiS->Chipset =3D=3D PCI_CHIP_SIS540))
         return SiSSetMode(xf86Screens[scrnIndex], mode);
     else
@@ -1661,7 +1665,9 @@

     /* Should we re-save the text mode on each VT enter? */
     if((pSiS->Chipset =3D=3D PCI_CHIP_SIS300) ||
+#if 0
             (pSiS->Chipset =3D=3D PCI_CHIP_SIS630) ||
+#endif
             (pSiS->Chipset =3D=3D PCI_CHIP_SIS540)) {
         SiSPreSetMode(pScrn);
         if (!SiSSetMode(pScrn, pScrn->currentMode))

                                                            --Robert V0jta

--=20
    Robert Vojta <vojta at {pharocom.net - work | v0jta.net - private}>
          GPG: ID 1024D/A0CB7953            http://www.v0jta.net/=20

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvWc68ACgkQInNB3KDLeVPbQACeO4QCyt0WudZAFUWHRkVULV8z
ysIAoIHOCFm8dcfhKD7SfLIq9kqEEx7S
=O9fR
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

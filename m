Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbTDKDWt (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 23:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTDKDWt (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 23:22:49 -0400
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:21216
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264150AbTDKDWr (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 23:22:47 -0400
Date: Thu, 10 Apr 2003 20:34:26 -0700
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
Message-ID: <20030411033426.GA13930@triplehelix.org>
References: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2003 at 08:09:41PM +0100, James Simmons wrote:
>=20
> Hi!
>=20
>   Here are the latest framebuffer changes. Some driver updates and a=20
> massive cleanup of teh cursor code. Tony please test it on the i810=20
> chipset. I tested it on the Riva but there is one bug I can't seem to=20
> find. Please test this patch. It is against 2.5.67 BK. It shoudl work=20
> against 2.5.67 as well.=20

I found that it requires this patch to compile correctly for radeonfb,
lifted from another LKML message:

--- a/include/linux/pci_ids.h	2003-04-02 22:10:00.000000000 +0200
+++ b/include/linux/pci_ids.h	2003-04-02 22:02:32.000000000 +0200
@@ -279,6 +279,7 @@
 #define PCI_DEVICE_ID_ATI_RADEON_QO	0x514f
 #define PCI_DEVICE_ID_ATI_RADEON_Ql	0x516c
 #define PCI_DEVICE_ID_ATI_RADEON_BB	0x4242
+#define PCI_DEVICE_ID_ATI_RADEON_QM	0x514d /* LN (my Radeon 9100) */
 /* Radeon RV200 (7500) */
 #define PCI_DEVICE_ID_ATI_RADEON_QW	0x5157
 #define PCI_DEVICE_ID_ATI_RADEON_QX	0x5158

And even then it does not build. Requires this patch.

--- a/drivers/video/radeonfb.c	2003-04-10 20:15:06.000000000 -0700
+++ b/drivers/video/radeonfb.c	2003-04-10 20:31:16.000000000 -0700
@@ -894,16 +894,6 @@
 				rinfo->pll.ref_div =3D 12;
 				rinfo->pll.ref_clk =3D 2700;
 				break;
-			case PCI_DEVICE_ID_ATI_RADEON_ND:
-			case PCI_DEVICE_ID_ATI_RADEON_NE:
-			case PCI_DEVICE_ID_ATI_RADEON_NF:
-			case PCI_DEVICE_ID_ATI_RADEON_NG:
-				rinfo->pll.ppll_max =3D 40000;
-				rinfo->pll.ppll_min =3D 20000;
-				rinfo->pll.xclk =3D 27000;
-				rinfo->pll.ref_div =3D 12;
-				rinfo->pll.ref_clk =3D 2700;
-				break;
 			case PCI_DEVICE_ID_ATI_RADEON_QD:
 			case PCI_DEVICE_ID_ATI_RADEON_QE:
 			case PCI_DEVICE_ID_ATI_RADEON_QF:

The kernel is still building, I will see what happens...

On 2.5.67-mm1 without the fbdev.diff, the computer would boot and not go
into fb mode at all. It would just hang there. So I'm trying this now.
Hope it works :)

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ljfCT2bz5yevw+4RAlKlAJ9S/gY5uowF4yKZ8AsvrZvD4Z4VUQCaAsnQ
1VvUSY75rl1oKXCbWuw4I8E=
=+Cf+
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

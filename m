Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTJVUur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 16:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbTJVUur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 16:50:47 -0400
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:64007 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S263533AbTJVUuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 16:50:44 -0400
Date: Wed, 22 Oct 2003 16:50:43 -0400
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Message-ID: <20031022205043.GA725@rivenstone.net>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2003 at 06:31:22PM +0100, James Simmons wrote:
>=20
> Hi folks.=20
>=20
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I=
=20
> added back in functionality for switching the video mode for fbcon via=20
> fbset again. Give it a try and let me know the results.
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

    The attached patch is needed to make tdfxfb compile after
applying this patch and also in test8-mm1 (so presumably in your older
patch as well) (tdfxfb_imageblt calls cfb_imageblt).

    tdfx is still badly broken in -mm1 both before and after replacing
the older fbdev patch in -mm1 with your new one.  The behavior is much
the same as reported with other drivers -- out of range frequencies
and the same backtraces.  With fbset working I can set a new
resolution which gets me a barely usable console -- lots of
artifacts.

    I don't have time to test against vanilla -test8; maybe later.
Thanks!


--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=out
Content-Transfer-Encoding: quoted-printable

diff -aur linux-2.6.0-test8-mm1_orig/drivers/video/Makefile /usr/src/linux-=
2.6.0-test8-mm1_duo/drivers/video/Makefile
--- linux-2.6.0-test8-mm1_orig/drivers/video/Makefile	2003-10-22 15:30:33.0=
00000000 -0400
+++ /usr/src/linux-2.6.0-test8-mm1_duo/drivers/video/Makefile	2003-10-22 16=
:38:27.000000000 -0400
@@ -32,7 +32,7 @@
 obj-$(CONFIG_FB_CYBER)            +=3D cyberfb.o
 obj-$(CONFIG_FB_CYBER2000)        +=3D cyber2000fb.o cfbfillrect.o cfbcopy=
area.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            +=3D sgivwfb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o
+obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o cfbimgblt.o
 obj-$(CONFIG_FB_MAC)              +=3D macfb.o macmodes.o cfbfillrect.o cf=
bcopyarea.o cfbimgblt.o=20
 obj-$(CONFIG_FB_HP300)            +=3D hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               +=3D offb.o cfbfillrect.o cfbimgblt.o cf=
bcopyarea.o

--k1lZvvs/B4yU6o8G--

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lu2jWv4KsgKfSVgRAgHdAJ9YqjgD9PVwPIbKQbaQ1wuJc+RZyQCfRZrq
oBt1eXd/Oj94l9h/E4TZVvg=
=8Eu9
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279979AbRJ3PWc>; Tue, 30 Oct 2001 10:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279976AbRJ3PWX>; Tue, 30 Oct 2001 10:22:23 -0500
Received: from warande3094.warande.uu.nl ([131.211.123.94]:12388 "EHLO
	xar.sliepen.oi") by vger.kernel.org with ESMTP id <S279982AbRJ3PWF>;
	Tue, 30 Oct 2001 10:22:05 -0500
Date: Tue, 30 Oct 2001 16:22:35 +0100
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
Subject: [PATCH] Fix check if device is ethernet in alloc_divert_blk
Message-ID: <20011030162235.B5566@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I was wondering why various devices like 802.11 bridges and tap devices
weren't recognized by the kernel as ethernet devices, because I got
messages like this in my syslog:

Oct 30 15:35:52 haplo kernel: divert: not allocating divert_blk for non-eth=
ernet device bla

Instead of checking for the actual device type, alloc_divert_blk was
just checking if the string "eth" occured in the name of the interface.
Attached patch makes it do the right thing instead (I hope).

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_dv
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.13.orig/net/core/dv.c	Tue Oct 30 16:09:20 2001
+++ linux-2.4.13/net/core/dv.c	Tue Oct 30 16:09:26 2001
@@ -53,7 +53,7 @@
 {
 	int alloc_size =3D (sizeof(struct divert_blk) + 3) & ~3;
=20
-	if (!strncmp(dev->name, "eth", 3)) {
+	if (dev->type =3D=3D ARPHRD_ETHER) {
 		printk(KERN_DEBUG "divert: allocating divert_blk for %s\n",
 		       dev->name);
=20

--8GpibOaaTibBMecb--

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE73sW7AxLow12M2nsRArQqAJ4mS6yQtYAa0PJQ4wN2xWgfEFqPkQCgp+04
dq1ofIkH0xsnfu5WW/2Ey9g=
=b0MS
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--

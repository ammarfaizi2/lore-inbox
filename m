Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbUKKUkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUKKUkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUKKUki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:40:38 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:20915 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262358AbUKKUjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:39:49 -0500
Subject: [PATCH] Add pci_save_state() to ALSA
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: perex@suse.cz
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1fZhgTC89D0309YJy1ik"
Message-Id: <1100205586.6496.31.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 11 Nov 2004 21:39:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1fZhgTC89D0309YJy1ik
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Some time ago, a patch was merged that removed pci_save_state() and
pci_restore_state() from various drivers. That patch also added
pci_restore_state() to sound/core/init.c but didn't add pci_save_state()
anywhere.

My laptop doesn't resume (gets what I assume is an ACPI timeout and
hangs solid) without this small obvious patch.

Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>

--- linux-2.6.10-rc1-bk21.orig/sound/core/init.c	2004-11-11 18:51:17.000000=
000 +0100
+++ linux-2.6.10-rc1-bk21/sound/core/init.c	2004-11-11 20:57:52.000000000 +=
0100
@@ -789,6 +789,8 @@ int snd_card_pci_suspend(struct pci_dev=20
 		return 0;
 	if (card->power_state =3D=3D SNDRV_CTL_POWER_D3hot)
 		return 0;
+	/* save the PCI config space */
+	pci_save_state(dev);
 	/* FIXME: correct state value? */
 	return card->pm_suspend(card, 0);
 }

--=20
/Martin

--=-1fZhgTC89D0309YJy1ik
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBk84SWm2vlfa207ERAtkdAKCx4Tcl3dHSJP9pyDm2ET5quTI6XwCfST0s
Irgnmf0OtbCqauNgbJ1crnI=
=P2oc
-----END PGP SIGNATURE-----

--=-1fZhgTC89D0309YJy1ik--

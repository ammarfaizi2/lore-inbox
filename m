Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVAWTz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVAWTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 14:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVAWTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 14:55:55 -0500
Received: from home-21008.b.astral.ro ([193.231.183.45]:53892 "EHLO
	sevenrains.ro") by vger.kernel.org with ESMTP id S261346AbVAWTzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 14:55:42 -0500
Subject: vt_def_color.patch
From: "Corcalciuc V. Horia" <rain@sevenrains.ro>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0bEnnV+Yi9CyayZNFJt6"
Date: Sun, 23 Jan 2005 21:55:11 +0200
Message-Id: <1106510111.4842.17.camel@Maia.ro>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0bEnnV+Yi9CyayZNFJt6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,
	I've written a small patch meant to modfity the default vt color on 2.6
kernels. If usefull please aply :)

--- linux-2.6.9/drivers/char/Kconfig    2004-10-19 00:53:07.000000000
+0300
+++ linux-update/drivers/char/Kconfig   2004-11-19 00:05:10.000000000
+0200
@@ -57,6 +57,35 @@
=20
          If unsure, say Y.
=20
+config VT_COLOR
+       bool "Change default VT color."
+        depends on VT
+        default n
+        ---help---
+          This option will allow you to change the default color of
your VT
+          terminal.
+
+          If you say Y here, the next option will let you choose the
hex
+          value. For more information see the help included for the
option
+          below.
+
+          This option should be safe. If unsure, say N.
+
+config VT_COLOR_NEW
+       hex "Choose default VT color"
+       depends on VT_COLOR
+       default 0x07
+        ---help---
+          Choose default VT foreground color. Setting this option will
let
+          you select the default color of your VT terminal.
+
+          Tested options:
+            0x03 - cyan
+            0x05 - purple
+            0x07 - white (default)
+            0x09 - blue
+            0x0A - green
+
 config HW_CONSOLE
        bool
        depends on VT && !S390 && !USERMODE
--- linux-2.6.9/drivers/char/vt.c       2004-10-19 00:55:06.000000000
+0300
+++ linux-update/drivers/char/vt.c      2004-11-18 23:48:44.000000000
+0200
@@ -2555,7 +2555,7 @@
                vc_cons[currcons].d->vc_palette[k++] =3D default_grn[j] ;
                vc_cons[currcons].d->vc_palette[k++] =3D default_blu[j] ;
        }
-       def_color       =3D 0x07;   /* white */
+       def_color       =3D CONFIG_VT_COLOR_NEW;   /* new */
        ulcolor         =3D 0x0f;   /* bold white */
        halfcolor       =3D 0x08;   /* grey */
        init_waitqueue_head(&vt_cons[currcons]->paste_wait);


--=-0bEnnV+Yi9CyayZNFJt6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9AEf+QhAJmAfs2cRAnqjAKCy3gtjCdRSKIz8L1qzZgCUd6bOjgCgn1ON
APTosww8Pv6ykTFOqUB6C7k=
=rgkZ
-----END PGP SIGNATURE-----

--=-0bEnnV+Yi9CyayZNFJt6--


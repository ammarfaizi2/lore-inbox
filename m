Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUF1OyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUF1OyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUF1OyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:54:17 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:19940 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264992AbUF1Oxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:53:53 -0400
Date: Mon, 28 Jun 2004 16:53:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: 2.4.27-rc2: Compile error in net/ipv4/netfilter/ip_fw_compat_masq.c
Message-ID: <20040628145350.GY20632@lug-owl.de>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B1y8+yu080dVsgDY"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B1y8+yu080dVsgDY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I get this compile error:

gcc -D__KERNEL__ -I/home/jbglaw/kernel/linux-2.4.27-rc2-md/include -Wall -W=
strict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomi=
t-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di386 -DMODULE=
  -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dip_fw_compat_masq  -c =
-o ip_fw_compat_masq.o
ip_fw_compat_masq.c
ip_fw_compat_masq.c: In function `check_for_demasq':
ip_fw_compat_masq.c:157: `IP_OFFSET' undeclared (first use in this function)
ip_fw_compat_masq.c:157: (Each undeclared identifier is reported only once
ip_fw_compat_masq.c:157: for each function it appears in.)
make[2]: *** [ip_fw_compat_masq.o] Error 1
make[2]: Leaving directory `/home/jbglaw/kernel/linux-2.4.27-rc2-md/net/ipv=
4/netfilter'
make[1]: *** [_modsubdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/home/jbglaw/kernel/linux-2.4.27-rc2-md/net'
make: *** [_mod_net] Error 2

This patch fixes it:

--- linux-2.4.27-rc2-clean/net/ipv4/netfilter/ip_fw_compat_masq.c	Mon Jan  =
5 14:53:56 2004
+++ linux-2.4.27-rc2-mod/net/ipv4/netfilter/ip_fw_compat_masq.c	Mon Jun 28 =
16:48:28 2004
@@ -15,6 +15,7 @@
 #include <linux/proc_fs.h>
 #include <linux/version.h>
 #include <linux/module.h>
+#include <net/ip.h>
 #include <net/route.h>
=20
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_conntrack_lock)


MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--B1y8+yu080dVsgDY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4DD+Hb1edYOZ4bsRAhuKAJwJYzUmy7dHXeMaRzT5llKbF+tcSACeJLRr
5ipasKM/YKtbAk85vq8UCRo=
=Qa5Z
-----END PGP SIGNATURE-----

--B1y8+yu080dVsgDY--

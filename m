Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbUKGUNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbUKGUNl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUKGUNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:13:41 -0500
Received: from mail.murom.net ([213.177.124.17]:61578 "EHLO mail.murom.net")
	by vger.kernel.org with ESMTP id S261593AbUKGUNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:13:38 -0500
Date: Sun, 7 Nov 2004 23:13:19 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jason Baron <jbaron@redhat.com>
Cc: Krzysztof Taraszka <dzimi@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add back lost call to tty->driver.set_termios
Message-ID: <20041107201319.GC2345@sirius.home>
References: <200410311053.34927.dzimi@pld-linux.org> <Pine.LNX.4.44.0411020958460.8117-100000@dhcp83-105.boston.redhat.com> <20041107200601.GA2345@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <20041107200601.GA2345@sirius.home>
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.067,
	required 6, autolearn=not spam, AWL 0.46, BAYES_01 -1.52)
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The call to tty->driver.set_termios in change_termios() has been lost;
after termios locking changes it can be put back safely.

--- kernel-source-2.4.27/drivers/char/tty_ioctl.c.set_termios	2004-11-07 18=
:28:12 +0300
+++ kernel-source-2.4.27/drivers/char/tty_ioctl.c	2004-11-07 21:44:36 +0300
@@ -138,6 +138,9 @@ static void change_termios(struct tty_st
 		}
 	}
=20
+	if (tty->driver.set_termios)
+		(*tty->driver.set_termios)(tty, &old_termios);
+
 	ld =3D tty_ldisc_ref(tty);
 	if (ld !=3D NULL) {
 		if (ld->set_termios)

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBjoHfW82GfkQfsqIRArurAJ9tNC3r8vy90Xevj9MW7fJOewHwzACfdN/i
8piZZrslrt9u/xuZyxnPA2I=
=wxDK
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--

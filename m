Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTFBFVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 01:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTFBFVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 01:21:38 -0400
Received: from adsl-66-136-200-10.dsl.austtx.swbell.net ([66.136.200.10]:60800
	"EHLO dragon.taral.net") by vger.kernel.org with ESMTP
	id S261876AbTFBFVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 01:21:37 -0400
Date: Mon, 2 Jun 2003 00:35:00 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 drivers/pcmcia/cs.c non-isa fix
Message-ID: <20030602053500.GA4490@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

RequestIRQ of a 16-bit card on a kernel without CONFIG_ISA will succeed
without setting AssignedIRQ. This patch causes it to fail (based on
current BK).

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Most parents have better things to do with their time than take care of
their children." -- Me

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cs.c.patch"


--- 1.29/drivers/pcmcia/cs.c	Fri May 30 00:42:33 2003
+++ edited/drivers/pcmcia/cs.c	Mon Jun  2 00:32:07 2003
@@ -1980,6 +1980,9 @@
 	    irq = req->IRQInfo1 & IRQ_MASK;
 	    ret = try_irq(req->Attributes, irq, 1);
 	}
+#else
+    } else {
+	ret = CS_UNSUPPORTED_MODE;
 #endif
     }
     if (ret != 0) return ret;

--J2SCkAp4GZ/dPZZf--

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2uIEoQQF8xCPwJQRAnO3AJ44fyeYdZa1x80KqXJS2skp+9c3TwCfSfU8
UlhPnKo/bzrWlNQ+bC+W8v0=
=Tb0f
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

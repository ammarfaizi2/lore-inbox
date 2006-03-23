Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWCWVNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWCWVNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWCWVNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:13:45 -0500
Received: from smtp06.auna.com ([62.81.186.16]:37563 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S964943AbWCWVNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:13:45 -0500
Date: Thu, 23 Mar 2006 22:13:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: [PATCH] Lower e100 latency
Message-ID: <20060323221342.2352789d@werewolf.auna.net>
In-Reply-To: <20060323220711.28fcb82f@werewolf.auna.net>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.0.0cvs160 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_t2mwv/VF8B3/71JEaglewTm";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Thu, 23 Mar 2006 22:13:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_t2mwv/VF8B3/71JEaglewTm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2006 22:07:11 +0100, "J.A. Magallon" <jamagallon@able.es> wr=
ote:

> On Thu, 23 Mar 2006 01:40:46 -0800, Andrew Morton <akpm@osdl.org> wrote:
>=20
> >=20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.=
6.16-mm1/
> >=20
>=20

--- linux/drivers/net/e100.c.orig	2006-01-24 09:20:44.000000000 +0100
+++ linux/drivers/net/e100.c	2006-01-24 09:21:55.000000000 +0100
@@ -884,23 +884,23 @@
 	 * procedure it should be done under lock.
 	 */
 	spin_lock_irqsave(&nic->mdio_lock, flags);
-	for (i =3D 100; i; --i) {
+	for (i =3D 1000; i; --i) {
 		if (readl(&nic->csr->mdi_ctrl) & mdi_ready)
 			break;
-		udelay(20);
+		udelay(2);
 	}
 	if (unlikely(!i)) {
-		printk("e100.mdio_ctrl(%s) won't go Ready\n",
+		DPRINTK(PROBE, ERR, "e100.mdio_ctrl(%s) won't go Ready\n",
 			nic->netdev->name );
 		spin_unlock_irqrestore(&nic->mdio_lock, flags);
 		return 0;		/* No way to indicate timeout error */
 	}
 	writel((reg << 16) | (addr << 21) | dir | data, &nic->csr->mdi_ctrl);
=20
-	for (i =3D 0; i < 100; i++) {
-		udelay(20);
+	for (i =3D 0; i < 1000; i++) {
 		if ((data_out =3D readl(&nic->csr->mdi_ctrl)) & mdi_ready)
 			break;
+		udelay(2);
 	}
 	spin_unlock_irqrestore(&nic->mdio_lock, flags);
 	DPRINTK(HW, DEBUG,


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam20 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1=
))

--Sig_t2mwv/VF8B3/71JEaglewTm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIw+GRlIHNEGnKMMRAlTYAJ0VYi09UOhDCPGfQ7Kctl+uvRD7wACfUHCZ
wNwA44KupcpAM7UQS+lM0GM=
=3/bQ
-----END PGP SIGNATURE-----

--Sig_t2mwv/VF8B3/71JEaglewTm--

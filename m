Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWC0UaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWC0UaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWC0UaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:30:22 -0500
Received: from smtp05.auna.com ([62.81.186.15]:3796 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1750831AbWC0UaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:30:21 -0500
Date: Mon, 27 Mar 2006 22:30:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: akpm@osdl.org
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lower e100 latency
Message-ID: <20060327223013.674d1970@werewolf.auna.net>
In-Reply-To: <4423221D.6020109@garzik.org>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
	<20060323221342.2352789d@werewolf.auna.net>
	<4423221D.6020109@garzik.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs171 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_G39T=Ygi65QWH9TcLcrZoGu";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Mon, 27 Mar 2006 22:30:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_G39T=Ygi65QWH9TcLcrZoGu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Corrected:

--- linux/drivers/net/e100.c.orig	2006-01-24 09:20:44.000000000 +0100
+++ linux/drivers/net/e100.c	2006-01-24 09:21:55.000000000 +0100
@@ -884,10 +884,10 @@
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
 		printk("e100.mdio_ctrl(%s) won't go Ready\n",
@@ -897,10 +897,10 @@
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
Linux 2.6.16-jam1 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1))

--Sig_G39T=Ygi65QWH9TcLcrZoGu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKEtVRlIHNEGnKMMRAlafAKCE20S2M/+epM5QSzZXN4S1imraygCfRlsp
N1F1VxAbOQRTEcp50SdlqGM=
=ZZi0
-----END PGP SIGNATURE-----

--Sig_G39T=Ygi65QWH9TcLcrZoGu--

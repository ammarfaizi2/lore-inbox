Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272065AbRH2U2y>; Wed, 29 Aug 2001 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272066AbRH2U2o>; Wed, 29 Aug 2001 16:28:44 -0400
Received: from cr934547-a.flfrd1.on.wave.home.com ([24.112.247.163]:10739 "EHLO
	shippou.furryterror.org") by vger.kernel.org with ESMTP
	id <S272065AbRH2U22>; Wed, 29 Aug 2001 16:28:28 -0400
Date: Wed, 29 Aug 2001 07:54:33 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: andre@linux-ide.org, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Patch for Promise FastTrack 100 Tx2 (aka PDC20268R)
Message-ID: <20010829075433.A9238@feedme.hungrycats.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code in 2.4.9-ac3 for detecting a PDC20268 or PDC20268R doesn't
enable BM-DMA for the PDC20268R.  The fix below seems to work for me.

There is a note in the comments to the effect that the Promise FastTrack
100 RAID card has a different PCI device ID just to prevent Linux from
detecting it.  Having seen both the UltraATA-100 and FastTrack-100 cards,
I don't believe this is the case. =20

Unlike certain previous Promise ATA and ATA-RAID controllers, there
are physical differences between the RAID and non-RAID ATA-100 cards.
The UltraATA-100 card is a normal 33MHz PCI card, while the FastTrack
100 is a 66MHz PCI card.

Then again, last time I checked, 66MHz cards _look_ just like 33MHz cards.
Hmmm...

diff -ur linux/drivers/ide/ide-pci.c 586-smp/kernel-source-2.4.9-ac3-zb-586=
-smp-zb2001082823/drivers/ide/ide-pci.c
--- linux/drivers/ide/ide-pci.c	Mon Aug 13 17:56:19 2001
+++ 586-smp/kernel-source-2.4.9-ac3-zb-586-smp-zb2001082823/drivers/ide/ide=
-pci.c	Tue Aug 28 23:31:08 2001
@@ -767,6 +767,7 @@
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||
diff -ur linux/drivers/ide/pdc202xx.c 586-smp/kernel-source-2.4.9-ac3-zb-58=
6-smp-zb2001082823/drivers/ide/pdc202xx.c
--- linux/drivers/ide/pdc202xx.c	Mon Aug 13 17:56:19 2001
+++ 586-smp/kernel-source-2.4.9-ac3-zb-586-smp-zb2001082823/drivers/ide/pdc=
202xx.c	Tue Aug 28 23:31:21 2001
@@ -133,6 +133,7 @@
=20
 	switch(dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20268:
+		case PCI_DEVICE_ID_PROMISE_20268R:
 			p +=3D sprintf(p, "\n                                PDC20268 TX2 Chips=
et.\n");
 			invalid_data_set =3D 1;
 			break;

--=20
Zygo Blaxell (Laptop) <zblaxell@feedme.hungrycats.org>
GPG =3D D13D 6651 F446 9787 600B AD1E CCF3 6F93 2823 44AD

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7jNf5zPNvkygjRK0RAjZRAJ44YTSxooZ6WeQtS3PB7CiZqldw4QCfbI/c
pCJUk1Vdvy2fSC/0uUdJlig=
=BL9J
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

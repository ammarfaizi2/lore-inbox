Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUE1NzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUE1NzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUE1NzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:55:17 -0400
Received: from pD9FFA005.dip.t-dialin.net ([217.255.160.5]:54700 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S263100AbUE1Ny5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:54:57 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Enable suspend/resuming of e1000
Date: Fri, 28 May 2004 14:04:03 +0200
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zqytApaO7WK4fHj"
Message-Id: <200405281404.10538@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zqytApaO7WK4fHj
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

suspending of the e1000 in my Thinkpad did not work, so I jst started some=
=20
hacking. The attached patch does the trick for me, it just disables/enables=
=20
the device. I used 2.6.7-rc1-mm1, but it should apply to rc1 also. If it's=
=20
correct (Hey, I'm just beginning..), it could perhaps be=20
applied to mainline / mm?

regards
Alex
=2D --=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291


=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtyq4/aHb+2190pERAmXwAKCTQ15yCP8KhcIE437od8v2IrqndwCeMW1w
BeOJRrYbRJHeu4NDdwXxrLE=3D
=3DqIVX
=2D----END PGP SIGNATURE-----

--Boundary-00=_zqytApaO7WK4fHj
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="e1000-suspend-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="e1000-suspend-resume.patch"

--- linux-2.6.7-rc1-ag1/drivers/net/e1000/e1000_main.c	2004-05-26 23:25:40.000000000 +0200
+++ linux-2.6.7-rc1-mm1/drivers/net/e1000/e1000_main.c	2004-05-27 23:53:54.000000000 +0200
@@ -2864,6 +2864,8 @@
 		}
 	}
 
+	pci_disable_device(pdev);
+	
 	state = (state > 0) ? 3 : 0;
 	pci_set_power_state(pdev, state);
 
@@ -2874,6 +2876,8 @@
 static int
 e1000_resume(struct pci_dev *pdev)
 {
+        pci_enable_device(pdev);
+
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc;

--Boundary-00=_zqytApaO7WK4fHj--


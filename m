Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267519AbSLLWjq>; Thu, 12 Dec 2002 17:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267525AbSLLWjq>; Thu, 12 Dec 2002 17:39:46 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43651 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267519AbSLLWjp>; Thu, 12 Dec 2002 17:39:45 -0500
Message-Id: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-338121838P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Dec 2002 17:47:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-338121838P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-3381710880"

This is a multipart MIME message.

--==_Exmh_-3381710880
Content-Type: text/plain; charset=us-ascii

> PCI: Device 02:00.0 not available because of resource collisions
> PCI: Device 02:00.1 not available because of resource collisions

Been there. Done that. Does the attached patch help? It did for me.

/Valdis



--==_Exmh_-3381710880
Content-Type: text/plain ; name="pcmcia.patch"; charset=us-ascii
Content-Description: pcmcia.patch
Content-Disposition: attachment; filename="pcmcia.patch"

--- drivers/pcmcia/cardbus.c.dist	2002-12-03 01:49:29.000000000 -0500
+++ drivers/pcmcia/cardbus.c	2002-12-03 01:50:23.000000000 -0500
@@ -283,8 +283,6 @@
 		dev->hdr_type = hdr & 0x7f;
 
 		pci_setup_device(dev);
-		if (pci_enable_device(dev))
-			continue;
 
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
@@ -302,6 +300,8 @@
 			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
 		}
 
+		if (pci_enable_device(dev))
+			continue;
 		device_register(&dev->dev);
 		pci_insert_device(dev, bus);
 	}

--==_Exmh_-3381710880--


--==_Exmh_-338121838P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9+RH1cC3lWbTT17ARAp8PAKCphoDmrvovTFS6Mir+hzCw/1WP4gCg8+k8
EIRcXln0uIdGmpB82Ao5nfc=
=sdyX
-----END PGP SIGNATURE-----

--==_Exmh_-338121838P--

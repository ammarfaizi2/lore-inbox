Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSKRVjn>; Mon, 18 Nov 2002 16:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKRVjn>; Mon, 18 Nov 2002 16:39:43 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:41715 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S264844AbSKRVjm>; Mon, 18 Nov 2002 16:39:42 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15833.24514.280850.81268@wombat.chubb.wattle.id.au>
Date: Tue, 19 Nov 2002 08:46:42 +1100
To: linux-kernel@vger.kernel.org
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Tulip driver fails to link (2.5.48)
X-Mailer: VM 7.04 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	In the tulip driver,  the .remove entry of struct pci_driveris
declared __devexit_p but the function  is declared __exit.  This
causes a relocation error when building as a built-in (not a module),
when CONFIG_HOTPLUG is defined.

===== drivers/net/tulip/de2104x.c 1.12 vs edited =====
--- 1.12/drivers/net/tulip/de2104x.c    Wed Nov  6 05:19:30 2002
+++ edited/drivers/net/tulip/de2104x.c  Mon Nov 18 21:14:47 2002
@@ -2137,7 +2137,7 @@
	return rc;
 }
 
-static void __exit de_remove_one (struct pci_dev *pdev)
+static void __devexit de_remove_one (struct pci_dev *pdev)
 {
	struct net_device *dev = pci_get_drvdata(pdev);
 	struct de_private *de = dev->priv;

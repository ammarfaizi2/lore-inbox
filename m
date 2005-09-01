Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVIADK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVIADK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVIADK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:10:27 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:7916 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965047AbVIADK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:10:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17174.28949.924936.781961@wombat.chubb.wattle.id.au>
Date: Thu, 1 Sep 2005 13:10:13 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: 'mdio_bus_exit' in discarded section .text.exit
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When building with  CONFIG_PHYLIB=y on Itanium, I see:
 `mdio_bus_exit' referenced in section `.init.text' of
drivers/built-in.o: defined in discarded section `.exit.text' of
drivers/built-in.o

I believe that mdio_bus_exit should not be declared __exit, because it
is referencesd from __init sections in, say, phy_init().

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -170,7 +170,7 @@ int __init mdio_bus_init(void)
   return bus_register(&mdio_bus_type);
 }
 
-void __exit mdio_bus_exit(void)
+void mdio_bus_exit(void)
 {
	bus_unregister(&mdio_bus_type);
 }


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

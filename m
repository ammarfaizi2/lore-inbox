Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTBHRn1>; Sat, 8 Feb 2003 12:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBHRn1>; Sat, 8 Feb 2003 12:43:27 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:40919 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267042AbTBHRn0>; Sat, 8 Feb 2003 12:43:26 -0500
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [PATCH] Gets 3c59x to compile on non-PCI systems
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 08 Feb 2003 18:52:50 +0100
Message-ID: <wrpptq2wtfx.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi all,

My previous round of EISA hacking left the 3c59x driver unable to
compile on non-PCI systems (that is, EISA only...).

This small patch fixes it.

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=3c59x.patch

===== drivers/net/3c59x.c 1.23.1.5 vs 1.30 =====
--- 1.23.1.5/drivers/net/3c59x.c	Wed Jan 15 17:56:16 2003
+++ 1.30/drivers/net/3c59x.c	Sun Jan 26 20:26:07 2003
@@ -181,7 +181,7 @@
     - See http://www.zip.com.au/~akpm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 
-   LK1.1.19 10Nov09 Marc Zyngier <maz@wild-wind.fr.eu.org>
+   LK1.1.19 10Nov02 Marc Zyngier <maz@wild-wind.fr.eu.org>
     - EISA sysfs integration.
 */
 
@@ -817,7 +817,11 @@
 	u32 power_state[16];
 };
 
+#ifdef CONFIG_PCI
 #define DEVICE_PCI(dev) (((dev)->bus == &pci_bus_type) ? to_pci_dev((dev)) : NULL)
+#else
+#define DEVICE_PCI(dev) NULL
+#endif
 
 #define VORTEX_PCI(vp) (((vp)->gendev) ? DEVICE_PCI((vp)->gendev) : NULL)
 

--=-=-=

-- 
Places change, faces change. Life is so very strange.

--=-=-=--

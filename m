Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbTCIQes>; Sun, 9 Mar 2003 11:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262539AbTCIQes>; Sun, 9 Mar 2003 11:34:48 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:10513 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S262537AbTCIQeq>; Sun, 9 Mar 2003 11:34:46 -0500
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EISA aic7770 broken
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 09 Mar 2003 17:43:38 +0100
Message-ID: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Justin,

I'm having troubles getting an Adaptec AHA-2740 (EISA) running on
2.5.64.

First thing is the initial request_region succeeds, but the driver
thinks it failed... The enclosed patch fixes it.

But the driver crashes badly while probing the card, somewhere in
ahc_runq_tasklet.

Any idea ?

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=aic7770_osm.patch

===== drivers/scsi/aic7xxx/aic7770_osm.c 1.2 vs 1.3 =====
--- 1.2/drivers/scsi/aic7xxx/aic7770_osm.c	Tue Dec 31 02:54:16 2002
+++ 1.3/drivers/scsi/aic7xxx/aic7770_osm.c	Sun Mar  9 17:23:13 2003
@@ -66,7 +66,7 @@
 			continue;
 		request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx");
 #else
-		if (request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx") != 0)
+		if (!request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx"))
 			continue;
 #endif
 

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--

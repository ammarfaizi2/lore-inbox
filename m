Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTLOJQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 04:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLOJQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 04:16:59 -0500
Received: from [195.4.3.109] ([195.4.3.109]:42123 "EHLO cat-serv.catworkx.de")
	by vger.kernel.org with ESMTP id S263400AbTLOJQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 04:16:57 -0500
From: Holger Lehmann <holger.lehmann@catworkx.de>
Organization: catWorkX GmbH
To: linux-kernel@vger.kernel.org
Subject: Enhancement patch for the Adaptec SCSI Driver (2915LP / 2930LP)
Date: Mon, 15 Dec 2003 10:18:58 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CyX3/+Kx6Cnlqez"
Message-Id: <200312151018.58127.holger.lehmann@catworkx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_CyX3/+Kx6Cnlqez
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,

I'll make this really quick.
Attached to this email is a small patch for the current aic7xxx driver for 
Linux. It can be applied to 2.4.x, 2.5.x and 2.6.x and the original adaptec 
driver version 2.0.2 .

This patch adds one PCI device id mapping for the Adaptc 2915LP controller ( a 
low profile controller). I believe that the 2930LP is the same controller as 
the 2915LP, so the patch ought to work for that one as well. Furthermore 
there seems to be an Fujitsu AVA-2915LP controller which is most likely the 
same as above.

The patch is verified to work on a 2.4.20 kernel. A simple tape drive was 
attached to it and that worked as well :-)

I have submitted the patch to Adaptec with the request for integration but no 
one knows if and when that will happen. Perhaps someone on this list is or 
feels responible for that driver and can make the inclusion happen.

Thanks in advance,
- Holger

--Boundary-00=_CyX3/+Kx6Cnlqez
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aic7xxx_pci.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aic7xxx_pci.c.diff"

--- aic7xxx_pci.c.orig	Fri Dec 12 08:01:32 2003
+++ aic7xxx_pci.c	Fri Dec 12 08:01:35 2003
@@ -127,6 +127,7 @@
 
 #define ID_AIC7892			0x008F9005FFFF9005ull
 #define ID_AIC7892_ARO			0x00839005FFFF9005ull
+#define ID_AHA_2915LP			0x0082900502109005ull
 #define ID_AHA_29160			0x00809005E2A09005ull
 #define ID_AHA_29160_CPQ		0x00809005E2A00E11ull
 #define ID_AHA_29160N			0x0080900562A09005ull
@@ -468,6 +469,12 @@
 		ID_AIC7892_ARO,
 		ID_ALL_MASK,
 		"Adaptec aic7892 Ultra160 SCSI adapter (ARO)",
+		ahc_aic7892_setup
+	},
+	{
+		ID_AHA_2915LP,
+		ID_ALL_MASK,
+		"Adaptec 2915LP Ultra160 SCSI adapter",
 		ahc_aic7892_setup
 	},
 	/* aic7895 based controllers */	

--Boundary-00=_CyX3/+Kx6Cnlqez--


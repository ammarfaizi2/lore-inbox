Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSFYTC3>; Tue, 25 Jun 2002 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSFYTC2>; Tue, 25 Jun 2002 15:02:28 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:18618 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S315529AbSFYTC1>;
	Tue, 25 Jun 2002 15:02:27 -0400
Message-ID: <3D18BE61.5040405@colorfullife.com>
Date: Tue, 25 Jun 2002 21:02:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en, de
MIME-Version: 1.0
To: davej@suse.de, linux-kernel@vger.kernel.org
Subject: agp compile error with 2.5.24-dj2
Content-Type: multipart/mixed;
 boundary="------------080502000204010205080000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502000204010205080000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2.5.24-dj2 doesn't compile with my .config:
* the declaration of intel_i815_setup was missing in agp.h
* there is a superflous '+' in front of one line, probably a leftover 
from a manual merge.


Patch attach, but not tested.

--
	Manfred

--------------080502000204010205080000
Content-Type: text/plain;
 name="patch-agp-dj2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp-dj2"

diff -u 2.5/drivers/char/agp/agp.h build-2.5/drivers/char/agp/agp.h
--- 2.5/drivers/char/agp/agp.h	Tue Jun 25 20:28:04 2002
+++ build-2.5/drivers/char/agp/agp.h	Tue Jun 25 20:46:26 2002
@@ -53,6 +53,7 @@
 int __init intel_i460_setup (struct pci_dev *pdev);
 int __init intel_generic_setup (struct pci_dev *pdev);
 int __init intel_i810_setup(struct pci_dev *i810_dev);
+int __init intel_815_setup(struct pci_dev *pdev);
 int __init intel_i830_setup(struct pci_dev *i830_dev);
 int __init intel_820_setup (struct pci_dev *pdev);
 int __init intel_830mp_setup (struct pci_dev *pdev);
diff -u 2.5/drivers/char/agp/agpgart_be-i8x0.c build-2.5/drivers/char/agp/agpgart_be-i8x0.c
--- 2.5/drivers/char/agp/agpgart_be-i8x0.c	Tue Jun 25 20:28:04 2002
+++ build-2.5/drivers/char/agp/agpgart_be-i8x0.c	Tue Jun 25 20:49:42 2002
@@ -438,7 +438,7 @@
 	{0x00000017, 0}
 };
 
-+static aper_size_info_8 intel_815_sizes[2] =
+static aper_size_info_8 intel_815_sizes[2] =
 {
 	{64, 16384, 4, 0},
 	{32, 8192, 3, 8},
@@ -507,7 +507,7 @@
 	(void) pdev; /* unused */
 }
 
-static int __init intel_815_setup (struct pci_dev *pdev)
+int __init intel_815_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
 	agp_bridge.num_of_masks = 1;

--------------080502000204010205080000--



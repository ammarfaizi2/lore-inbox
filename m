Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSLJJUY>; Tue, 10 Dec 2002 04:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLJJUY>; Tue, 10 Dec 2002 04:20:24 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:57617 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266716AbSLJJUX>; Tue, 10 Dec 2002 04:20:23 -0500
Subject: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039522886.1041.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 17:21:29 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1.  Agpgart is broken for i810, and perhaps some of the i815 family. The
following lines (linux/drivers/char/agp/backend.c:120)

	cap_ptr = pci_find_capability(dev, PCI_CAP_ID_AGP);
	if (cap_ptr == 0) <--- /* always 0 for the i810 */
		return -ENODEV;
	agp_bridge.capndx = cap_ptr;

will always fail because they really don't have AGP.  Commenting them
out in my case correctly initializes the gart.

2.  The i810 driver for Xfree86 will also fail to load because of
version mismatch (0.99 vs 1.0).  Rolling back the version corrects the
problem.

No patches because I don't want to uglify the code :-)

Tony

PS:  I'm not on the list, please CC me.




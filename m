Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbTCSUdH>; Wed, 19 Mar 2003 15:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTCSUdG>; Wed, 19 Mar 2003 15:33:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36230 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S263141AbTCSUdG> convert rfc822-to-8bit; Wed, 19 Mar 2003 15:33:06 -0500
Date: Wed, 19 Mar 2003 17:43:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ani Joshi <ajoshi@unixbox.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Patch for radeon framebuffer (fwd)
Message-ID: <Pine.LNX.4.53L.0303191742580.6210@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forwarded to the radeon maintainer.


Danke

---------- Forwarded message ----------
Date: Sat, 15 Mar 2003 14:24:08 +0100
From: "Hanno [ISO-8859-15] Böck" <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Patch for radeon framebuffer

The patch below has been around for ages now.
It is needed on some radeon mobility cards, because they report 0 for
their video-ram-size.
Without the patch, the radeonfb will not work.

Can you include this in the next kernel release?


--- radeonfb.c.orig	Thu May  9 16:51:26 2002
+++ radeonfb.c	Thu May  9 16:48:46 2002
@@ -877,6 +877,14 @@
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;

+	/* According to XFree86 4.2.0, some production M6's return 0
+	   for 8MB. */
+	if (rinfo->video_ram == 0 &&
+	    (pdev->device == PCI_DEVICE_ID_RADEON_LY ||
+	     pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
+	    rinfo->video_ram = 8192 * 1024;
+	  }
+
 	/* ram type */
 	tmp = INREG(MEM_SDRAM_MODE_REG);
 	switch ((MEM_CFG_TYPE & tmp) >> 30) {

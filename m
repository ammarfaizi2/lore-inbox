Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSGQGcb>; Wed, 17 Jul 2002 02:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSGQGca>; Wed, 17 Jul 2002 02:32:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:53106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318230AbSGQGc3>;
	Wed, 17 Jul 2002 02:32:29 -0400
Date: Wed, 17 Jul 2002 08:35:20 +0200
From: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: radeonfb and 2.4.19-rc2
Message-Id: <20020717083520.49db4483.hanno@gmx.de>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been some updates in the radeonfb that are needed for some cards (especially mobility cards) to work.
The fixed version of radeonfb is in the ac-kernels, but not in the current 2.4.19-rc2.

Any chance that it will go into 2.4.19 final?

I'm talking especially about this patch, which is important for radeonfb to work on my machine for example:

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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCOMN3>; Sat, 15 Mar 2003 07:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbTCOMN3>; Sat, 15 Mar 2003 07:13:29 -0500
Received: from mail.gmx.net ([213.165.65.60]:49416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261427AbTCOMN2>;
	Sat, 15 Mar 2003 07:13:28 -0500
Date: Sat, 15 Mar 2003 14:24:08 +0100
From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Patch for radeon framebuffer
Message-Id: <20030315142408.7d3bc3c0.hanno@gmx.de>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUK2Mid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUK2Mid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUK2MhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:37:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14867 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261705AbUK2MfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:35:03 -0500
Date: Mon, 29 Nov 2004 13:35:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/ps2esdi.c: remove two unused functions
Message-ID: <20041129123500.GO9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two unused global functions.


diffstat output:
 drivers/block/ps2esdi.c |   42 ----------------------------------------
 1 files changed, 42 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/ps2esdi.c.old	2004-11-06 20:17:34.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/ps2esdi.c	2004-11-06 20:18:33.000000000 +0100
@@ -221,48 +221,6 @@
 }
 #endif /* MODULE */
 
-/* handles boot time command line parameters */
-void __init tp720_setup(char *str, int *ints)
-{
-	/* no params, just sets the tp720esdi flag if it exists */
-
-	printk("%s: TP 720 ESDI flag set\n", DEVICE_NAME);
-	tp720esdi = 1;
-}
-
-void __init ed_setup(char *str, int *ints)
-{
-	int hdind = 0;
-
-	/* handles 3 parameters only - corresponding to
-	   1. Number of cylinders
-	   2. Number of heads
-	   3. Sectors/track
-	 */
-
-	if (ints[0] != 3)
-		return;
-
-	/* print out the information - seen at boot time */
-	printk("%s: ints[0]=%d ints[1]=%d ints[2]=%d ints[3]=%d\n",
-	       DEVICE_NAME, ints[0], ints[1], ints[2], ints[3]);
-
-	/* set the index into device specific information table */
-	if (ps2esdi_info[0].head != 0)
-		hdind = 1;
-
-	/* set up all the device information */
-	ps2esdi_info[hdind].head = ints[2];
-	ps2esdi_info[hdind].sect = ints[3];
-	ps2esdi_info[hdind].cyl = ints[1];
-	ps2esdi_info[hdind].wpcom = 0;
-	ps2esdi_info[hdind].lzone = ints[1];
-	ps2esdi_info[hdind].ctl = (ints[2] > 8 ? 8 : 0);
-#if 0				/* this may be needed for PS2/Mod.80, but it hurts ThinkPad! */
-	ps2esdi_drives = hdind + 1;	/* increment index for the next time */
-#endif
-}				/* ed_setup */
-
 static int ps2esdi_getinfo(char *buf, int slot, void *d)
 {
 	int len = 0;


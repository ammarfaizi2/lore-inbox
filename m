Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVAaRkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVAaRkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVAaRjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:39:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59147 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261277AbVAaRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:36:55 -0500
Date: Mon, 31 Jan 2005 18:36:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/specialix.c: misc cleanups
Message-ID: <20050131173654.GT18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make some needlessly global code static
- remove the unused global function specialix_setup

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/specialix.c |   43 +++++----------------------------------
 1 files changed, 6 insertions(+), 37 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/specialix.c.old	2005-01-31 15:06:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/specialix.c	2005-01-31 15:07:39.000000000 +0100
@@ -372,7 +372,7 @@
 
 
 /* Set the IRQ using the RTS lines that run to the PAL on the board.... */
-int sx_set_irq ( struct specialix_board *bp)
+static int sx_set_irq ( struct specialix_board *bp)
 {
 	int virq;
 	int i;
@@ -439,7 +439,7 @@
 }
 
 
-int read_cross_byte (struct specialix_board *bp, int reg, int bit)
+static int read_cross_byte (struct specialix_board *bp, int reg, int bit)
 {
 	int i;
 	int t;
@@ -985,7 +985,7 @@
  *  Routines for open & close processing.
  */
 
-void turn_ints_off (struct specialix_board *bp)
+static void turn_ints_off (struct specialix_board *bp)
 {
 	unsigned long flags;
 	func_enter ();
@@ -1004,7 +1004,7 @@
 	func_exit ();
 }
 
-void turn_ints_on (struct specialix_board *bp)
+static void turn_ints_on (struct specialix_board *bp)
 {
 	unsigned long flags;
 
@@ -2478,37 +2478,6 @@
 }
 
 
-#ifndef MODULE
-/*
- * Called at boot time.
- * 
- * You can specify IO base for up to SX_NBOARD cards,
- * using line "specialix=0xiobase1,0xiobase2,.." at LILO prompt.
- * Note that there will be no probing at default
- * addresses in this case.
- *
- */ 
-void specialix_setup(char *str, int * ints)
-{
-	int i;
-        
-	func_enter ();
-
-	for (i=0;i<SX_NBOARD;i++) {
-		sx_board[i].base = 0;
-	}
-
-	for (i = 1; i <= ints[0]; i++) {
-		if (i&1)
-			sx_board[i/2].base = ints[i];
-		else
-			sx_board[i/2 -1].irq = ints[i];
-	}
-
-	func_exit ();
-}
-#endif
-
 /* 
  * This routine must be called by kernel at boot time 
  */
@@ -2579,9 +2548,9 @@
 	return 0;
 }
 
-int iobase[SX_NBOARD]  = {0,};
+static int iobase[SX_NBOARD]  = {0,};
 
-int irq [SX_NBOARD] = {0,};
+static int irq [SX_NBOARD] = {0,};
 
 module_param_array(iobase, int, NULL, 0);
 module_param_array(irq, int, NULL, 0);


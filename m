Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUF0TDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUF0TDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUF0TDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:03:10 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:39391 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261654AbUF0TDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:03:05 -0400
Date: Sun, 27 Jun 2004 12:25:14 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.7 indydog.c-patch-20040627
Message-ID: <20040627122514.A26997@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/indydog.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/06/27 1.1770)
   [WATCHDOG] indydog.c-patch-20040627
   
   * Fix: since we use the new module_param's: make sure that
   linux/moduleparam.h stays included
   * in the release code we can just use indydog_stop();


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Sun Jun 27 12:23:11 2004
+++ b/drivers/char/watchdog/indydog.c	Sun Jun 27 12:23:11 2004
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -87,12 +88,9 @@
 {
 	/* Shut off the timer.
 	 * Lock it in if it's a module and we defined ...NOWAYOUT */
-	if (!nowayout) {
-		u32 mc_ctrl0 = sgimc->cpuctrl0;
-		mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
-		sgimc->cpuctrl0 = mc_ctrl0;
-		printk(KERN_INFO "Stopped watchdog timer.\n");
-	}
+	if (!nowayout)
+		indydog_stop();		/* Turn the WDT off */
+
 	indydog_alive = 0;
 
 	return 0;

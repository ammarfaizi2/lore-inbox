Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTICUoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbTICUoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:44:55 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:54711 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264188AbTICUou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:44:50 -0400
Date: Wed, 3 Sep 2003 22:44:25 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Justin Cormack <justin@street-vision.com>
Subject: [PATCH] 2.6.0-test4 - Watchdog patches - wafer5823wdt.c
Message-ID: <20030903224425.A25386@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This will update the following files:

 drivers/char/watchdog/wafer5823wdt.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/09/03 1.1276.35.8)
   [WATCHDOG] wafer5823wdt.c - patch4
   
   remove module_param's for wdt_start and wdt_stop
   fix timeout check in init procedure


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Wed Sep  3 22:39:08 2003
+++ b/drivers/char/watchdog/wafer5823wdt.c	Wed Sep  3 22:39:08 2003
@@ -57,12 +57,7 @@
  */
 
 static int wdt_stop = 0x843;
-module_param(wdt_stop, int, 0);
-MODULE_PARM_DESC(wdt_stop, "Wafer 5823 WDT 'stop' io port (default 0x843)");
-
 static int wdt_start = 0x443;
-module_param(wdt_start, int, 0);
-MODULE_PARM_DESC(wdt_start, "Wafer 5823 WDT 'start' io port (default 0x443)");
 
 static int timeout = WD_TIMO;  /* in seconds */
 module_param(timeout, int, 0);
@@ -269,7 +264,7 @@
 
 	spin_lock_init(&wafwdt_lock);
 
-	if (timeout < 1 || timeout > 63) {
+	if (timeout < 1 || timeout > 255) {
 		timeout = WD_TIMO;
 		printk (KERN_INFO PFX "timeout value must be 1<=x<=255, using %d\n",
 			timeout);

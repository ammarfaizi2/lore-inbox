Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264179AbTIIOxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTIIOxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:53:18 -0400
Received: from M1008P012.adsl.highway.telekom.at ([62.47.157.236]:44673 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S264170AbTIIOxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:53:12 -0400
Date: Tue, 9 Sep 2003 16:53:09 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: kj@mail.sternwelten.at, emoenke@gwdg.de
Subject: [2.6 patch] fix aztcd.c compile warning
Message-ID: <20030909145309.GA24405@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch tries to fix the following compile warning:
-- snipp
drivers/cdrom/aztcd.c:379: warning: `pa_ok' defined but not used
--

with belows patch drivers/cdrom/aztcd.c compiles without warning
the patch also removes a comment section where pa_ok _was_ used
the warning shows off on each single compile statistics by cherry.
i hope this helps :)


a++ maks



--- linux-2.6.0-test5/drivers/cdrom/aztcd.c	Mon Sep  8 21:50:28 2003
+++ linux/drivers/cdrom/aztcd.c	Tue Sep  9 15:53:09 2003
@@ -373,21 +373,6 @@
 	} while (aztIndatum != AFL_OP_OK);
 }
 
-/* Wait for PA_OK = drive answers with AFL_PA_OK after receiving parameters*/
-# define PA_OK pa_ok()
-static void pa_ok(void)
-{
-	aztTimeOutCount = 0;
-	do {
-		aztIndatum = inb(DATA_PORT);
-		aztTimeOutCount++;
-		if (aztTimeOutCount >= AZT_TIMEOUT) {
-			printk("aztcd: Error Wait PA_OK\n");
-			break;
-		}
-	} while (aztIndatum != AFL_PA_OK);
-}
-
 /* Wait for STEN=Low = handshake signal 'AFL_.._OK available or command executed*/
 # define STEN_LOW  sten_low()
 static void sten_low(void)
@@ -2077,11 +2062,6 @@
 				return;
 			}
 
-/*	  if (aztSendCmd(ACMD_SET_MODE)) RETURN("azt_poll 3");
-	  outb(0x01, DATA_PORT);
-	  PA_OK;
-	  STEN_LOW;
-*/
 			if (aztSendCmd(ACMD_GET_STATUS))
 				RETURN("azt_poll 4");
 			STEN_LOW;

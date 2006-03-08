Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWCHJHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWCHJHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCHJHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:07:55 -0500
Received: from mail.gmx.de ([213.165.64.20]:56712 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932438AbWCHJHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:07:54 -0500
X-Authenticated: #704063
Subject: [Patch] Fix dead code in cdrom/gscd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: raupach@nwfs1.rz.fh-hannover.de
Content-Type: text/plain
Date: Wed, 08 Mar 2006 10:07:51 +0100
Message-Id: <1141808871.6355.5.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes Coverity Bugs #21 and #22. In both cases the
do { ... } while (result != 6 || result == 0x0E) just
finishes for result == 6, so the if(result != 6) doesnt
make much sense.

This patch simply removes the if statement, so the logic
stays the same.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-rc5-mm1/drivers/cdrom/gscd.c.orig	2006-03-08 09:56:30.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/cdrom/gscd.c	2006-03-08 09:58:18.000000000 +0100
@@ -695,10 +695,6 @@ static void cmd_read_b(char *pb, int cou
 			result = wait_drv_ready();
 		} while (result != 6 || result == 0x0E);
 
-		if (result != 6) {
-			cmd_end();
-			return;
-		}
 #ifdef GSCD_DEBUG
 		printk("LOC_191 ");
 #endif
@@ -763,11 +759,6 @@ static void cmd_read_w(char *pb, int cou
 			result = wait_drv_ready();
 		} while (result != 6 || result == 0x0E);
 
-		if (result != 6) {
-			cmd_end();
-			return;
-		}
-
 		for (i = 0; i < size; i++) {
 			/* na, hier muss ich noch mal drueber nachdenken */
 			*pb = inw(GSCDPORT(2));



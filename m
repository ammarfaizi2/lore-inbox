Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVBQTcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVBQTcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVBQTcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:32:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57475 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262376AbVBQTZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:25:56 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200502171925.j1HJPmAC107576@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : Ignore input during early boot
To: linux-kernel@vger.kernel.org
Date: Thu, 17 Feb 2005 13:25:47 -0600 (CST)
Cc: akpm@osdl.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6 Altix console patch to ignore input during early booting

Signed-off-by: Patrick Gefre <pfg@sgi.com>

#### diffstat
 sn_console.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)




# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/17 13:15:56-06:00 pfg@sgi.com 
#   Don't bother checking for input during early printing
# 
# drivers/serial/sn_console.c
#   2005/02/17 13:15:43-06:00 pfg@sgi.com +5 -2
#   Don't bother checking for input during early printing
#   Update copyright
# 
diff -Nru a/drivers/serial/sn_console.c b/drivers/serial/sn_console.c
--- a/drivers/serial/sn_console.c	2005-02-17 13:19:01 -06:00
+++ b/drivers/serial/sn_console.c	2005-02-17 13:19:01 -06:00
@@ -6,7 +6,7 @@
  * driver for that.
  *
  *
- * Copyright (c) 2004 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2004-2005 Silicon Graphics, Inc.  All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -104,6 +104,7 @@
 };
 
 static struct sn_cons_port sal_console_port;
+static int sn_process_input;
 
 /* Only used if USE_DYNAMIC_MINOR is set to 1 */
 static struct miscdevice misc;	/* used with misc_register for dynamic */
@@ -681,7 +682,8 @@
 
 	if (!port->sc_port.irq) {
 		spin_lock_irqsave(&port->sc_port.lock, flags);
-		sn_receive_chars(port, NULL, flags);
+		if ( sn_process_input )
+			sn_receive_chars(port, NULL, flags);
 		sn_transmit_chars(port, TRANSMIT_RAW);
 		spin_unlock_irqrestore(&port->sc_port.lock, flags);
 		mod_timer(&port->sc_timer,
@@ -878,6 +880,7 @@
 	if (!IS_RUNNING_ON_SIMULATOR()) {
 		sn_sal_switch_to_interrupts(&sal_console_port);
 	}
+	sn_process_input = 1;
 	return 0;
 }

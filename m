Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271758AbTGROBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271765AbTGROBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:01:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18565
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271758AbTGRN75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:59:57 -0400
Date: Fri, 18 Jul 2003 15:14:17 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181414.h6IEEHve017720@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: use cpu_relax in seq8005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/net/seeq8005.c linux-2.6.0-test1-ac2/drivers/net/seeq8005.c
--- linux-2.6.0-test1/drivers/net/seeq8005.c	2003-07-10 21:12:51.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/net/seeq8005.c	2003-07-15 17:34:48.000000000 +0100
@@ -700,7 +700,8 @@
  * wait_for_buffer
  *
  * This routine waits for the SEEQ chip to assert that the FIFO is ready
- * by checking for a window interrupt, and then clearing it
+ * by checking for a window interrupt, and then clearing it. This has to
+ * occur in the interrupt handler!
  */
 inline void wait_for_buffer(struct net_device * dev)
 {
@@ -710,7 +711,7 @@
 	
 	tmp = jiffies + HZ;
 	while ( ( ((status=inw(SEEQ_STATUS)) & SEEQSTAT_WINDOW_INT) != SEEQSTAT_WINDOW_INT) && time_before(jiffies, tmp))
-		mb();
+		cpu_relax();
 		
 	if ( (status & SEEQSTAT_WINDOW_INT) == SEEQSTAT_WINDOW_INT)
 		outw( SEEQCMD_WINDOW_INT_ACK | (status & SEEQCMD_INT_MASK), SEEQ_CMD);

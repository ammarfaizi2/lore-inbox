Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUHISzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUHISzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHISyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:54:33 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:6858 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S266870AbUHISxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:53:06 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] QLogic ISP2x00: remove needless busyloop
Date: Mon, 9 Aug 2004 12:52:58 -0600
User-Agent: KMail/1.6.2
Cc: ehm@cris.com, grif@cs.ucr.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091252.58547.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to wait for an isp2x00 to recognize a fabric if
there's no isp2x00.  Probably nobody will notice the unnecessary
slowdown on real hardware, but it's a significant delay on a
simulator.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com.

===== drivers/scsi/qlogicfc.c 1.44 vs edited =====
--- 1.44/drivers/scsi/qlogicfc.c	2004-06-06 05:17:21 -06:00
+++ edited/drivers/scsi/qlogicfc.c	2004-08-09 12:23:06 -06:00
@@ -815,9 +815,11 @@
 	   some time before recognizing it is attached to a fabric */
 
 #if ISP2x00_FABRIC
-	for (wait_time = jiffies + 5 * HZ; time_before(jiffies, wait_time);) {
-		barrier();
-		cpu_relax();
+	if (hosts) {
+		for (wait_time = jiffies + 5 * HZ; time_before(jiffies, wait_time);) {
+			barrier();
+			cpu_relax();
+		}
 	}
 #endif
 

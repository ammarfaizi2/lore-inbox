Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVAPN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVAPN6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAPN57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:57:59 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:24458 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262509AbVAPNxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:05 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135304.30109.72310.38224@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 6/13] ip2: remove cli()/sti() in drivers/char/ip2main.c
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:04 -0600
Date: Sun, 16 Jan 2005 07:53:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/ip2main.c linux-2.6.11-rc1-mm1/drivers/char/ip2main.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/ip2main.c	2005-01-16 07:17:19.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/ip2main.c	2005-01-16 07:32:19.311554798 -0500
@@ -2205,9 +2205,9 @@
 	 * for masking). Caller should use TIOCGICOUNT to see which one it was
 	 */
 	case TIOCMIWAIT:
-		save_flags(flags);cli();
+		local_irq_save(flags);
 		cprev = pCh->icount;	 /* note the counters on entry */
-		restore_flags(flags);
+		local_irq_restore(flags);
 		i2QueueCommands(PTYPE_BYPASS, pCh, 100, 4, 
 						CMD_DCD_REP, CMD_CTS_REP, CMD_DSR_REP, CMD_RI_REP);
 		init_waitqueue_entry(&wait, current);
@@ -2227,9 +2227,9 @@
 				rc = -ERESTARTSYS;
 				break;
 			}
-			save_flags(flags);cli();
+			local_irq_save(flags);
 			cnow = pCh->icount; /* atomic copy */
-			restore_flags(flags);
+			local_irq_restore(flags);
 			if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
 				cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
 				rc =  -EIO; /* no change => rc */
@@ -2267,9 +2267,9 @@
 	case TIOCGICOUNT:
 		ip2trace (CHANN, ITRC_IOCTL, 11, 1, rc );
 
-		save_flags(flags);cli();
+		local_irq_save(flags);
 		cnow = pCh->icount;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		p_cuser = argp;
 		rc = put_user(cnow.cts, &p_cuser->cts);
 		rc = put_user(cnow.dsr, &p_cuser->dsr);

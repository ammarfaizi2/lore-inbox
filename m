Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUCPOL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCPNzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:55:19 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:53459 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S261700AbUCPNuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:50:11 -0500
Date: Tue, 16 Mar 2004 14:49:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/10): sclp fix.
Message-ID: <20040316134955.GD2785@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sclp console fixes:
  - Replace irq_enter/irq_exit pair with Add local_bh_enable/local_bh_disable.

diffstat:
 drivers/s390/char/sclp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urN linux-2.6/drivers/s390/char/sclp.c linux-2.6-s390/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	Thu Mar 11 03:55:35 2004
+++ linux-2.6-s390/drivers/s390/char/sclp.c	Tue Mar 16 14:03:07 2004
@@ -335,8 +335,8 @@
 	unsigned long psw_mask;
 	unsigned long cr0, cr0_sync;
 
-	/* Need to irq_enter() to prevent BH from executing. */
-	irq_enter();
+	/* Prevent BH from executing. */
+	local_bh_disable();
 	/*
 	 * save cr0
 	 * enable service signal external interruption (cr0.22)
@@ -365,7 +365,7 @@
 
 	/* restore cr0 */
 	__ctl_load(cr0, 0, 0);
-	irq_exit();
+	__local_bh_enable();
 }
 
 /*

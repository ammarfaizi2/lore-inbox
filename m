Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTFIAbk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbTFIAbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:31:40 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:8182 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264099AbTFIAbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:31:37 -0400
Date: Sun, 8 Jun 2003 20:21:29 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: scott.feldman@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH?] e100: 'cu_start: timeout waiting for cu'
Message-ID: <20030608202129.A18754@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e100 version 2.3.13-k1 added in 2.5.70 does not work in my system
(dual ppro, eepro100b card). dmesg says:

e100: eth0: cu_start: timeout waiting for cu

I tracked the problem to the reset changes in e100_phy.c. The patch
below solves the problem for me, as does removing the new e100_phy_reset()
call altogether. I've little clue what the right fix is, so this may be
totally bogus.

--Adam

--- linux-2.5.70/drivers/net/e100/e100_phy.c	Tue May 27 18:20:46 2003
+++ linux-2.5.70-play/drivers/net/e100/e100_phy.c	Sun Jun  8 20:33:47 2003
@@ -919,6 +919,7 @@
 unsigned char __devinit
 e100_phy_init(struct e100_private *bdp)
 {
+	e100_phy_reset(bdp);
 	e100_phy_address_detect(bdp);
 	e100_phy_isolate(bdp);
 	e100_phy_id_detect(bdp);
@@ -930,7 +931,6 @@
 	bdp->PhyDelay = 0;
 	bdp->zlock_state = ZLOCK_INITIAL;
 
-	e100_phy_reset(bdp);
 	e100_phy_set_speed_duplex(bdp, false);
 	e100_fix_polarity(bdp);
 


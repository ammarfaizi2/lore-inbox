Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVHDVoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVHDVoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVHDVnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:43:10 -0400
Received: from tim.rpsys.net ([194.106.48.114]:20418 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262735AbVHDVk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:40:59 -0400
Subject: [patch] Fix a bit/byte counting error in the MMC/SD code
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       Pierre Ossman <drzeus@drzeus.cx>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 22:40:40 +0100
Message-Id: <1123191640.8987.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes what looks like a bit/byte counting error in the MMC/SD code
which was causing data corruption (in the -mm tree).

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.12.orig/drivers/mmc/mmc.c	2005-08-04 22:27:44.000000000 +0100
+++ linux-2.6.12/drivers/mmc/mmc.c	2005-08-04 22:30:02.000000000 +0100
@@ -923,7 +923,7 @@
 		mrq.cmd = &cmd;
 		mrq.data = &data;
 
-		sg_init_one(&sg, (u8*)card->raw_scr, 64);
+		sg_init_one(&sg, (u8*)card->raw_scr, 8);
 
 		err = mmc_wait_for_req(host, &mrq);
 		if (err != MMC_ERR_NONE) {


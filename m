Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTFYBNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTFYBMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:12:46 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:62862 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263631AbTFYBKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:10:54 -0400
Date: Tue, 24 Jun 2003 20:59:57 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.5.73
Message-ID: <20030624205957.GD14945@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030624205918.GC14945@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624205918.GC14945@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1387  -> 1.1388 
#	drivers/pnp/manager.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/24	ambx1@neo.rr.com	1.1388
# [PNP] Locking Fixes
# 
# The semaphore in pnp_init_resource_table is not needed and, in some
# cases, can cause resource management lockups.  This patch removes the
# improperly placed semaphore.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Tue Jun 24 20:34:17 2003
+++ b/drivers/pnp/manager.c	Tue Jun 24 20:34:17 2003
@@ -193,7 +193,6 @@
 void pnp_init_resource_table(struct pnp_resource_table *table)
 {
 	int idx;
-	down(&pnp_res_mutex);
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
 		table->irq_resource[idx].name = NULL;
 		table->irq_resource[idx].start = -1;
@@ -218,7 +217,6 @@
 		table->mem_resource[idx].end = 0;
 		table->mem_resource[idx].flags = IORESOURCE_AUTO;
 	}
-	up(&pnp_res_mutex);
 }
 
 /**

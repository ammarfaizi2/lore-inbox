Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWFUU7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWFUU7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWFUU7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:59:44 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:50151 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030282AbWFUU7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:59:43 -0400
Date: Wed, 21 Jun 2006 22:59:42 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/6] cpu_relax(): ide_wait_stat()
Message-ID: <20060621205942.GB22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add cpu_relax() to drivers/ide/ide-iops.c/ide_wait_stat().
Tiny whitespace fix.


Should be quite useful.

Tested on 2.6.17-mm1.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/drivers/ide/ide-iops.c linux-2.6.17-mm1.my/drivers/ide/ide-iops.c
--- linux-2.6.17-mm1.orig/drivers/ide/ide-iops.c	2006-06-21 14:28:16.000000000 +0200
+++ linux-2.6.17-mm1.my/drivers/ide/ide-iops.c	2006-06-21 22:00:02.000000000 +0200
@@ -542,7 +542,7 @@
 	u8 stat;
 	int i;
 	unsigned long flags;
- 
+
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
 		*startstop = ide_stopped;
@@ -554,6 +554,7 @@
 		local_irq_set(flags);
 		timeout += jiffies;
 		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
+			cpu_relax();
 			if (time_after(jiffies, timeout)) {
 				/*
 				 * One last read after the timeout in case

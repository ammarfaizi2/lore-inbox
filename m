Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272855AbTHEV3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272868AbTHEV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:29:22 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:26533 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272855AbTHEV3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:29:21 -0400
Date: Tue, 5 Aug 2003 23:29:18 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: alan@lxorguk.ukuu.org.uk
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] clarify why DMA gets disabled on broken drives
Message-ID: <20030805212918.GB22909@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I just ran into this and had to look at the sources to find out why
the IDE driver was turning off DMA for a particular drive.

(It's nice to see that this actually works, btw. 8))

- 
Tomas Szepe <szepe@pinerecords.com>

Patch against 2.4.22-rc1.

diff -urN a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2003-08-05 23:20:48.000000000 +0200
+++ b/drivers/ide/ide-dma.c	2003-08-05 23:24:22.000000000 +0200
@@ -835,7 +835,8 @@
 #ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
 	int blacklist = in_drive_list(id, drive_blacklist);
 	if (blacklist) {
-		printk("%s: Disabling (U)DMA for %s\n", drive->name, id->model);
+		printk("%s: Disabling (U)DMA for %s (on blacklist)\n",
+			drive->name, id->model);
 		return(blacklist);
 	}
 #else /* !CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
@@ -844,7 +845,7 @@
 	list = bad_dma_drives;
 	while (*list) {
 		if (!strcmp(*list++,id->model)) {
-			printk("%s: Disabling (U)DMA for %s\n",
+			printk("%s: Disabling (U)DMA for %s (on blacklist)\n",
 				drive->name, id->model);
 			return 1;
 		}

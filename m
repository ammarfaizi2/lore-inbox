Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272441AbTHEVhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272518AbTHEVhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:37:18 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:27813 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272441AbTHEVhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:37:13 -0400
Date: Tue, 5 Aug 2003 23:37:08 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] clarify why DMA gets disabled on broken drives
Message-ID: <20030805213708.GC22909@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartolomiej,

I just ran into this and had to look at the sources to find out why
the IDE driver was turning off DMA for a particular drive.

-- 
Tomas Szepe <szepe@pinerecords.com>

Patch against 2.6.0-test2-bk5.

diff -urN a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2003-07-27 19:50:57.000000000 +0200
+++ b/drivers/ide/ide-dma.c	2003-08-05 23:33:13.000000000 +0200
@@ -767,7 +767,8 @@
 
 	int blacklist = in_drive_list(id, drive_blacklist);
 	if (blacklist) {
-		printk(KERN_WARNING "%s: Disabling (U)DMA for %s\n", drive->name, id->model);
+		printk(KERN_WARNING "%s: Disabling (U)DMA for %s (on blacklist)\n",
+			drive->name, id->model);
 		return(blacklist);
 	}
 	return 0;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUDFUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbUDFUGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:06:16 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:17671 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263895AbUDFUGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:06:14 -0400
Date: Tue, 6 Apr 2004 15:16:07 -0500
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss uipdates for 2.6.6xxx [2/2]
Message-ID: <20040406201607.GC2554@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug where /proc displays 1 less logical volume than is actually configured. This causes problems for some installers.
Please consider this for inclusion.

mikem
-------------------------------------------------------------------------------

diff -burpN lx265-t1/drivers/block/cciss.c lx265-t2/drivers/block/cciss.c
--- lx265-t1/drivers/block/cciss.c	2004-04-06 14:16:39.000000000 -0500
+++ lx265-t2/drivers/block/cciss.c	2004-04-06 14:21:43.000000000 -0500
@@ -210,7 +210,7 @@ static int cciss_proc_get_info(char *buf
 
         pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
-	for(i=0; i<h->highest_lun; i++) {
+	for(i=0; i<=h->highest_lun; i++) {
 		sector_t tmp;
 
                 drv = &h->drv[i];

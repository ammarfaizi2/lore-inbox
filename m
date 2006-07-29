Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWG2P7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWG2P7J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 11:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWG2P7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 11:59:09 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:41865 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S1751124AbWG2P7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 11:59:08 -0400
Date: Sat, 29 Jul 2006 11:58:56 -0400
From: Jason Lunz <lunz@falooley.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [patch] ide: eliminate redundant case in start_request()
Message-ID: <20060729155855.GB3072@opus.vpn-dev.reflex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Collapse two redundant calls to execute_drive_cmd() in start_request().

Signed-off-by: Jason Lunz <lunz@falooley.org>

---
I can't think of any reason to separate out the two callsites unless
there's some future expansion planned here or something.

 drivers/ide/ide-io.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.18-rc2-git6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.18-rc2-git6.orig/drivers/ide/ide-io.c
+++ linux-2.6.18-rc2-git6/drivers/ide/ide-io.c
@@ -1014,9 +1014,7 @@
 	if (!drive->special.all) {
 		ide_driver_t *drv;
 
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK))
-			return execute_drive_cmd(drive, rq);
-		else if (rq->flags & REQ_DRIVE_TASKFILE)
+		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE))
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
 			struct request_pm_state *pm = rq->end_io_data;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262456AbSJNVD5>; Mon, 14 Oct 2002 17:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSJNVD5>; Mon, 14 Oct 2002 17:03:57 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:17 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S262456AbSJNVD4>; Mon, 14 Oct 2002 17:03:56 -0400
Date: Mon, 14 Oct 2002 15:06:00 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.42, cciss, no scsi tape timeouts (1 of 7)
Message-ID: <20021014150600.A1257@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have re-done our cciss patches for 2.5.42, and reordered them so that 
smaller/simpler/important ones are first, bigger more complicated/less 
important ones are last to make them easier to swallow.

Here's the first:  patch (1 of 7) 
This patch eliminates the timeout on scsi commands to tape drives.
The driver doesn't do anything good if the command times out, and the
timeout is too short.  Better to have no timeout.

-- steve

diff -urN linux-2.5.42-a/drivers/block/cciss_scsi.c linux-2.5.42-b/drivers/block/cciss_scsi.c
--- linux-2.5.42-a/drivers/block/cciss_scsi.c	Fri Sep 27 16:49:15 2002
+++ linux-2.5.42-b/drivers/block/cciss_scsi.c	Mon Oct 14 10:08:24 2002
@@ -913,7 +913,7 @@
 
 	memset(cp->Request.CDB, 0, sizeof(cp->Request.CDB));
 	memcpy(cp->Request.CDB, cdb, cdblen);
-	cp->Request.Timeout = 1000;		// guarantee completion. 
+	cp->Request.Timeout = 0;
 	cp->Request.CDBLen = cdblen;
 	cp->Request.Type.Type = TYPE_CMD;
 	cp->Request.Type.Attribute = ATTR_SIMPLE;
@@ -1445,7 +1445,7 @@
 	
 	// Fill in the request block...
 
-	cp->Request.Timeout = 1000; // guarantee completion
+	cp->Request.Timeout = 0;
 	memset(cp->Request.CDB, 0, sizeof(cp->Request.CDB));
 	if (cmd->cmd_len > sizeof(cp->Request.CDB)) BUG();
 	cp->Request.CDBLen = cmd->cmd_len;

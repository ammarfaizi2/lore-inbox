Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSJPVdI>; Wed, 16 Oct 2002 17:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJPVdH>; Wed, 16 Oct 2002 17:33:07 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:19464 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261436AbSJPVch>; Wed, 16 Oct 2002 17:32:37 -0400
Date: Wed, 16 Oct 2002 15:34:51 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 2/8] 2.5.43 cciss no tape timeouts
Message-ID: <20021016153451.B2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes scsi commands to tape drives have no timeouts.
Previously the timeout was 1000 seconds, too short, and nothing good
happens when the timeout expires.  Better to have no timeout.

diff -urN linux-2.5.43-a/drivers/block/cciss_scsi.c linux-2.5.43-b/drivers/block/cciss_scsi.c
--- linux-2.5.43-a/drivers/block/cciss_scsi.c	Fri Sep 27 16:49:15 2002
+++ linux-2.5.43-b/drivers/block/cciss_scsi.c	Wed Oct 16 08:15:17 2002
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbSJIO3x>; Wed, 9 Oct 2002 10:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSJIO3x>; Wed, 9 Oct 2002 10:29:53 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:26130 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S261766AbSJIO3v>; Wed, 9 Oct 2002 10:29:51 -0400
Date: Wed, 9 Oct 2002 08:31:39 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss, no tape timeouts (1 of 5)
Message-ID: <20021009083139.A6746@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes scsi commands sent to tape drives from the cciss driver
have no timeout instead of a 1000 second timeout.  With the current
code, When the timeout expires, nothing good happens so probably better 
to have no timeout.  Applies to 2.5.39.

-- steve

diff -urN lx2539/drivers/block/cciss_scsi.c lx2539-1/drivers/block/cciss_scsi.c
--- lx2539/drivers/block/cciss_scsi.c	Fri Sep 27 16:49:15 2002
+++ lx2539-1/drivers/block/cciss_scsi.c	Tue Oct  1 14:09:06 2002
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

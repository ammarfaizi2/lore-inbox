Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265053AbSJWP0y>; Wed, 23 Oct 2002 11:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265054AbSJWP0y>; Wed, 23 Oct 2002 11:26:54 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:61965 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265053AbSJWP0w>; Wed, 23 Oct 2002 11:26:52 -0400
Date: Wed, 23 Oct 2002 09:29:09 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/10] 2.5.44 cciss no scsi tape timeouts
Message-ID: <20021023092909.D14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 4 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

This patch makes scsi commands to tape drives have no timeouts.
Previously the timeout was 1000 seconds, too short, and nothing good
happens when the timeout expires.  Better to have no timeout.


 drivers/block/cciss_scsi.c |    4 ++--
 1 files changed, 2 insertions, 2 deletions

--- linux-2.5.44/drivers/block/cciss_scsi.c~no_tape_timeouts	Mon Oct 21 12:05:48 2002
+++ linux-2.5.44-root/drivers/block/cciss_scsi.c	Mon Oct 21 12:05:48 2002
@@ -913,7 +913,7 @@ cciss_scsi_do_simple_cmd(ctlr_info_t *c,
 
 	memset(cp->Request.CDB, 0, sizeof(cp->Request.CDB));
 	memcpy(cp->Request.CDB, cdb, cdblen);
-	cp->Request.Timeout = 1000;		// guarantee completion. 
+	cp->Request.Timeout = 0;
 	cp->Request.CDBLen = cdblen;
 	cp->Request.Type.Type = TYPE_CMD;
 	cp->Request.Type.Attribute = ATTR_SIMPLE;
@@ -1427,7 +1427,7 @@ cciss_scsi_queue_command (Scsi_Cmnd *cmd
 	
 	// Fill in the request block...
 
-	cp->Request.Timeout = 1000; // guarantee completion
+	cp->Request.Timeout = 0;
 	memset(cp->Request.CDB, 0, sizeof(cp->Request.CDB));
 	if (cmd->cmd_len > sizeof(cp->Request.CDB)) BUG();
 	cp->Request.CDBLen = cmd->cmd_len;

.

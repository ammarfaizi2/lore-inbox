Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbTBLTJV>; Wed, 12 Feb 2003 14:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTBLTJV>; Wed, 12 Feb 2003 14:09:21 -0500
Received: from inmail.compaq.com ([161.114.1.206]:32016 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S267651AbTBLTJU>; Wed, 12 Feb 2003 14:09:20 -0500
Date: Wed, 12 Feb 2003 13:19:43 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071943.GG1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For the cciss driver:
This patch makes scsi commands to tape drives have no timeouts.
Previously the timeout was 1000 seconds, too short, and nothing good
happens when the timeout expires.  Better to have no timeout.
e.g. mt -f /dev/st0 erase may take about 2 hours 30 min on AIT 100.
(patch 7 of 11)

-- steve

--- linux-2.5.60/drivers/block/cciss_scsi.c~no_tape_timeouts	2003-02-12 10:13:05.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss_scsi.c	2003-02-12 10:13:05.000000000 +0600
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

_

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268321AbTBNVS7>; Fri, 14 Feb 2003 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268237AbTBNVST>; Fri, 14 Feb 2003 16:18:19 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:49708 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S268313AbTBNVRp>; Fri, 14 Feb 2003 16:17:45 -0500
Date: Fri, 14 Feb 2003 16:27:18 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60-bk4] fix compile breakage on drivers/scsi/seagate.c
Message-ID: <Pine.LNX.4.53.0302141625590.21601@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes compile breakage due to recent changes to scsi.h

John Kim


--- linux-2.5.60-bk4/drivers/scsi/seagate.c	2003-02-10 13:38:29.000000000 -0500
+++ linux-2.5.60-bk4-new/drivers/scsi/seagate.c	2003-02-14 15:37:52.000000000 -0500
@@ -683,8 +683,8 @@
 
 	DANY ("seagate: que_command");
 	done_fn = done;
-	current_target = SCpnt->target;
-	current_lun = SCpnt->lun;
+	current_target = SCpnt->device->id;
+	current_lun = SCpnt->device->lun;
 	current_cmnd = SCpnt->cmnd;
 	current_data = (unsigned char *) SCpnt->request_buffer;
 	current_bufflen = SCpnt->request_bufflen;
@@ -713,7 +713,7 @@
 #endif				/* LINKED */
 			reconnect = CAN_RECONNECT;
 
-		result = internal_command(SCint->target, SCint->lun, SCint->cmnd,
+		result = internal_command(SCint->device->id, SCint->device->lun, SCint->cmnd,
 				      SCint->request_buffer, SCint->request_bufflen, reconnect);
 		if (msg_byte(result) == DISCONNECT)
 			break;
@@ -729,7 +729,7 @@
 
 static int seagate_st0x_command(Scsi_Cmnd * SCpnt)
 {
-	return internal_command (SCpnt->target, SCpnt->lun, SCpnt->cmnd,
+	return internal_command (SCpnt->device->id, SCpnt->device->lun, SCpnt->cmnd,
 				 SCpnt->request_buffer, SCpnt->request_bufflen,
 				 (int) NO_RECONNECT);
 }

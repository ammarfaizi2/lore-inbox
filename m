Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTE2Osu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTE2Osq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:48:46 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:15587 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S262284AbTE2Osf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:48:35 -0400
Message-ID: <3ED620BC.3030309@cox.net>
Date: Thu, 29 May 2003 11:01:16 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix compilation errors in ppa and imm modules
Content-Type: multipart/mixed;
 boundary="------------020705000305090408010908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705000305090408010908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is a resend since it has yet to be applied in either bk2 or 
bk3. It is a patch that fixes compilation failures in ppa.c and imm.c 
with 2.5.70-bk*.
Applies cleanly with all snapshots of 2.5.70.

* Removes the 'int hostno' parameter from imm_proc_info().
Parameter isn't used and breaks the pointer matching for Scsi_Host.
* Added the prototype for imm_proc_info() in imm.h
* Modified line 280 of ppa.c to match concept on line 263 of imm.c.

Thanks,
David

--------------020705000305090408010908
Content-Type: text/plain;
 name="patch-dvh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dvh.diff"

diff -Nru a/drivers/scsi/imm.c b/drivers/scsi/imm.c
--- a/drivers/scsi/imm.c	2003-05-27 12:09:47.000000000 -0400
+++ b/drivers/scsi/imm.c	2003-05-27 12:05:29.000000000 -0400
@@ -254,7 +254,7 @@
 }
 
 int imm_proc_info(struct Scsi_Host *host, char *buffer, char **start, off_t offset,
-		  int length, int hostno, int inout)
+		  int length, int inout)
 {
     int i;
     int len = 0;
diff -Nru a/drivers/scsi/imm.h b/drivers/scsi/imm.h
--- a/drivers/scsi/imm.h	2003-05-27 12:09:47.000000000 -0400
+++ b/drivers/scsi/imm.h	2003-05-27 12:05:11.000000000 -0400
@@ -159,6 +159,7 @@
 int imm_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
 int imm_abort(Scsi_Cmnd *);
 int imm_reset(Scsi_Cmnd *);
+int imm_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
 int imm_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
 
diff -Nru a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
--- a/drivers/scsi/ppa.c	2003-05-27 12:09:47.000000000 -0400
+++ b/drivers/scsi/ppa.c	2003-05-27 11:56:01.000000000 -0400
@@ -277,7 +277,7 @@
     int len = 0;
 
     for (i = 0; i < 4; i++)
-	if (ppa_hosts[i] == host)
+	if (ppa_hosts[i].host == host->host_no)
 	    break;
 
     if (inout)

--------------020705000305090408010908--


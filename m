Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318415AbSGSBCP>; Thu, 18 Jul 2002 21:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318416AbSGSBCP>; Thu, 18 Jul 2002 21:02:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1313 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318415AbSGSBCM>; Thu, 18 Jul 2002 21:02:12 -0400
Date: Thu, 18 Jul 2002 21:05:13 -0400
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpq driver compile fix
Message-ID: <20020718210513.B28235@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes the cpq driver's usage of sr_request (very trivial 
actually).  Please drop this in place and the cpq driver should start 
working again.  Thanks.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpq.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.630   -> 1.631  
#	drivers/scsi/cpqfcTSinit.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/16	dledford@perf50.perf.redhat.com	1.631
# cpqfcTSinit.c:
#   Fix usage of Scsi_Cmnd->request so it will compile.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/cpqfcTSinit.c b/drivers/scsi/cpqfcTSinit.c
--- a/drivers/scsi/cpqfcTSinit.c	Tue Jul 16 14:24:52 2002
+++ b/drivers/scsi/cpqfcTSinit.c	Tue Jul 16 14:24:52 2002
@@ -475,7 +475,7 @@
 {
     struct request * req;
     
-    req = &SCpnt->request;
+    req = SCpnt->request;
     req->rq_status = RQ_SCSI_DONE; /* Busy, but indicate request done */
   
     if (req->CPQFC_WAITING != NULL)
@@ -601,7 +601,7 @@
 
         {
           CPQFC_DECLARE_COMPLETION(wait);
-          ScsiPassThruCmnd->request.CPQFC_WAITING = &wait;
+          ScsiPassThruCmnd->request->CPQFC_WAITING = &wait;
           // eventually gets us to our own _quecommand routine
           scsi_do_cmd( ScsiPassThruCmnd, &vendor_cmd->cdb[0], 
 	       buf, 
@@ -611,7 +611,7 @@
           // Other I/Os can now resume; we wait for our ioctl
 	  // command to complete
 	  CPQFC_WAIT_FOR_COMPLETION(&wait);
-          ScsiPassThruCmnd->request.CPQFC_WAITING = NULL;
+          ScsiPassThruCmnd->request->CPQFC_WAITING = NULL;
         }
 	
         result = ScsiPassThruCmnd->result;
@@ -1543,10 +1543,10 @@
         
     SCpnt->SCp.buffers_residual = FCP_TARGET_RESET;
 
-	SCpnt->request.CPQFC_WAITING = &wait;
+	SCpnt->request->CPQFC_WAITING = &wait;
 	scsi_do_cmd(SCpnt,  scsi_cdb, NULL,  0, my_ioctl_done,  timeout, retries);
 	CPQFC_WAIT_FOR_COMPLETION(&wait);
-	SCpnt->request.CPQFC_WAITING = NULL;
+	SCpnt->request->CPQFC_WAITING = NULL;
   }
     
 /*

--z6Eq5LdranGa6ru8--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVHPJNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVHPJNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVHPJNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:13:10 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:24006 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965150AbVHPJNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:13:10 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] remove dead reset function from cpqfcTS driver
Date: Tue, 16 Aug 2005 11:11:06 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508091806.45341@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508091806.45341@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508161111.08070@bilbo.math.uni-mannheim.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpqfcTS_reset() is never referenced from anywhere. By using the nonexistent 
constant SCSI_RESET_ERROR it causes just another unneeded compile error.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- a/drivers/scsi/cpqfcTSinit.c	2005-08-13 09:34:20.000000000 +0200
+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-13 10:36:19.000000000 +0200
@@ -1693,16 +1695,6 @@ int cpqfcTS_eh_device_reset(Scsi_Cmnd *C
   return retval;
 }
 
-	
-int cpqfcTS_reset(Scsi_Cmnd *Cmnd, unsigned int reset_flags)
-{
-
-  ENTER("cpqfcTS_reset");
-
-  LEAVE("cpqfcTS_reset");
-  return SCSI_RESET_ERROR;      /* Bus Reset Not supported */
-}
-
 /* This function determines the bios parameters for a given
    harddisk. These tend to be numbers that are made up by the
    host adapter.  Parameters:
--- a/drivers/scsi/cpqfcTS.h	2005-08-07 20:18:56.000000000 +0200
+++ b/drivers/scsi/cpqfcTS.h	2005-08-13 14:02:44.000000000 +0200
@@ -9,7 +9,6 @@ extern const char * cpqfcTS_info(struct 
 extern int cpqfcTS_proc_info(struct Scsi_Host *, char *, char **, off_t, int, 
int);
 extern int cpqfcTS_queuecommand(Scsi_Cmnd *, void (* done)(Scsi_Cmnd *));
 extern int cpqfcTS_abort(Scsi_Cmnd *);
-extern int cpqfcTS_reset(Scsi_Cmnd *, unsigned int);
 extern int cpqfcTS_eh_abort(Scsi_Cmnd *Cmnd);
 extern int cpqfcTS_eh_device_reset(Scsi_Cmnd *);
 extern int cpqfcTS_biosparam(struct scsi_device *, struct block_device *,

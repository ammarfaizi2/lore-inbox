Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSLKFsC>; Wed, 11 Dec 2002 00:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSLKFsC>; Wed, 11 Dec 2002 00:48:02 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37136
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265587AbSLKFsB>; Wed, 11 Dec 2002 00:48:01 -0500
Subject: [PATCH] printks in drivers/scsi/hosts.c missing return
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039586156.4384.16.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 00:55:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus is away so I am just throwing this out on lkml...

Trivial but annoying: two printk() calls in drivers/scsi/hosts.c are
missing '\n'

Also, for some reason I have not yet investigated, shost_tp->name is
NULL here.  This should not be, eh?  If it can be, we should do
something to tidy up the printing of it.

Patch is against 2.5.51.

	Robert Love

 drivers/scsi/hosts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -urN linux-2.5.51-mm1/drivers/scsi/hosts.c linux/drivers/scsi/hosts.c
--- linux-2.5.51-mm1/drivers/scsi/hosts.c	2002-12-10 17:45:02.000000000 -0500
+++ linux/drivers/scsi/hosts.c	2002-12-11 00:40:28.000000000 -0500
@@ -488,14 +488,14 @@
 	if (!shost_tp->max_sectors) {
 		printk(KERN_WARNING
 		    "scsi HBA driver %s didn't set max_sectors, "
-		    "please fix the template", shost_tp->name);
+		    "please fix the template\n", shost_tp->name);
 		shost_tp->max_sectors = 1024;
 	}
 
 	if (!shost_tp->release) {
 		printk(KERN_WARNING
 		    "scsi HBA driver %s didn't set a release method, "
-		    "please fix the template", shost_tp->name);
+		    "please fix the template\n", shost_tp->name);
 		shost_tp->release = &scsi_host_legacy_release;
 	}
 





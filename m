Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbTH2S4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbTH2S4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:56:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37874 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261666AbTH2S4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:56:42 -0400
Date: Fri, 29 Aug 2003 20:56:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@connectcom.net
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.6 patch] fix advansys.c if !CONFIG_PROC_FS
Message-ID: <20030829185631.GG7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a compile error in drivers/scsi/advansys.c if 
!CONFIG_PROC_FS.

Please apply
Adrian

--- linux-2.6.0-test4-mm1/drivers/scsi/advansys.c.old	2003-08-27 16:14:32.000000000 +0200
+++ linux-2.6.0-test4-mm1/drivers/scsi/advansys.c	2003-08-27 16:15:54.000000000 +0200
@@ -6199,7 +6199,9 @@
 
 static Scsi_Host_Template driver_template = {
     .proc_name                  = "advansys",
+#ifdef CONFIG_PROC_FS
     .proc_info                  = advansys_proc_info,
+#endif
     .name                       = "advansys",
     .detect                     = advansys_detect, 
     .release                    = advansys_release,

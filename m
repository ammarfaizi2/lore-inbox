Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRJ2PZy>; Mon, 29 Oct 2001 10:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275980AbRJ2PZo>; Mon, 29 Oct 2001 10:25:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:35339 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S275973AbRJ2PZe>;
	Mon, 29 Oct 2001 10:25:34 -0500
Subject: [PATCH] scsi compile warning fix
From: Robert Love <rml@tech9.net>
To: laughing@shared-source.org, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 29 Oct 2001 10:26:07 -0500
Message-Id: <1004369168.861.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/scsi.c : proc_scsi_gen_write is declared prior to its
formal definition.  it is not used before its definition, and thus the
prior declaration is pointless, generating a compile warning...

attached applies fine to 2.4.13-ac4...

diff -urN linux-2.4.13-ac2/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- linux-2.4.13-ac2/drivers/scsi/scsi.c	Fri Oct 26 15:47:59 2001
+++ linux/drivers/scsi/scsi.c	Fri Oct 26 23:34:20 2001
@@ -1515,9 +1515,6 @@
 	spin_unlock_irqrestore(&device_request_lock, flags);
 }
 
-static int proc_scsi_gen_write(struct file * file, const char * buf,
-                              unsigned long length, void *data);
-
 void __init scsi_host_no_insert(char *str, int n)
 {
     Scsi_Host_Name *shn, *shn2;


	Robert Love


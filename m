Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268272AbTALLv7>; Sun, 12 Jan 2003 06:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbTALLv7>; Sun, 12 Jan 2003 06:51:59 -0500
Received: from tag.witbe.net ([81.88.96.48]:8964 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S268272AbTALLvz>;
	Sun, 12 Jan 2003 06:51:55 -0500
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Cc: <rol@as2917.net>
Subject: [PATCH 2.5.56] Scsi not compiling without /proc support
Date: Sun, 12 Jan 2003 13:00:42 +0100
Organization: Witbe.net
Message-ID: <009001c2ba32$3b4bcdf0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This quick patch is used to remove calls to functions in charge of
registering/unregistering within /proc when /proc support is not
enabled.

Paul Rolland, rol@as2917.net

diff -uN linux-2.5.56/drivers/scsi/hosts.c
linux-2.5.56-work/drivers/scsi/hosts.c
--- linux-2.5.56/drivers/scsi/hosts.c   2003-01-10 21:11:20.000000000
+0100
+++ linux-2.5.56-work/drivers/scsi/hosts.c      2003-01-12
12:42:59.000000000 +0100
@@ -345,7 +345,9 @@
        shost->hostt->present--;
 
        /* Cleanup proc */
+#ifdef CONFIG_PROC_FS
        scsi_proc_host_rm(shost);
+#endif
 
        kfree(shost);
 }
@@ -456,7 +458,9 @@
 found:
        spin_unlock(&scsi_host_list_lock);
 
+#ifdef CONFIG_PROC_FS
        scsi_proc_host_add(shost);
+#endif
 
        shost->eh_notify = &sem;
        kernel_thread((int (*)(void *)) scsi_error_handler, (void *)
shost, 0);


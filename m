Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAJAbq>; Tue, 9 Jan 2001 19:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRAJAbk>; Tue, 9 Jan 2001 19:31:40 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:3332 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S130548AbRAJAbU>;
	Tue, 9 Jan 2001 19:31:20 -0500
Message-ID: <3A5BAD30.404B70CC@austin.rr.com>
Date: Tue, 09 Jan 2001 18:30:40 -0600
From: Anwar Payyoorayil <anwar@austin.rr.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: {PATCH] megaraid.c is broken in 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for the return value of I/O allocation is reversed. 

Patch against 2.4.0 follows. Definitely 2.4.1 material !!

--- linux/drivers/scsi/megaraid.c.orig  Wed Dec  6 14:06:18 2000
+++ linux/drivers/scsi/megaraid.c       Tue Jan  9 18:09:34 2001
@@ -1527,7 +1527,7 @@
     megaCtlrs[numCtlrs++] = megaCfg; 
     if (flag != BOARD_QUARTZ) {
       /* Request our IO Range */
-      if (request_region (megaBase, 16, "megaraid")) {
+      if (!request_region (megaBase, 16, "megaraid")) {
        printk (KERN_WARNING "megaraid: Couldn't register I/O range!" CRLFSTR);
        scsi_unregister (host);
        continue;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

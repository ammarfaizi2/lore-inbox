Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSKDWQw>; Mon, 4 Nov 2002 17:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbSKDWQw>; Mon, 4 Nov 2002 17:16:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262807AbSKDWQv>;
	Mon, 4 Nov 2002 17:16:51 -0500
Subject: [PATCH] aacraid compile problem 2.5.45+
From: Mark Haverkamp <markh@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 14:23:38 -0800
Message-Id: <1036448619.24054.9.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some compile problems in aachba.c

Mark.


===== drivers/scsi/aacraid/aachba.c 1.4 vs edited =====
--- 1.4/drivers/scsi/aacraid/aachba.c	Fri Nov  1 04:28:15 2002
+++ edited/drivers/scsi/aacraid/aachba.c	Mon Nov  4 14:14:26 2002
@@ -1113,12 +1113,12 @@
 	qd.locked = fsa_dev_ptr->locked[qd.cnum];
 	qd.deleted = fsa_dev_ptr->deleted[qd.cnum];
 
-	if (fsa_dev_ptr->devno[qd.cnum][0] == '\0')
+	if (fsa_dev_ptr->devname[qd.cnum][0] == '\0')
 		qd.unmapped = 1;
 	else
 		qd.unmapped = 0;
 
-	strncpy(dq.name, fsa_dev_ptr->devname[qd.cnum], 8);
+	strncpy(qd.name, fsa_dev_ptr->devname[qd.cnum], 8);
 
 	if (copy_to_user(arg, &qd, sizeof (struct aac_query_disk)))
 		return -EFAULT;
@@ -1170,7 +1170,7 @@
 		 *	Mark the container as no longer being valid.
 		 */
 		fsa_dev_ptr->valid[dd.cnum] = 0;
-		fsa_dev_ptr->devno[dd.cnum][0] = '\0';
+		fsa_dev_ptr->devname[dd.cnum][0] = '\0';
 		return 0;
 	}
 }




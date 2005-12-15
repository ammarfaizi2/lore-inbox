Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbVLOJR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbVLOJR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbVLOJR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:17:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:11946 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422642AbVLOJRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:55 -0500
To: torvalds@osdl.org
Subject: [PATCH] cm4000_cs: __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFL-0007z1-0R@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/pcmcia/cm4000_cs.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

b5dd1f826ffcb1335b51fd86c879d92f8be23188
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index ef011ef..61681c9 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1444,6 +1444,7 @@ static int cmm_ioctl(struct inode *inode
 	dev_link_t *link;
 	int size;
 	int rc;
+	void __user *argp = (void __user *)arg;
 #ifdef PCMCIA_DEBUG
 	char *ioctl_names[CM_IOC_MAXNR + 1] = {
 		[_IOC_NR(CM_IOCGSTATUS)] "CM_IOCGSTATUS",
@@ -1481,11 +1482,11 @@ static int cmm_ioctl(struct inode *inode
 	      _IOC_DIR(cmd), _IOC_READ, _IOC_WRITE, size, cmd);
 
 	if (_IOC_DIR(cmd) & _IOC_READ) {
-		if (!access_ok(VERIFY_WRITE, (void *)arg, size))
+		if (!access_ok(VERIFY_WRITE, argp, size))
 			return -EFAULT;
 	}
 	if (_IOC_DIR(cmd) & _IOC_WRITE) {
-		if (!access_ok(VERIFY_READ, (void *)arg, size))
+		if (!access_ok(VERIFY_READ, argp, size))
 			return -EFAULT;
 	}
 
@@ -1506,14 +1507,14 @@ static int cmm_ioctl(struct inode *inode
 				status |= CM_NO_READER;
 			if (test_bit(IS_BAD_CARD, &dev->flags))
 				status |= CM_BAD_CARD;
-			if (copy_to_user((int *)arg, &status, sizeof(int)))
+			if (copy_to_user(argp, &status, sizeof(int)))
 				return -EFAULT;
 		}
 		return 0;
 	case CM_IOCGATR:
 		DEBUGP(4, dev, "... in CM_IOCGATR\n");
 		{
-			struct atreq *atreq = (struct atreq *) arg;
+			struct atreq __user *atreq = argp;
 			int tmp;
 			/* allow nonblocking io and being interrupted */
 			if (wait_event_interruptible
@@ -1597,7 +1598,7 @@ static int cmm_ioctl(struct inode *inode
 		{
 			struct ptsreq krnptsreq;
 
-			if (copy_from_user(&krnptsreq, (struct ptsreq *) arg,
+			if (copy_from_user(&krnptsreq, argp,
 					   sizeof(struct ptsreq)))
 				return -EFAULT;
 
@@ -1641,7 +1642,7 @@ static int cmm_ioctl(struct inode *inode
 			int old_pc_debug = 0;
 
 			old_pc_debug = pc_debug;
-			if (copy_from_user(&pc_debug, (int *)arg, sizeof(int)))
+			if (copy_from_user(&pc_debug, argp, sizeof(int)))
 				return -EFAULT;
 
 			if (old_pc_debug != pc_debug)
-- 
0.99.9.GIT


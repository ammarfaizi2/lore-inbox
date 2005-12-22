Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVLVEvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVLVEvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVLVEvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35792 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965083AbVLVEvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:05 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 24/36] m68k: rtc __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPw-0004sv-Li@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011480 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/bvme6000/rtc.c |    6 +++---
 arch/m68k/mvme16x/rtc.c  |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

b8476525cbcf02835f83ab0e2ca58e7b00746ff9
diff --git a/arch/m68k/bvme6000/rtc.c b/arch/m68k/bvme6000/rtc.c
index eb63ca6..ab222c6 100644
--- a/arch/m68k/bvme6000/rtc.c
+++ b/arch/m68k/bvme6000/rtc.c
@@ -46,6 +46,7 @@ static int rtc_ioctl(struct inode *inode
 	unsigned char msr;
 	unsigned long flags;
 	struct rtc_time wtime;
+	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
 	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
@@ -68,7 +69,7 @@ static int rtc_ioctl(struct inode *inode
 		} while (wtime.tm_sec != BCD2BIN(rtc->bcd_sec));
 		rtc->msr = msr;
 		local_irq_restore(flags);
-		return copy_to_user((void *)arg, &wtime, sizeof wtime) ?
+		return copy_to_user(argp, &wtime, sizeof wtime) ?
 								-EFAULT : 0;
 	}
 	case RTC_SET_TIME:	/* Set the RTC */
@@ -80,8 +81,7 @@ static int rtc_ioctl(struct inode *inode
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		if (copy_from_user(&rtc_tm, (struct rtc_time*)arg,
-				   sizeof(struct rtc_time)))
+		if (copy_from_user(&rtc_tm, argp, sizeof(struct rtc_time)))
 			return -EFAULT;
 
 		yrs = rtc_tm.tm_year;
diff --git a/arch/m68k/mvme16x/rtc.c b/arch/m68k/mvme16x/rtc.c
index 7977eae..ee18309 100644
--- a/arch/m68k/mvme16x/rtc.c
+++ b/arch/m68k/mvme16x/rtc.c
@@ -44,6 +44,7 @@ static int rtc_ioctl(struct inode *inode
 	volatile MK48T08ptr_t rtc = (MK48T08ptr_t)MVME_RTC_BASE;
 	unsigned long flags;
 	struct rtc_time wtime;
+	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
 	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
@@ -63,7 +64,7 @@ static int rtc_ioctl(struct inode *inode
 		wtime.tm_wday = BCD2BIN(rtc->bcd_dow)-1;
 		rtc->ctrl = 0;
 		local_irq_restore(flags);
-		return copy_to_user((void *)arg, &wtime, sizeof wtime) ?
+		return copy_to_user(argp, &wtime, sizeof wtime) ?
 								-EFAULT : 0;
 	}
 	case RTC_SET_TIME:	/* Set the RTC */
@@ -75,8 +76,7 @@ static int rtc_ioctl(struct inode *inode
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		if (copy_from_user(&rtc_tm, (struct rtc_time*)arg,
-				   sizeof(struct rtc_time)))
+		if (copy_from_user(&rtc_tm, argp, sizeof(struct rtc_time)))
 			return -EFAULT;
 
 		yrs = rtc_tm.tm_year;
-- 
0.99.9.GIT


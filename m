Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292997AbSCDXNP>; Mon, 4 Mar 2002 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292980AbSCDXM6>; Mon, 4 Mar 2002 18:12:58 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:57361 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S292982AbSCDXMi>;
	Mon, 4 Mar 2002 18:12:38 -0500
Date: Mon, 4 Mar 2002 19:46:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: save_flags() should take unsigned long
Message-ID: <20020304184653.GA8646@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...and here's patch to fix it... Please apply.
									Pavel

--- linux/drivers/ide/ide.c	Sun Nov 11 18:48:09 2001
+++ linux.uns/drivers/ide/ide.c	Mon Mar  4 19:35:21 2002
@@ -1864,7 +1864,7 @@
 	ide_drive_t *drive;
 	ide_hwgroup_t *hwgroup;
 	unsigned int p, major, minor;
-	long flags;
+	unsigned long flags;
 
 	if ((drive = get_info_ptr(i_rdev)) == NULL)
 		return -ENODEV;
--- linux/drivers/scsi/sym53c8xx.c	Tue Jan 15 11:08:49 2002
+++ linux.uns/drivers/scsi/sym53c8xx.c	Mon Mar  4 19:35:17 2002
@@ -14111,7 +14111,7 @@
 	if (len)
 		return -EINVAL;
 	else {
-		long flags;
+		unsigned long flags;
 
 		NCR_LOCK_NCB(np, flags);
 		ncr_usercmd (np);
--- linux/include/linux/skbuff.h	Thu Feb 28 23:15:23 2002
+++ linux.uns/include/linux/skbuff.h	Mon Mar  4 19:24:35 2002
@@ -588,7 +588,7 @@
 
 static inline struct sk_buff *skb_dequeue(struct sk_buff_head *list)
 {
-	long flags;
+	unsigned long flags;
 	struct sk_buff *result;
 
 	spin_lock_irqsave(&list->lock, flags);
@@ -737,7 +737,7 @@
 
 static inline struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list)
 {
-	long flags;
+	unsigned long flags;
 	struct sk_buff *result;
 
 	spin_lock_irqsave(&list->lock, flags);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

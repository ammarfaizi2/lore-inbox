Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290491AbSBGRKN>; Thu, 7 Feb 2002 12:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBGRKD>; Thu, 7 Feb 2002 12:10:03 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:16342 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290491AbSBGRJv>; Thu, 7 Feb 2002 12:09:51 -0500
Date: Thu, 7 Feb 2002 18:09:32 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 64bit warning fixes
Message-ID: <20020207180932.A25214@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This patch just fixes some harmless but ugly warnings on 64bit compilations. 

>From the x86-64 tree. 

For 2.5.4pre2. Please consider applying.

Thanks, 

-Andi


--- ../../v2.5/linux/include/linux/pm.h	Thu Feb  7 01:46:26 2002
+++ linux/include/linux/pm.h	Thu Feb  7 17:32:17 2002
@@ -103,8 +103,8 @@
 	void		*data;
 
 	unsigned long	 flags;
-	int		 state;
-	int		 prev_state;
+	unsigned long	 state;
+	unsigned long	 prev_state;
 
 	struct list_head entry;
 };
--- ../../v2.5/linux/kernel/pm.c	Tue Jan 15 17:53:36 2002
+++ linux/kernel/pm.c	Thu Feb  7 17:32:17 2002
@@ -154,7 +154,7 @@
 int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
 	int status = 0;
-	int prev_state, next_state;
+	unsigned long prev_state, next_state;
 
 	if (in_interrupt())
 		BUG();
@@ -163,7 +163,7 @@
 	case PM_SUSPEND:
 	case PM_RESUME:
 		prev_state = dev->state;
-		next_state = (int) data;
+		next_state = (unsigned long) data;
 		if (prev_state != next_state) {
 			if (dev->callback)
 				status = (*dev->callback)(dev, rqst, data);

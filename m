Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264577AbRFPAZM>; Fri, 15 Jun 2001 20:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264579AbRFPAZC>; Fri, 15 Jun 2001 20:25:02 -0400
Received: from customers.imt.ru ([212.16.0.33]:45065 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S264577AbRFPAYw>;
	Fri, 15 Jun 2001 20:24:52 -0400
Message-ID: <20010615202333.A24765@saw.sw.com.sg>
Date: Fri, 15 Jun 2001 20:23:33 -0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch] unpaired lock/unlock_kernel in fs/locks.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply the fix for unpaired lock/unlock_kernel in fs/locks.c

	Andrey

--- fs/locks.c~	Fri Jun 15 17:14:05 2001
+++ fs/locks.c	Fri Jun 15 19:16:31 2001
@@ -856,7 +856,7 @@
 	new_fl2 = locks_alloc_lock(0);
 	error = -ENOLCK; /* "no luck" */
 	if (!(new_fl && new_fl2))
-		goto out;
+		goto out_nolock;
 
 	lock_kernel();
 	if (caller->fl_type != F_UNLCK) {
@@ -1004,6 +1004,7 @@
 	}
 out:
 	unlock_kernel();
+out_nolock:
 	/*
 	 * Free any unused locks.
 	 */

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVCSLMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVCSLMk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 06:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVCSLMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 06:12:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64658 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262448AbVCSLML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 06:12:11 -0500
Date: Sat, 19 Mar 2005 12:11:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: pm: remove obsolete pm_* from vt.c
Message-ID: <20050319111155.GA1569@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Those functions are useless these days, and should be gone... Please apply,

								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/drivers/char/vt.c	2005-03-19 00:31:21.000000000 +0100
+++ linux/drivers/char/vt.c	2005-03-19 00:37:26.000000000 +0100
@@ -221,9 +221,6 @@
 #define DO_UPDATE(vc)	CON_IS_VISIBLE(vc)
 #endif
 
-static int pm_con_request(struct pm_dev *dev, pm_request_t rqst, void *data);
-static struct pm_dev *pm_con;
-
 static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
 {
 	unsigned short *p;
@@ -723,12 +720,6 @@
 	    }
 	    vc->vc_kmalloced = 1;
 	    vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
-
-	    if (!pm_con) {
-		    pm_con = pm_register(PM_SYS_DEV,
-					 PM_SYS_VGA,
-					 pm_con_request);
-	    }
 	}
 	return 0;
 }
@@ -3218,24 +3209,6 @@
 	}
 }
 
-static int pm_con_request(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	switch (rqst)
-	{
-	case PM_RESUME:
-		acquire_console_sem();
-		unblank_screen();
-		release_console_sem();
-		break;
-	case PM_SUSPEND:
-		acquire_console_sem();
-		do_blank_screen(0);
-		release_console_sem();
-		break;
-	}
-	return 0;
-}
-
 /*
  *	Visible symbols for modules
  */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVGQJCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVGQJCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 05:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVGQJCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 05:02:35 -0400
Received: from everest.sosdg.org ([66.93.203.161]:19651 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261222AbVGQJB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 05:01:56 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Sun, 17 Jul 2005 17:02:45 +0800
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050717090245.GA20667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Scan-Signature: 2ecaae6c9cc520cc6f18c499896ec795
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] add copy_to_user result check
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

GCC warns me this problem. This patch adds copy_to_user result check
in sys_select() and sys_pselect7().


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---
diff -pruN 2.6.13-rc3-mm1/fs/select.c 2.6.13-rc3-mm1-cy1/fs/select.c
--- 2.6.13-rc3-mm1/fs/select.c	2005-07-15 23:51:35.000000000 +0800
+++ 2.6.13-rc3-mm1-cy1/fs/select.c	2005-07-17 16:26:58.000000000 +0800
@@ -401,7 +401,8 @@ asmlinkage long sys_select(int n, fd_set
 			tv.tv_sec++;
 			tv.tv_usec -= 1000000;
 		}
-		copy_to_user(tvp, &tv, sizeof(tv));
+		if (copy_to_user(tvp, &tv, sizeof(tv)))
+			return -EFAULT;
 	}
 
 	return ret;
@@ -459,7 +460,8 @@ asmlinkage long sys_pselect7(int n, fd_s
 			ts.tv_sec++;
 			ts.tv_nsec -= 1000000000;
 		}
-		copy_to_user(tsp, &ts, sizeof(ts));
+		if (copy_to_user(tsp, &ts, sizeof(ts)))
+			return -EFAULT;
 	}
 
 	if (sigmask)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWGMUPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWGMUPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWGMUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:15:48 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:40617 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030350AbWGMUPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:15:47 -0400
Date: Thu, 13 Jul 2006 16:11:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [test patch] seccomp: add code to disable TSC when enabling
  seccomp
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "andrea@cpushare.com" <andrea@cpushare.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607131613_MC3-1-C4EC-45F9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the below patch acceptable in generic code, or should some arch
helper function hide it?  It lets i386 / x86_64 add TIF_NOTSC
independently.  

Also, what prevents this flag from being set on a running process?
If that happens the CPU state and flag could get out of sync and
this could cause problems because of the way the current code tests
the flag.

--- 2.6.18-rc1-nb.orig/fs/proc/base.c
+++ 2.6.18-rc1-nb/fs/proc/base.c
@@ -1025,6 +1025,9 @@ static ssize_t seccomp_write(struct file
 	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
 		tsk->seccomp.mode = seccomp_mode;
 		set_tsk_thread_flag(tsk, TIF_SECCOMP);
+#ifdef TIF_NOTSC
+		set_tsk_thread_flag(tsk, TIF_NOTSC);
+#endif
 	} else
 		goto out;
 	result = -EIO;
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush

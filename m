Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVIRNja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVIRNja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVIRNj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:39:29 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:44429 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751217AbVIRNjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:39:13 -0400
Message-ID: <432D70C5.815D303@tv-sign.ru>
Date: Sun, 18 Sep 2005 17:51:01 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] little de_thread() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial, saves one 'if' branch in de_thread().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc1/fs/exec.c~3_DETHR	2005-09-17 18:57:28.000000000 +0400
+++ 2.6.14-rc1/fs/exec.c	2005-09-18 20:14:10.000000000 +0400
@@ -639,10 +639,9 @@ static inline int de_thread(struct task_
 	/*
 	 * Account for the thread group leader hanging around:
 	 */
-	count = 2;
-	if (thread_group_leader(current))
-		count = 1;
-	else {
+	count = 1;
+	if (!thread_group_leader(current)) {
+		count = 2;
 		/*
 		 * The SIGALRM timer survives the exec, but needs to point
 		 * at us as the new group leader now.  We have a race with

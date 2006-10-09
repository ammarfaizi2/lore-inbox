Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWJIBxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWJIBxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 21:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWJIBxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 21:53:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5343 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751595AbWJIBxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 21:53:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=KQl6A1AJeGO+Bs7w/8aM9si8JMkYKV6e3s/ic3odBDbXMBOJV8ANHAyDeDRInNHkiOx0IMVKCg7NK2xWa8aZpNl1mtPRBBZVHS42mxE8MJPwEmXxvgC7OtpU6xOW9fMEpxovL6bPjVfwdECKaZu6/3UwY2Yt1ttTbD27ikTfIbQ=
Date: Mon, 9 Oct 2006 05:52:57 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: use BUILD_BUG_ON in FPU code
Message-ID: <20061009015257.GB5346@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86_64/kernel/i387.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86_64/kernel/i387.c
+++ b/arch/x86_64/kernel/i387.c
@@ -82,11 +82,8 @@ int save_i387(struct _fpstate __user *bu
 	struct task_struct *tsk = current;
 	int err = 0;
 
-	{ 
-		extern void bad_user_i387_struct(void); 
-		if (sizeof(struct user_i387_struct) != sizeof(tsk->thread.i387.fxsave))
-			bad_user_i387_struct();
-	} 
+	BUILD_BUG_ON(sizeof(struct user_i387_struct) !=
+			sizeof(tsk->thread.i387.fxsave));
 
 	if ((unsigned long)buf % 16) 
 		printk("save_i387: bad fpstate %p\n",buf); 


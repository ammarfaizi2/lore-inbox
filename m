Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756385AbWKVSmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbWKVSmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756389AbWKVSmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:42:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:39047 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756384AbWKVSmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:42:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=UDxHiOh8piDjozjIb/Qn6eXRgQKaAstDUHuRoJyJ3dx7OfCDFg03R5hrSGj1fmTHSYFf0eDS21MwOg8kn1QKfH2v3nGi7zJRA4Ud5Yt0VVYLfUAcEgkl76geYUSIM4YjU5BGaRalivFQXJGOAEI0hTq2ENthPKK1O666JZITmMA=
Date: Thu, 23 Nov 2006 03:36:54 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix copy_process() error check
Message-ID: <20061122183654.GB2985@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of copy_process() should be checked by IS_ERR().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 kernel/fork.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: work-fault-inject/kernel/fork.c
===================================================================
--- work-fault-inject.orig/kernel/fork.c
+++ work-fault-inject/kernel/fork.c
@@ -1318,9 +1318,8 @@ struct task_struct * __devinit fork_idle
 	struct pt_regs regs;
 
 	task = copy_process(CLONE_VM, 0, idle_regs(&regs), 0, NULL, NULL, 0);
-	if (!task)
-		return ERR_PTR(-ENOMEM);
-	init_idle(task, cpu);
+	if (!IS_ERR(task))
+		init_idle(task, cpu);
 
 	return task;
 }

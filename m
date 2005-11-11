Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVKKI2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVKKI2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVKKI2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:28:49 -0500
Received: from verein.lst.de ([213.95.11.210]:18151 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751254AbVKKI2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:28:48 -0500
Date: Fri, 11 Nov 2005 09:28:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix task_struct leak in ptrace
Message-ID: <20051111082843.GA26069@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When ptrace_attach fails we need to drop the task_struct reference.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-11 00:10:29.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-11 00:11:21.000000000 +0100
@@ -485,7 +485,7 @@
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
-		goto out;
+		goto out_put_task_struct;
 	}
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);

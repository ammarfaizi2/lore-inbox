Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWF0PYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWF0PYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWF0PYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:24:22 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:9990 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1161088AbWF0PYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:24:21 -0400
Date: Tue, 27 Jun 2006 17:24:18 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Subject: [PATCH] Restore set_nmi_callback export on x86_64
Message-Id: <20060627172418.84423784.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ee60e17896c65da1df5780d3196c050bccb7d10 broke modular
oprofile (amongst others I suspect) on x86_64 by killing the
exports of set_nmi_callback and unset_nmi_callback. Let's
restore the exports next to the functions as is prefered now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Andi Kleen <ak@suse.de>
---
 arch/x86_64/kernel/nmi.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.17-git.orig/arch/x86_64/kernel/nmi.c	2006-06-27 16:22:17.000000000 +0200
+++ linux-2.6.17-git/arch/x86_64/kernel/nmi.c	2006-06-27 17:08:18.000000000 +0200
@@ -607,11 +607,13 @@
 	vmalloc_sync_all();
 	rcu_assign_pointer(nmi_callback, callback);
 }
+EXPORT_SYMBOL_GPL(set_nmi_callback);
 
 void unset_nmi_callback(void)
 {
 	nmi_callback = dummy_nmi_callback;
 }
+EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
 #ifdef CONFIG_SYSCTL
 


-- 
Jean Delvare

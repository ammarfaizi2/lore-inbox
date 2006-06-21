Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWFUVBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWFUVBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWFUVBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:01:09 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:25762 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030301AbWFUVAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:00:47 -0400
Date: Wed, 21 Jun 2006 23:00:46 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm 6/6] cpu_relax(): ptrace.c coding style fix
Message-ID: <20060621210046.GF22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix existing cpu_relax() loop to have proper kernel style.


Tested on 2.6.17-mm1.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/kernel/ptrace.c linux-2.6.17-mm1.my/kernel/ptrace.c
--- linux-2.6.17-mm1.orig/kernel/ptrace.c	2006-06-21 14:28:20.000000000 +0200
+++ linux-2.6.17-mm1.my/kernel/ptrace.c	2006-06-21 14:43:24.000000000 +0200
@@ -182,9 +182,8 @@
 	if (!write_trylock(&tasklist_lock)) {
 		local_irq_enable();
 		task_unlock(task);
-		do {
+		while (!write_can_lock(&tasklist_lock))
 			cpu_relax();
-		} while (!write_can_lock(&tasklist_lock));
 		goto repeat;
 	}
 

Return-Path: <linux-kernel-owner+w=401wt.eu-S1752948AbWLQQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbWLQQgH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 11:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbWLQQgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 11:36:07 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:4732 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752948AbWLQQgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 11:36:06 -0500
X-Greylist: delayed 5111 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 11:36:06 EST
Date: Sun, 17 Dec 2006 17:36:02 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] microcode: Fix mc_cpu_notifier section warning
Message-Id: <20061217173602.abaf4b69.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Structure mc_cpu_notifier references a __cpuinit function, but
isn't declared __cpuinitdata itself:

WARNING: arch/i386/kernel/microcode.o - Section mismatch: reference
to .init.text: from .data after 'mc_cpu_notifier' (at offset 0x118)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 arch/i386/kernel/microcode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.20-rc1.orig/arch/i386/kernel/microcode.c	2006-12-15 09:05:20.000000000 +0100
+++ linux-2.6.20-rc1/arch/i386/kernel/microcode.c	2006-12-17 15:23:40.000000000 +0100
@@ -722,7 +722,7 @@
 	return NOTIFY_OK;
 }
 
-static struct notifier_block mc_cpu_notifier = {
+static struct notifier_block __cpuinitdata mc_cpu_notifier = {
 	.notifier_call = mc_cpu_callback,
 };
 


-- 
Jean Delvare

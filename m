Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935697AbWK1Imk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935697AbWK1Imk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935706AbWK1Imk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38587 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935697AbWK1ImW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:22 -0500
Date: Tue, 28 Nov 2006 09:14:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [patch] x86_64: fix earlyprintk=...,keep regression
Message-ID: <20061128081405.GA9031@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00,RISK_FREE autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.2 RISK_FREE              BODY: Risk free.  Suuurreeee....
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] x86_64: fix earlyprintk=...,keep regression
From: Ingo Molnar <mingo@elte.hu>

the following cleanup patch:

 commit 2c8c0e6b8d7700a990da8d24eff767f9ca223b96
 Author: Andi Kleen <ak@suse.de>
 Date:   Tue Sep 26 10:52:32 2006 +0200

     [PATCH] Convert x86-64 to early param

     Instead of hackish manual parsing

broke the earlyprintk=...,keep feature. This patch restores that 
functionality. Tested on x86_64. Must-have for v2.6.19, no risk.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/early_printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/early_printk.c
===================================================================
--- linux.orig/arch/x86_64/kernel/early_printk.c
+++ linux/arch/x86_64/kernel/early_printk.c
@@ -224,7 +224,7 @@ static int __init setup_early_printk(cha
 		return 0;
 	early_console_initialized = 1;
 
-	if (!strcmp(buf,"keep"))
+	if (strstr(buf, "keep"))
 		keep_early = 1;
 
 	if (!strncmp(buf, "serial", 6)) {

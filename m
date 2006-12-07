Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031878AbWLGJT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031878AbWLGJT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031879AbWLGJT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:19:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43569 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031878AbWLGJT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:19:57 -0500
Date: Thu, 7 Dec 2006 10:18:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [atch] lockdep: filter off by default
Message-ID: <20061207091852.GA32181@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: filter off by default
From: Ingo Molnar <mingo@elte.hu>

fix typo in the class_filter() function. (filtering is not used
by default so this only affects lockdep-internal debugging cases)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 kernel/lockdep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -179,8 +179,8 @@ static int class_filter(struct lock_clas
 			!strcmp(class->name, "&struct->lockfield"))
 		return 1;
 #endif
-	/* Allow everything else. 0 would be filter everything else */
-	return 1;
+	/* Filter everything else. 1 would be to allow everything else */
+	return 0;
 }
 #endif
 

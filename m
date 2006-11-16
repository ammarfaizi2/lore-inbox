Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424067AbWKPOCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424067AbWKPOCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424071AbWKPOCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:02:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57810 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1424067AbWKPOCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:02:30 -0500
Date: Thu, 16 Nov 2006 15:01:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: show held locks when showing a stackdump
Message-ID: <20061116140114.GA24392@elte.hu>
References: <20061116100852.GA5864@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116100852.GA5864@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1392]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Subject: [patch] lockdep: show held locks when showing a stackdump
> From: Ingo Molnar <mingo@elte.hu>
> 
> lockdep can be used to print held locks when printing a backtrace. 
> This can be useful when debugging things like 'scheduling while 
> atomic' asserts.

on x86_64 this also needs the patch below - NULL means 'current'.

	Ingo

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -395,7 +395,11 @@ static void print_lock(struct held_lock 
 
 static void lockdep_print_held_locks(struct task_struct *curr)
 {
-	int i, depth = curr->lockdep_depth;
+	int i, depth;
+
+	if (!curr)
+		curr = current;
+	depth = curr->lockdep_depth;
 
 	if (!depth) {
 		printk("no locks held by %s/%d.\n", curr->comm, curr->pid);

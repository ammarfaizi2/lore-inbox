Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUINK5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUINK5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUINK5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:57:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50668 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269262AbUINK5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:57:40 -0400
Date: Tue, 14 Sep 2004 12:59:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched, mm: fix scheduling latencies in get_user_pages()
Message-ID: <20040914105904.GB31370@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20040914105048.GA31238@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The attached patch fixes long scheduling latencies in get_user_pages().

has been tested as part of the -VP patchset.

	Ingo

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-get_user_pages.patch"


The attached patch fixes long scheduling latencies in get_user_pages().

has been tested as part of the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -781,6 +781,8 @@ int get_user_pages(struct task_struct *t
 		do {
 			struct page *map;
 			int lookup_write = write;
+
+			cond_resched_lock(&mm->page_table_lock);
 			while (!(map = follow_page(mm, start, lookup_write))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want

--A6N2fC+uXW/VQSAv--

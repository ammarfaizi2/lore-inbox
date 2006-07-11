Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWGKPT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWGKPT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWGKPT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:19:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18963 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751008AbWGKPTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:19:42 -0400
Date: Tue, 11 Jul 2006 17:19:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport open_softirq
Message-ID: <20060711151941.GU13938@stusta.de>
References: <20060711120159.GA20601@lst.de> <20060711121226.GA12679@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711121226.GA12679@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig:
open_softirq just enables a softirq.  The softirq array is statically
allocated so to add a new one you would have to patch the kernel.  So
there's no point to keep this export at all as any user would have to
patch the enum in include/linux/interrupt.h anyway.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Ingo Molnar <mingo@elte.hu>

--- linux-2.6.18-rc1-mm1-full/kernel/softirq.c.old	2006-07-11 16:50:54.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/kernel/softirq.c	2006-07-11 16:51:00.000000000 +0200
@@ -311,8 +311,6 @@
 	softirq_vec[nr].action = action;
 }
 
-EXPORT_UNUSED_SYMBOL(open_softirq);  /*  June 2006  */
-
 /* Tasklets */
 struct tasklet_head
 {


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315281AbSDWR5e>; Tue, 23 Apr 2002 13:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSDWR5d>; Tue, 23 Apr 2002 13:57:33 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:6397 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S315281AbSDWR5b>;
	Tue, 23 Apr 2002 13:57:31 -0400
Date: Tue, 23 Apr 2002 13:57:19 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.9-dj1 bind_cpu compile error
Message-ID: <20020423175719.GA13070@www.kroptech.com>
In-Reply-To: <20020423144527.GA12925@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like a piece of Erich Focht's migration thread patch escaped
2.5.9-dj1. This fixes it for me...

--Adam

--- linux-2.5.9-dj1-virgin/kernel/sched.c	Tue Apr 23 13:11:53 2002
+++ linux-2.5.9-dj1/kernel/sched.c	Tue Apr 23 13:13:26 2002
@@ -1678,9 +1678,7 @@
 	preempt_enable();
 }
 
-static volatile unsigned long migration_mask;
-
-static int migration_thread(void * unused)
+static int migration_thread(void * bind_cpu)
 {
 	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	struct sched_param param = { sched_priority: 99 };


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSFBVnH>; Sun, 2 Jun 2002 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSFBVnG>; Sun, 2 Jun 2002 17:43:06 -0400
Received: from holomorphy.com ([66.224.33.161]:21410 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314446AbSFBVnG>;
	Sun, 2 Jun 2002 17:43:06 -0400
Date: Sun, 2 Jun 2002 14:42:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: duplicate declaration of rq in sched_init()
Message-ID: <20020602214243.GH14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this one while trying to straighten out bootstrap ordering
issues elsewhere.

There appears to be a duplicate declaration of rq in sched_init().
This removes the nested declaration and otherwise leaves things alone.

Cheers,
Bill

===== kernel/sched.c 1.79 vs edited =====
--- 1.79/kernel/sched.c	Wed May 29 08:26:26 2002
+++ edited/kernel/sched.c	Sun Jun  2 14:38:24 2002
@@ -1591,9 +1591,9 @@
 	int i, j, k;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		runqueue_t *rq = cpu_rq(i);
 		prio_array_t *array;
 
+		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);

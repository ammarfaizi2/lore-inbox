Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTKJHqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 02:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTKJHqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 02:46:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59293 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263002AbTKJHqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 02:46:08 -0500
Date: Mon, 10 Nov 2003 08:46:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
In-Reply-To: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.56.0311100841290.2914@earth>
References: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Nov 2003, Davide Libenzi wrote:

> Maybe something like:
> 
>  * We fend off statistical fluctuations in runqueue lengths by
>  * saving the runqueue length (as seen by the balancing CPU) during the 
>  * previous load-balancing operation and using the smaller one the current 
>  * and saved lengths.

yep, agreed - patch for 2.6.1 attached. (I also fixed a typo in the
original comment and reformatted the lines) Anything else?

	Ingo

--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -1061,10 +1061,11 @@
 	 * the lock held.
 	 *
 	 * We fend off statistical fluctuations in runqueue lengths by
-	 * saving the runqueue length during the previous load-balancing
-	 * operation and using the smaller one the current and saved lengths.
-	 * If a runqueue is long enough for a longer amount of time then
-	 * we recognize it and pull tasks from it.
+	 * saving the runqueue length (as seen by the balancing CPU) during
+	 * the previous load-balancing operation and using the smaller one
+	 * of the current and saved lengths. If a runqueue is long enough
+	 * for a longer amount of time then we recognize it and pull tasks
+	 * from it.
 	 *
 	 * The 'current runqueue length' is a statistical maximum variable,
 	 * for that one we take the longer one - to avoid fluctuations in

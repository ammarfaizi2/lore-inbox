Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTJHHts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 03:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTJHHts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 03:49:48 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:21473 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S261262AbTJHHtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 03:49:47 -0400
Date: Wed, 8 Oct 2003 09:49:37 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: resent [PATCH][2.6] Fix early __might_sleep() calls
Message-ID: <20031008074937.GA20511@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__might_sleep prints warnings only after jiffies wrap (typically after 5
minutes of uptime).

Patch against 2.6 CVS.

Roger

--- linux-2.5/kernel/sched.c.orig	2003-10-06 20:58:47.258167317 +0200
+++ linux-2.5/kernel/sched.c	2003-10-06 21:31:32.676707449 +0200
@@ -2847,7 +2847,7 @@ void __might_sleep(char *file, int line)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
 	if (in_atomic() || irqs_disabled()) {
-		if (time_before(jiffies, prev_jiffy + HZ))
+		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
 		printk(KERN_ERR "Debug: sleeping function called from invalid"

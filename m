Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTIITuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTIITuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:50:15 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:39142 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S264362AbTIITtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:49:49 -0400
Message-ID: <3F5E14D7.9030809@terra.com.br>
Date: Tue, 09 Sep 2003 14:58:47 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: davem@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Missing memory barrier on net/core/dev.c
Content-Type: multipart/mixed;
 boundary="------------040506090002070600070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506090002070600070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Dave,

	I *think* net/core/dev.c is missing a mb() before calling 
schedule_timoeut.

	Feel free to prove me wrong, though ;)

	Patch against 2.6.0-test5.

	Please review.

	Cheers,

Felipe

--------------040506090002070600070902
Content-Type: text/plain;
 name="net-core-current_state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-core-current_state.patch"

--- linux-2.6.0-test5/net/core/dev.c	Mon Sep  8 16:50:06 2003
+++ linux-2.6.0-test5-fwd/net/core/dev.c	Tue Sep  9 14:52:48 2003
@@ -2753,9 +2753,9 @@
 			rebroadcast_time = jiffies;
 		}
 
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 4);
-		current->state = TASK_RUNNING;
+		__set_current_state(TASK_RUNNING);
 
 		if (time_after(jiffies, warning_time + 10 * HZ)) {
 			printk(KERN_EMERG "unregister_netdevice: "

--------------040506090002070600070902--


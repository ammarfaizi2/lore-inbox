Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVCQC1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVCQC1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVCQC1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:27:20 -0500
Received: from fmr24.intel.com ([143.183.121.16]:59552 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262963AbVCQC1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:27:05 -0500
Subject: [PATCH 2.6] fix POSIX timers expire before their scheduled time
From: "Liu, Hong" <hong.liu@intel.com>
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1111026022.2994.54.camel@devlinux-hong>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Mar 2005 10:20:22 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX says: POSIX timers should not expire before their scheduled time.

Due to the timer started between jiffies, there are cases that the timer
will expire before its scheduled time.
This patch ensures timers will not expire early.

--- a/kernel/posix-timers.c     2005-03-10 15:46:27.329333664 +0800
+++ b/kernel/posix-timers.c     2005-03-10 15:50:11.884196136 +0800
@@ -957,7 +957,8 @@
                            &expire_64, &(timr->wall_to_prev))) {
                return -EINVAL;
        }
-       timr->it_timer.expires = (unsigned long)expire_64;
+       timr->it_timer.expires = (unsigned long)expire_64 + 1;
        tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
        timr->it_incr = (unsigned long)expire_64;



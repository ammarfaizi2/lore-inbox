Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVKXOrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVKXOrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVKXOrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:47:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38300 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751196AbVKXOrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:47:40 -0500
Message-ID: <4385E3F8.DB0F3E10@tv-sign.ru>
Date: Thu, 24 Nov 2005 19:02:00 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix 32bit overflow in timespec_to_sample()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix 32bit overflow in timespec_to_sample()

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc/kernel/posix-cpu-timers.c~	2005-10-26 23:33:12.000000000 +0400
+++ 2.6.14-rc/kernel/posix-cpu-timers.c	2005-10-26 23:35:53.000000000 +0400
@@ -36,7 +36,7 @@ timespec_to_sample(clockid_t which_clock
 	union cpu_time_count ret;
 	ret.sched = 0;		/* high half always zero when .cpu used */
 	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
-		ret.sched = tp->tv_sec * NSEC_PER_SEC + tp->tv_nsec;
+		ret.sched = (unsigned long long)tp->tv_sec * NSEC_PER_SEC + tp->tv_nsec;
 	} else {
 		ret.cpu = timespec_to_cputime(tp);
 	}

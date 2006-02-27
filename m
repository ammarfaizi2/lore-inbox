Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWB0Wqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWB0Wqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWB0WbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:20 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29313 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932091AbWB0WbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:09 -0500
Message-Id: <20060227223345.170100000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:11 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Oleg Nesterov <oleg@tv-sign.ru>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/39] [PATCH] sys_signal: initialize ->sa_mask
Content-Disposition: inline; filename=sys_signal-initialize-sa_mask.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Pointed out by Linus Torvalds.

sys_signal() forgets to initialize ->sa_mask.

( I suspect arch/ia64/ia32/ia32_signal.c:sys32_signal()
  also needs this fix )

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 kernel/signal.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.15.4.orig/kernel/signal.c
+++ linux-2.6.15.4/kernel/signal.c
@@ -2604,6 +2604,7 @@ sys_signal(int sig, __sighandler_t handl
 
 	new_sa.sa.sa_handler = handler;
 	new_sa.sa.sa_flags = SA_ONESHOT | SA_NOMASK;
+	sigemptyset(&new_sa.sa.sa_mask);
 
 	ret = do_sigaction(sig, &new_sa, &old_sa);
 

--

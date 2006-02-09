Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWBISYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWBISYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWBISYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:24:34 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38317 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965239AbWBISYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:24:33 -0500
Message-ID: <43EB9AF5.AD63B9DE@tv-sign.ru>
Date: Thu, 09 Feb 2006 22:41:41 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: [PATCH] sys_signal: initialize ->sa_mask
References: <43EA33B3.4D67CA97@tv-sign.ru> <43EA3611.3F4BC29D@tv-sign.ru> <Pine.LNX.4.64.0602080907460.2458@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pointed out by Linus Torvalds.

sys_signal() forgets to initialize ->sa_mask.

( I suspect arch/ia64/ia32/ia32_signal.c:sys32_signal()
  also needs this fix )

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/signal.c~	2006-02-01 23:38:20.000000000 +0300
+++ RC-1/kernel/signal.c	2006-02-09 23:17:54.000000000 +0300
@@ -2702,6 +2702,7 @@ sys_signal(int sig, __sighandler_t handl
 
 	new_sa.sa.sa_handler = handler;
 	new_sa.sa.sa_flags = SA_ONESHOT | SA_NOMASK;
+	sigemptyset(&new_sa.sa.sa_mask);
 
 	ret = do_sigaction(sig, &new_sa, &old_sa);

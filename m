Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWBVXHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWBVXHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWBVXHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:07:54 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:40424 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030328AbWBVXHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:07:39 -0500
Message-ID: <43FCEE08.7923E800@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:04:40 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 2/6] relax sig_needs_tasklist()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

handle_stop_signal() does not need tasklist_lock for
SIG_KERNEL_STOP_MASK signals anymore.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/signal.c~2_RELAX	2006-02-23 00:36:49.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-23 01:22:45.000000000 +0300
@@ -146,8 +146,7 @@ static kmem_cache_t *sigqueue_cachep;
 #define sig_kernel_stop(sig) \
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
 
-#define sig_needs_tasklist(sig) \
-		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK | M(SIGCONT)))
+#define sig_needs_tasklist(sig)	((sig) == SIGCONT)
 
 #define sig_user_defined(t, signr) \
 	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWDKOWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWDKOWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWDKOWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:22:19 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:27820 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750847AbWDKOWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:22:18 -0400
Date: Tue, 11 Apr 2006 22:18:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] __group_complete_signal: remove bogus BUG_ON
Message-ID: <20060411181858.GA110@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit	e56d090310d7625ecb43a1eeebd479f04affb48b
[PATCH] RCU signal handling

made this BUG_ON() unsafe. This code runs under ->siglock,
while switch_exec_pids() takes tasklist_lock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16/kernel/signal.c~	2006-02-13 21:47:19.000000000 +0300
+++ 2.6.16/kernel/signal.c	2006-04-11 21:53:03.000000000 +0400
@@ -975,7 +975,6 @@ __group_complete_signal(int sig, struct 
 		if (t == NULL)
 			/* restart balancing at this thread */
 			t = p->signal->curr_target = p;
-		BUG_ON(t->tgid != p->tgid);
 
 		while (!wants_signal(sig, t)) {
 			t = next_thread(t);


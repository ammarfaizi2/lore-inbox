Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752183AbWCCH6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbWCCH6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWCCH6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:58:14 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:24704 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1752177AbWCCH6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:58:11 -0500
Message-Id: <20060303075727.803477000@sorel.sous-sol.org>
References: <20060303075542.659414000@sorel.sous-sol.org>
Date: Thu, 02 Mar 2006 23:55:43 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       netdev@vger.kernel.org,
       "Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>,
       Arnaldo Carvalho de Melo <acme@mandriva.com>
Subject: [PATCH 1/4] [REQSK] Dont reset rskq_defer_accept in reqsk_queue_alloc
Content-Disposition: inline; filename=don-t-reset-rskq_defer_accept-in-reqsk_queue_alloc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

In 295f7324ff8d9ea58b4d3ec93b1aaa1d80e048a9 I moved defer_accept from
tcp_sock to request_queue and mistakingly reset it at reqsl_queue_alloc, causing
calls to setsockopt(TCP_DEFER_ACCEPT ) to be lost after bind, the fix is to
remove the zeroing of rskq_defer_accept from reqsl_queue_alloc.

Thanks to Alexandra N. Kossovsky <Alexandra.Kossovsky@oktetlabs.ru> for
reporting and testing the suggested fix.

Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/core/request_sock.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.15.5.orig/net/core/request_sock.c
+++ linux-2.6.15.5/net/core/request_sock.c
@@ -52,7 +52,6 @@ int reqsk_queue_alloc(struct request_soc
 	get_random_bytes(&lopt->hash_rnd, sizeof(lopt->hash_rnd));
 	rwlock_init(&queue->syn_wait_lock);
 	queue->rskq_accept_head = queue->rskq_accept_head = NULL;
-	queue->rskq_defer_accept = 0;
 	lopt->nr_table_entries = nr_table_entries;
 
 	write_lock_bh(&queue->syn_wait_lock);

--

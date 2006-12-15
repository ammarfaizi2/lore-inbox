Return-Path: <linux-kernel-owner+w=401wt.eu-S965034AbWLOBiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWLOBiv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWLOBgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:36:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46200 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964996AbWLOBfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:38 -0500
Message-Id: <20061215013612.244200000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Kim Nordlund <kim.nordlund@nokia.com>
Subject: [patch 09/24] PKT_SCHED act_gact: division by zero
Content-Disposition: inline; filename=pkt_sched-act_gact-division-by-zero.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

Not returning -EINVAL, because someone might want to use the value
zero in some future gact_prob algorithm?

Signed-off-by: Kim Nordlund <kim.nordlund@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/sched/act_gact.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.5.orig/net/sched/act_gact.c
+++ linux-2.6.18.5/net/sched/act_gact.c
@@ -54,14 +54,14 @@ static DEFINE_RWLOCK(gact_lock);
 #ifdef CONFIG_GACT_PROB
 static int gact_net_rand(struct tcf_gact *p)
 {
-	if (net_random()%p->pval)
+	if (!p->pval || net_random()%p->pval)
 		return p->action;
 	return p->paction;
 }
 
 static int gact_determ(struct tcf_gact *p)
 {
-	if (p->bstats.packets%p->pval)
+	if (!p->pval || p->bstats.packets%p->pval)
 		return p->action;
 	return p->paction;
 }

--

Return-Path: <linux-kernel-owner+w=401wt.eu-S1947564AbWLIAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947564AbWLIAIH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947524AbWLIAHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:07:22 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37512 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947531AbWLHX7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:31 -0500
Message-Id: <20061209000003.819937000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:01 -0800
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
Subject: [patch 10/32] PKT_SCHED act_gact: division by zero
Content-Disposition: inline; filename=pkt_sched-act_gact-division-by-zero.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
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

--- linux-2.6.19.orig/net/sched/act_gact.c
+++ linux-2.6.19/net/sched/act_gact.c
@@ -48,14 +48,14 @@ static struct tcf_hashinfo gact_hash_inf
 #ifdef CONFIG_GACT_PROB
 static int gact_net_rand(struct tcf_gact *gact)
 {
-	if (net_random() % gact->tcfg_pval)
+	if (!gact->tcfg_pval || net_random() % gact->tcfg_pval)
 		return gact->tcf_action;
 	return gact->tcfg_paction;
 }
 
 static int gact_determ(struct tcf_gact *gact)
 {
-	if (gact->tcf_bstats.packets % gact->tcfg_pval)
+	if (!gact->tcfg_pval || gact->tcf_bstats.packets % gact->tcfg_pval)
 		return gact->tcf_action;
 	return gact->tcfg_paction;
 }

--

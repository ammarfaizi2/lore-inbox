Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWE2V2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWE2V2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWE2V1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46315 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751386AbWE2V1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:30 -0400
Date: Mon, 29 May 2006 23:27:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 59/61] lock validator: special locking: xfrm
Message-ID: <20060529212751.GG3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (non-nested) unlocking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 net/xfrm/xfrm_policy.c |    2 +-
 net/xfrm/xfrm_state.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/net/xfrm/xfrm_policy.c
===================================================================
--- linux.orig/net/xfrm/xfrm_policy.c
+++ linux/net/xfrm/xfrm_policy.c
@@ -1308,7 +1308,7 @@ static struct xfrm_policy_afinfo *xfrm_p
 	afinfo = xfrm_policy_afinfo[family];
 	if (likely(afinfo != NULL))
 		read_lock(&afinfo->lock);
-	read_unlock(&xfrm_policy_afinfo_lock);
+	read_unlock_non_nested(&xfrm_policy_afinfo_lock);
 	return afinfo;
 }
 
Index: linux/net/xfrm/xfrm_state.c
===================================================================
--- linux.orig/net/xfrm/xfrm_state.c
+++ linux/net/xfrm/xfrm_state.c
@@ -1105,7 +1105,7 @@ static struct xfrm_state_afinfo *xfrm_st
 	afinfo = xfrm_state_afinfo[family];
 	if (likely(afinfo != NULL))
 		read_lock(&afinfo->lock);
-	read_unlock(&xfrm_state_afinfo_lock);
+	read_unlock_non_nested(&xfrm_state_afinfo_lock);
 	return afinfo;
 }
 

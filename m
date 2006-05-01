Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWEAV4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWEAV4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWEAV4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:56:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47521 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932288AbWEAV4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:56:50 -0400
Date: Mon, 1 May 2006 14:57:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU: add comments to rcu_pending/rcu_needs_cpu
Message-ID: <20060501215723.GE1305@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com> <20060425115226.GA9421@osiris.boeblingen.de.ibm.com> <20060425120854.GF16719@us.ibm.com> <20060425122706.GB9421@osiris.boeblingen.de.ibm.com> <20060426141205.58675763.akpm@osdl.org> <20060427081156.GB9457@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427081156.GB9457@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 10:11:56AM +0200, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Add some comments to rcu_pending() and rcu_needs_cpu().
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
> Wording might be poor, but probably better than no comments at all.

But these are internal interfaces for RCU, so doesn't seem like they
should go into docbook.  Quite different than (say) rcu_read_lock()
or call_rcu().

How about something like the following instead?

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>
---

diff -urpNa -X dontdiff linux-2.6.17-rc3-rnc/kernel/rcupdate.c linux-2.6.17-rc3-rnc.pem/kernel/rcupdate.c
--- linux-2.6.17-rc3-rnc/kernel/rcupdate.c	2006-05-01 14:42:30.000000000 -0700
+++ linux-2.6.17-rc3-rnc.pem/kernel/rcupdate.c	2006-05-01 14:48:19.000000000 -0700
@@ -479,12 +479,25 @@ static int __rcu_pending(struct rcu_ctrl
 	return 0;
 }
 
+/*
+ * Check to see if there is any immediate RCU-related work to be done
+ * by the current CPU, returning 1 if so.  This function is part of the
+ * RCU implementation; it is -not- an exported member of the RCU API.
+ */
+
 int rcu_pending(int cpu)
 {
 	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
+/* 
+ * Check to see if any future RCU-related work will need to be done
+ * by the current CPU, even if none need be done immediately, returning
+ * 1 if so.  This function is part of the RCU implementation; it is -not-
+ * an exported member of the RCU API.
+ */
+
 int rcu_needs_cpu(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);

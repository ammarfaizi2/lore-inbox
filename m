Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVDCI45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDCI45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 04:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVDCI45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 04:56:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56038 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261617AbVDCI4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 04:56:55 -0400
Date: Sun, 3 Apr 2005 14:26:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org,
       manfred@colorfullife.com, bunk@stusta.de
Subject: Re: [RFC,PATCH 2/4] Deprecate synchronize_kernel, GPL replacement
Message-ID: <20050403085650.GA4563@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050403062149.GA1656@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403062149.GA1656@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 10:21:50PM -0800, Paul E. McKenney wrote:
> The synchronize_kernel() primitive is used for quite a few different
> purposes: waiting for RCU readers, waiting for NMIs, waiting for interrupts,
> and so on.  This makes RCU code harder to read, since synchronize_kernel()
> might or might not have matching rcu_read_lock()s.  This patch creates
> a new synchronize_rcu() that is to be used for RCU readers and a new
> synchronize_sched() that is used for the rest.  These two new primitives
> currently have the same implementation, but this is might well change
> with additional real-time support.  Both new primitives are GPL-only,
> the old primitive is deprecated.
> 
> Signed-off-by: <paulmck@us.ibm.com>
> ---
> Depends on earlier "Add deprecated_for_modules" patch.
> 
> +/*
> + * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
> + */
> +void synchronize_kernel(void)
> +{
> +	synchronize_rcu();
> +}
> +

We should probably mark it deprecated - 

void __deprecated synchronize_kernel(void)
{
	synchronize_rcu();
}

Thanks
Dipankar

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVCYRc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVCYRc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVCYR3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:29:14 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:57789
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261713AbVCYR2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:28:44 -0500
Date: Fri, 25 Mar 2005 09:28:13 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] xfrm_policy destructor fix
Message-Id: <20050325092813.20e00ef9.davem@davemloft.net>
In-Reply-To: <20050325143440.GA4516@elte.hu>
References: <20050325143440.GA4516@elte.hu>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 15:34:41 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> the patch below fixes a bug that i encountered while running a 
> PREEMPT_RT kernel, but i believe it should be fixed in the generic 
> kernel too. xfrm_policy_kill() queues a destroyed policy structure to 
> the GC list, and unlocks the policy->lock spinlock _after_ that point.  
> This created a scenario where GC processing got to the new structure 
> first, and kfree()d it - then the write_unlock_bh() was done on the 
> already kfreed structure. There is no guarantee that GC processing will 
> be done after policy->lock has been dropped and softirq processing has 
> been enabled.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Good catch Ingo, patch applied.  Thanks.

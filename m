Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVAJO4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVAJO4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVAJO4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:56:31 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30171 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262283AbVAJO4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:56:17 -0500
Date: Mon, 10 Jan 2005 07:56:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [3/3]
Message-ID: <20050110145615.GC2226@smtp.west.cox.net>
References: <20050110013508.1.patchmail@tglx> <1105318804.17853.5.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105318804.17853.5.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 02:00:04AM +0100, Thomas Gleixner wrote:

> This patch adjusts the PPC entry code to use the fixed up
> preempt_schedule() handling in 2.6.10-mm2
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  entry.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> ---
> Index: 2.6.10-mm1/arch/ppc/kernel/entry.S
> ===================================================================
> --- 2.6.10-mm1/arch/ppc/kernel/entry.S  (revision 141)
> +++ 2.6.10-mm1/arch/ppc/kernel/entry.S  (working copy)
> @@ -624,12 +624,12 @@
>         beq+    restore
>         andi.   r0,r3,MSR_EE    /* interrupts off? */
>         beq     restore         /* don't schedule if so */
> -1:     lis     r0,PREEMPT_ACTIVE@h
> +1:     li      r0,1

Perhaps I just don't have enough context, but is there good reason to
use a magic constant instead of a define ?

-- 
Tom Rini
http://gate.crashing.org/~trini/

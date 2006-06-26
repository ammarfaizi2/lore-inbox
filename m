Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932964AbWFZVzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWFZVzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWFZVzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:55:15 -0400
Received: from mail.gmx.de ([213.165.64.21]:64702 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751256AbWFZVzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:55:14 -0400
X-Authenticated: #5039886
Date: Mon, 26 Jun 2006 23:55:27 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] Fix warning in do_IRQ (i386)
Message-ID: <20060626215527.GA6109@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>
References: <20060626230857.e92bc170.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060626230857.e92bc170.khali@linux-fr.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.26 23:08:57 +0200, Jean Delvare wrote:
> arch/i386/kernel/irq.c: In function `do_IRQ':
> arch/i386/kernel/irq.c:104: warning: suggest parentheses around arithmetic in operand of |
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Björn Steinbrink <B.Steinbrink@gmx.de>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  arch/i386/kernel/irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.17-git.orig/arch/i386/kernel/irq.c	2006-06-26 21:55:03.000000000 +0200
> +++ linux-2.6.17-git/arch/i386/kernel/irq.c	2006-06-26 22:54:49.000000000 +0200
> @@ -100,8 +100,8 @@
>  		 * softirq checks work in the hardirq context.
>  		 */
>  		irqctx->tinfo.preempt_count =
> -			irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK |
> -			curctx->tinfo.preempt_count & SOFTIRQ_MASK;
> +			(irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
> +			(curctx->tinfo.preempt_count & SOFTIRQ_MASK);
>  
>  		asm volatile(
>  			"       xchgl   %%ebx,%%esp      \n"

Hi,

thanks for catching that one, I even fixed that on the box where the
patch was tested but then obviously sent the old patch.


Acked-by: Björn Steinbrink <B.Steinbrink@gmx.de>

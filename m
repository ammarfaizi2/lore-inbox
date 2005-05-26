Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVEZNRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVEZNRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEZNRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:17:04 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27049 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261394AbVEZNQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:16:47 -0400
Subject: Re: [patch] smp_processor_id() cleanup, 2.6.12-rc5
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050526104449.GA14289@elte.hu>
References: <20050526104449.GA14289@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 26 May 2005 09:16:14 -0400
Message-Id: <1117113374.4313.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 12:44 +0200, Ingo Molnar wrote:
> this patch implements a number of smp_processor_id() cleanup ideas that 
> Arjan van de Ven and i came up with.
> 
> the previous __smp_processor_id/_smp_processor_id/smp_processor_id API 
> spaghetti was hard to follow both on the implementational and on the 
> usage side.
> 
> some of the complexity arose from picking wrong names, some of the 
> complexity comes from the fact that not all architectures defined 
> __smp_processor_id.
> 
> in the new code, there are two externally visible symbols:
> 
>  - smp_processor_id(): debug variant.
> 
>  - raw_smp_processor_id(): nondebug variant. Replaces all existing
>    uses of _smp_processor_id() and __smp_processor_id(). Defined
>    by every SMP architecture in include/asm-*/smp.h.
> 
> there is one new internal symbol, dependent on DEBUG_PREEMPT:
> 
>  - debug_smp_processor_id(): internal debug variant, mapped to
>                              smp_processor_id().
> 
> also, i moved debug_smp_processor_id() from lib/kernel_lock.c into a new 
> lib/smp_processor_id.c file. All related comments got updated and/or 
> clarified.

Let me be the first to say "Thank you Ingo! (and Arjan)".  God, the fun
I had with _?_?smp_processor_id. The first time I got the bug message I
was "WTF", and then to figure out if I should use the _ or __ version.
I hope your patch gets in so that this will be much cleared up, and put
my effort in learning the difference between them all in vain.

I guess I should download the latest kernel and try it out.

Thanks again,

-- Steve



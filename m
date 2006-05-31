Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWEaLvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWEaLvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWEaLvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 07:51:07 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:24571 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932333AbWEaLvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 07:51:06 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060531063103.GC21779@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <1149045448.28264.4.camel@localhost.localdomain>
	 <20060530211442.a260a32e.akpm@osdl.org>  <20060531063103.GC21779@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 07:50:43 -0400
Message-Id: <1149076243.28264.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 08:31 +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Without having looked at it very hard, I'd venture that this is a 
> > false positive - that driver uses disable_irq() to prevent reentry 
> > onto that lock.
> 
> correct.
> 
> > It does that because it knows it's about to spend a long time talking 
> > with the mii registers and it doesn't want to do that with interrupts 
> > disabled.
> 
> i still consider it a 'quirky' locking construct, because disabling 
> interrupts for a long time also disables all other devices sharing the 
> same IRQ line - not nice.
> 
> Also, this is a really hard case for lockdep to detect automatically. 
> (fortunately it's also relatively rare)

What's the standard way to teach lockdep about this?

> 
> OTOH, the straightforward lockdep workaround would be to take the 
> spinlock and thus disable all local interrupts - not too nice either. 
> 
> Albeit in some ways it's still a bit nicer conceptually than disabling 
> the irq line, because other CPUs are still operational, and under 
> certain locking designs [preempt-rt] spin_lock_irq() does not disable 
> local interrupts.
>  
> Steve, can you think of any better solution? I dont have this card.

Until this popped up, I didn't know I had this card either ;)
(the last time we dealt with this card was to help someone else)

Anyway, I'll look into the way this card works and start to play with it
when I get some time.

Andrew, do you have any docs that I can read to understand the card a
little better?

Thanks,

-- Steve



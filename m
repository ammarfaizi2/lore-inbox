Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVJTXC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVJTXC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVJTXC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:02:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932550AbVJTXC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:02:26 -0400
Date: Thu, 20 Oct 2005 16:01:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, arjan@infradead.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
Message-Id: <20051020160115.2b34cb8e.akpm@osdl.org>
In-Reply-To: <20051020225347.GA29303@elte.hu>
References: <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
	<434BEA0D.9010802@cosmosbay.com>
	<20051017000343.782d46fc.akpm@osdl.org>
	<1129533603.2907.12.camel@laptopd505.fenrus.org>
	<20051020215047.GA24178@elte.hu>
	<Pine.LNX.4.64.0510201455030.10477@g5.osdl.org>
	<20051020220228.GA26247@elte.hu>
	<Pine.LNX.4.64.0510201512480.10477@g5.osdl.org>
	<20051020222703.GA28221@elte.hu>
	<20051020154457.100b5565.akpm@osdl.org>
	<20051020225347.GA29303@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > spin_lock is still uninlined.
> 
> yes, and that should stay so i believe, for text size reasons. The BTB 
> should eliminate most effects of the call+ret itself.

The old

	lock; decb
	js <different section>
	...

was pretty good.

> > as is spin_lock_irqsave() and spin_lock_irq()
> 
> yes, for them the code length is even higher.
> 
> > uninlining spin_lock will probably increase overall text size, but 
> > mainly in the out-of-line section.
> 
> you mean inlining it again? I dont think we should do it.
> 
> > read_lock is out-of-line.  read_unlock is inlined
> > 
> > write_lock is out-of-line.  write_unlock is out-of-line.
> 
> hm, with my patch, write_unlock should be inlined too.
> 

So it is.  foo_unlock_irq() isn't though.

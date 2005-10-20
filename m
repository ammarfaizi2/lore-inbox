Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVJTV5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVJTV5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVJTV5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:57:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932531AbVJTV5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:57:40 -0400
Date: Thu, 20 Oct 2005 14:57:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
In-Reply-To: <20051020215047.GA24178@elte.hu>
Message-ID: <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
 <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
 <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
 <434BEA0D.9010802@cosmosbay.com> <20051017000343.782d46fc.akpm@osdl.org>
 <1129533603.2907.12.camel@laptopd505.fenrus.org> <20051020215047.GA24178@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Oct 2005, Ingo Molnar wrote:
>
> +/*
> + * We inline the unlock functions in the nondebug case:
> + */
> +#ifdef CONFIG_DEBUG_SPINLOCK

That can't be right. What about preemption etc?

There's a lot more to spin_unlock() than just the debugging stuff.

		Linus

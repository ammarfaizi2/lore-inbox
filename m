Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKJM0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKJM0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKJM0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:26:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbVKJM03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:26:29 -0500
Date: Thu, 10 Nov 2005 04:26:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051110042613.7a585dec.akpm@osdl.org>
In-Reply-To: <20051110120624.GB32672@elte.hu>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
	<Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
	<20051109185645.39329151.akpm@osdl.org>
	<20051110120624.GB32672@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> yuck. What is the real problem btw?

Well.  One problem is that spinlocks now take two words...

But apart from that, the problem at hand is that we want to embed a
spinlock in struct page, and the size of the spinlock varies a lot according
to config.  The only >wordsize version we really care about is
CONFIG_PREEMPT, NR_CPUS >= 4.  (which distros don't ship...)

> AFAICS there's enough space for a 
>  2-word spinlock in struct page for pagetables.

spinlocks get a lot bigger than that with CONFIG_DEBUG_SPINLOCK.

> We really dont want to 
>  rewrite spinlocks (or remove features) just to keep gcc 2.95 supported 
>  for some more time. In fact, is there any 2.6 based distro that uses gcc 
>  2.95?

I think some of the debian derivates might.  But who knows?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVE0UcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVE0UcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVE0UcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:32:17 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:18698 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262577AbVE0UcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:32:13 -0400
Date: Fri, 27 May 2005 13:36:55 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527203655.GB1940@nietzsche.lynx.com>
References: <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <20050527121056.GA2238@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527121056.GA2238@elte.hu>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:10:56PM +0200, Ingo Molnar wrote:
> * Bill Huey <bhuey@lnxw.com> wrote:
> 
> > There's really no good reason why this kernel can't get the same 
> > latency as a nanokernel. The scheduler paths are riddled with SMP 
> > rebalancing stuff and the like which contributes to overall system 
> > latency. Remove those things and replace it with things like direct 
> > CPU pining and you'll start seeing those numbers collapse. [...]
> 
> could you be a bit more specific? None of that stuff should show up on 
> UP kernels. Even on SMP, rebalancing is either asynchronous, or O(1).

I found out a couple of problems with IRQ rebalancing in that the
latency spread was effected by a ping-ponging of the actual interrupt
itself. I reported this to you in November and I fixed this problem
by gluing the interrupt to the same cpu as the irq-thread.

Not sure if it was the rebalancing or the cache issues, but they seem
related.

bill


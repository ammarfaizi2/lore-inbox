Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUHXKcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUHXKcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUHXKcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:32:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29094 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267400AbUHXKap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:30:45 -0400
Date: Tue, 24 Aug 2004 12:29:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Karl Vogel <karl.vogel@seagha.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Kernel 2.6.8.1: swap storm of death - CFQ scheduler=culprit
Message-ID: <20040824102914.GK2355@suse.de>
References: <6DED3619289CD311BCEB00508B8E133601A68B1E@nt-server2.antwerp.seagha.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6DED3619289CD311BCEB00508B8E133601A68B1E@nt-server2.antwerp.seagha.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24 2004, Karl Vogel wrote:
> > > > Original post with testcase + stats:
> > > >   http://article.gmane.org/gmane.linux.kernel/228156
> > > 
> > > 2.6.8.1-mm4 clean does not reproduce the problem. Marcelo, your
> > > 2.6.8-rc4 report is not valid due to the fixed problem 
> > related to that
> > > in CFQ already. I'd still like for you to retest with 2.6.8.1.
> > > 
> 
> Did some extra testing yesterday. When not running X or anything
> substantial, I'm able to trigger it after running the expunge 2 or
> 3 times in a row. 
> If I increase the calloc size, it triggers faster (tried with 1Gb
> calloc on a 512Mb box with 1Gb swap partition). 

I'll try increasing the size.

> The first expunge run, completes fine. The ones after that, get 
> OOM killed and I get a printk about page allocation order 0 failure.
> 
> The 2.6.8.1-mm4 was a clean version, but I will double check this,
> this evening.
> 
> I also tried with deadline, but was unable to trigger it.

I'm adding preempt to the mix, maybe that'll help provoke it.

> > Oh, and please do also do a sysrq-t from a hung box and save 
> > the output.
> 
> Note: the box doesn't hang completely. Just some processes get stuck
> in 'D' and the machine swaps heavily.

That's fine, I'd like a sysrq-t of that.

> The tests of yesterday evening, did recover. So I'm guessing if I had
> waited long enough the box would have recovered on the previous
> tests. Looking at the vmstat from my previous tests, shows that the
> box was low on memory (free/buff/cache are all very low):
> 
>   http://users.telenet.be/kvogel/vmstat-after-kill.txt
> 
> That was probably why it was swapping like mad. 

Ok, so now I'm confused - tests on what kernel recovered?

> Will provide you with that sysrq-t this evening.

Great.

-- 
Jens Axboe


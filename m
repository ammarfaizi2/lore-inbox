Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTKHPQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 10:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTKHPQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 10:16:57 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:2053 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261784AbTKHPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 10:16:56 -0500
Subject: Re: lib.a causing modules not to load
From: James Bottomley <James.Bottomley@steeleye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20031108085152.B18856@infradead.org>
References: <1068222065.1894.21.camel@mulgrave>
	<20031107203419.7d0de676.akpm@osdl.org> 
	<20031108085152.B18856@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Nov 2003 09:16:10 -0600
Message-Id: <1068304571.2048.5.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-08 at 02:51, Christoph Hellwig wrote:
> On Fri, Nov 07, 2003 at 08:34:19PM -0800, Andrew Morton wrote:
> > How about we just link that function into the kernel and be done with it? 
> > We'll waste a few bytes on SMP machines which have neither ext2 nor ext3
> > linked-in or loaded as modules, but that doesn't sound very important...
> > 
> > (We don't have a kernel/random-support-stuff.c, but we have
> > mm/random-support-stuff.c which for some reason is called mm/swap.c, so
> > I put it there).
> 
> Well, this solves the problem for this particular case, but not other
> stuff in lib for other situations.

I agree...there's much more in lib than just percpu_counter_mod.

> We should just stop building lib
> as archive and conditionalize building bigger and rarely used stuff in
> there using Kconfig symbols.

Actually, I do think lib serves a purpose for shared routines that are
used in disparate places throughout the kernel.

Why code these as Kconfig symbol dependencies when the library mechanism
does exactly what we want except for this one all symbols are in modules
case.  As a counter example: kobject is in lib...Imagine exactly how
many Kconfig conditions we'd have to introduce to conditionalise that...

I really think the correct way forwards is to fix the one failing case;
I was just asking if anyone had already thought about it.

James






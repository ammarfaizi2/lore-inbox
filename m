Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVGITTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVGITTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVGITRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:30080 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261705AbVGITPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:15:25 -0400
Date: Sat, 9 Jul 2005 21:15:01 +0200
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050709191501.GA9068@wotan.suse.de>
References: <20050709144116.GA9444@elte.hu.suse.lists.linux.kernel> <20050709152924.GA13492@elte.hu.suse.lists.linux.kernel> <p73ll4f29m7.fsf@verdi.suse.de> <1120930264.3176.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120930264.3176.52.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 07:31:04PM +0200, Arjan van de Ven wrote:
> On Sat, 2005-07-09 at 19:05 +0200, Andi Kleen wrote:
> > Ingo Molnar <mingo@elte.hu> writes:
> > >  
> > > +static void force_sig_info_fault(int si_signo, int si_code,
> > > +				 unsigned long address, struct task_struct *tsk)
> > 
> > This won't work with a unit-at-a-time compiler which happily
> > inlines everything static with only a single caller. Use noinline
> 
> but.... the x86 kernel is -fno-unit-at-a-time.... for stack reasons ;)

The gcc people are making noises of removing that. So eventually
it will need to go.

Also some kernels are compiled with that option removed and it works
just fine.

-Andi

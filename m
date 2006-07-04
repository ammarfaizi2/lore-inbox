Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWGDESn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWGDESn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 00:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWGDESn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 00:18:43 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:19692 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1750740AbWGDESm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 00:18:42 -0400
Date: Tue, 4 Jul 2006 09:45:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060704041519.GC16074@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu> <20060703165750.GB3899@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703165750.GB3899@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 10:27:50PM +0530, Dipankar Sarma wrote:
> On Thu, Jun 29, 2006 at 10:11:45PM +0200, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > > OK, I ran this with both torture types (rcu and rcu_bh) on i386 with 
> > > CONFIG_PREEMPT=y on 2.6.17-mm4 and didn't see any "scheduling while 
> > > atomic" oopses -- or any other oopses, for that matter.
> > > 
> > > Here is the .config file I used.  What am I missing here?
> > 
> > hm, i'm seeing some other types of crashes too - so rcutorture could 
> > just have been collateral damage. It was on i386, an allyesconfig 
> > bzImage kernel.
> 
> With 2.6.17-rt5 I see this -
> 
> Starting pass 0
> Unable to handle kernel paging request at ffffffff88006bd0 RIP:
> <ffffffff802597d5>{rcu_process_callbacks+107}
> rcutorture: --- End of test: SUCCESS: nreaders=8 stat_interval=1PGD 203027 PUD 205027 PMD 21eb18067 PTE 21829f163
> Oops: 0000 [1] PREEMPT SMP
> CPU 1
> 
> I have been able to reproduce a similar looking oopse with 2.6.16-rt29.
> 2.6.16-rt20 works fine. I will try to track it down to the exact
> release as far as I can.

OK, it looks as if rt20 is fine but rt21 is broken. So something
that got in rt21 is causing this oops.

Ingo, do you have a suspect ?

Thanks
Dipankar

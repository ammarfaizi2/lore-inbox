Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVAPFec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVAPFec (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVAPFec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:34:32 -0500
Received: from news.suse.de ([195.135.220.2]:49057 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262431AbVAPFe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:34:29 -0500
Date: Sun, 16 Jan 2005 06:34:24 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050116053424.GB2489@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de> <1105765760.12263.12.camel@localhost.localdomain> <20050115052311.GC22863@wotan.suse.de> <1105774495.12263.21.camel@localhost.localdomain> <20050115075946.GA28981@wotan.suse.de> <1105849247.5711.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105849247.5711.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 03:20:47PM +1100, Rusty Russell wrote:
> On Sat, 2005-01-15 at 08:59 +0100, Andi Kleen wrote: 
> > I think my patch is better. It at least keeps all the 
> > baggage out of the normal run paths. Doing this check at each timer interrupt
> > doesn't make much sense.
> 
> It doesn't penalize the architectures which do the right thing already.
> If this weren't i386 we were talking about...
> 
> But adding a bizarro "pre-prepare" notifier verged on nonsensical 8(.  I

I don't see the big issue. Preparse is just not as early as you thought.


> prefer an explicit "init_timers_early()" call as a workaround; I'll code
> that up and test tomorrow, when I'm back in the office with an SMP box
> to test.
> 
> I'm also not clear on why we need to enable interrupts around
> calibrate_delay() on secondary processors, but I'll try that too and
> find out 8)

Because you cannot calibrate the timer without a timer tick.

Even if you changed that it wouldn't help because the race can
as well happen in the idle loop on the secondaries.

-Andi

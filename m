Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424726AbWKPWDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424726AbWKPWDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424693AbWKPWDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:03:52 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:1699 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1424726AbWKPWDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:03:51 -0500
Date: Thu, 16 Nov 2006 17:03:50 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <Pine.LNX.4.64.0611161342320.3349@woody.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0611161658170.2929-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Linus Torvalds wrote:

>  - it makes it clear that this should be fixed, preferably by just having 
>    some way to initialize SRCU structs staticalyl. If we get that, the fix 
>    is to just replace the horrible "initialize by hand" with a static 
>    initializer once and for all.
> 
> Hmm?
> 
> Totally untested, but it compiles and it _looks_ sane. The overhead of the 
> function call should be minimal, once things are initialized.
> 
> Paul, it would be _really_ nice to have some way to just initialize that 
> SRCU thing statically. This kind of crud is just crazy.

I looked into this back when SRCU was first added.  It's essentially
impossible to do it, because the per-cpu memory allocation & usage APIs
are completely different for the static and the dynamic cases.  They are a
real mess.  I couldn't think up a way to construct any sort of uniform
interface to per-cpu memory, not without completely changing the guts of 
the per-cpu stuff.

If you or someone else can fix that problem, I will be happy to change the 
SRCU-based notifiers to work both ways.

Alan Stern


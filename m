Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319020AbSHMRNZ>; Tue, 13 Aug 2002 13:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319018AbSHMRNZ>; Tue, 13 Aug 2002 13:13:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6881 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319016AbSHMRNX>;
	Tue, 13 Aug 2002 13:13:23 -0400
Date: Tue, 13 Aug 2002 10:14:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <1995160000.1029258898@flay>
In-Reply-To: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch is from Matt Dobson. It disables irq_balance for the NUMA-Q
>> and makes it a config option for everyone else.
> 
> Please don't use negative config options.
> 
> I'd much rather have
> 
> 	bool 'IRQ balancing support' CONFIG_IRQ_BALANCE
> 
> than some "Disable IRQ balancing?" question.

That piece of wierdness I'll take the blame for, not Matt. It's more complex, we 
just wanted to make the default be to have it turned on, maybe we've missed 
some way in the config to make it work like that?

> Also, the explanation should probably explain that a P4 needs manual IRQ 
> balancing since the P4 broke the Intel-documented round-robin behaviour.
> 
> Finally, exactly since IRQ balancing is practically required on P4-SMP, I
> really don't think a CONFIG option works. It needs to be configured in on
> any kernel that expects to use P4's in an SMP configuration.

That'd be easier if it was written in such a way it worked on all P4 systems.
For one, it does an rdtsc directly, which doesn't work on all machines.
For another, it assumes flat logical addressing mode. We need to be able
to disable this until it's rewritten in such a way as to be more generic.

> In other words, I think this needs to do a dynamic disable (with the 
> possible exception of a NUMA-Q machine, since that one is already a static 
> config option and won't have P4's in it).

Was there some reason you really need this on P4s? I seem to recall something
to do with timer interrupts, but don't remember exactly.

M.

PS. I think __DO_ACTION gets an award for disgusting use of macros.

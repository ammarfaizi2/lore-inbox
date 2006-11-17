Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755468AbWKQGtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbWKQGtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbWKQGtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:49:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:60304 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755468AbWKQGtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:49:08 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: sleeping functions called in invalid context during resume
Date: Fri, 17 Nov 2006 07:49:01 +0100
User-Agent: KMail/1.9.5
Cc: Stephen Hemminger <shemminger@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20061114223002.10c231bd@localhost.localdomain> <20061116212158.0ef99842@localhost.localdomain> <20061116221800.bfbd80c4.akpm@osdl.org>
In-Reply-To: <20061116221800.bfbd80c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170749.02129.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have no idea what causes:
> > 
> > APIC error on CPU0: 00(00)
> > 
> > Is it an ACPI problem?

What CPU/chipset?

> 
> Strange.  x86_64 has that stray exit_idle() in smp_error_interrupt() but
> afaict it won't cause this to happen.
> 
> What's that idle_notifier doing in x86_64 anyway?  

I originally added it for my (now abandoned in favour of dyntick) noidletick 
implementation. I would have removed it again, but perfmon plans to use it
too and I suspect dyntick will too (?)

> It appears to have no 
> users.  If there _is_ a user, and if its IDLE_END handler is altering the
> preempt-count then perhaps there's your explanation.

There shouldn't be a user currently in tree.
 
> But it all appears to be dead code to me.

Right now it is yes.

-Andi
 

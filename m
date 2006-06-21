Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWFUXF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWFUXF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWFUXF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:05:26 -0400
Received: from mx1.suse.de ([195.135.220.2]:55245 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030452AbWFUXFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:05:24 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Thu, 22 Jun 2006 01:05:18 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <200606220021.21657.ak@suse.de> <1150930751.6885.61.camel@galaxy.corp.google.com>
In-Reply-To: <1150930751.6885.61.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606220105.18512.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 00:59, Rohit Seth wrote:
> On Thu, 2006-06-22 at 00:21 +0200, Andi Kleen wrote:
> > > Can we use similar  mechanism to access pda in vsyscall in x86_64 (by
> > > storing the address of pda there).  
> > 
> > 
> > You mean in the kernel? %gs prefix is a lot faster than this.
> > 
> 
> Yes it is.  And will work if we are okay to swap to kernel gs in
> vsyscall code.

swapgs is only allowed in ring 0.

> 
> > Also the limit is only 20bit, not enough for a full address.
> > 
> 
> I was thinking of storing it is base address part of the descriptor and
> then using the memory load to read it in vsyscall.  (Keeping the p bit
> to zero in the descriptor).

I'm still not sure where and for what you want to use this. In user space 
or in kernel space? And what information should be stored in there?

> 
> > For user space it's useful though, but I don't see any immediate uses
> > other than cpu number and node number. For most purposes glibc TLS
> > (which uses %fs) is probably sufficient.
> 
> cpu and node number are really important (for the reasons that you
> mentioned in your initial mail on vgetcpu).  In addition to that I was
> thinking in terms of having some counters like nmi_count that is already
> there and per cpu specific.

For what would you need nmi count in user space?

> Besides, not having to use the tcache part in the proposed system call
> seems to just make the interface cleaner. 

tcache is still far faster than LSL (which is slower than RDTSCP) 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVKXOWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVKXOWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVKXOWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:22:18 -0500
Received: from ns1.suse.de ([195.135.220.2]:29073 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751159AbVKXOWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:22:14 -0500
Date: Thu, 24 Nov 2005 15:22:01 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124142200.GH20775@brahms.suse.de>
References: <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132842847.13095.105.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 02:34:07PM +0000, Alan Cox wrote:
> On Iau, 2005-11-24 at 14:39 +0100, Andi Kleen wrote:
> > That's supposed to be done by hardware, no? 
> 
> Varies immensely by system. Where there is a hardware scrubber and it is
> enabled it will be used. Once nice thing about K8 is the mem controller
> is in the CPU so they all use the same driver (not yet merged)

What do you need a special driver for if the northbridge just
can do the scrubbing by itself?

> > If you try to do it this way then the code will become such
> > a mess if not impossible to write that your changes to merge them
> > and get it right are very slim. The only sane way to do all the locking etc. 
> > is to hand over the handling to a thread. While that make the window
> > of misusing the data wider it's the only sane alternative vs not
> > doing it at all.
> 
> Its utterly hideous because the usual 'ECC error' reporting technique
> for an uncorrectable error is an NMI. Locks could be in any state at

On the modern systems I'm familiar with it's an machine check (although
not necessarily a recoverable one and there might be other bad
side effects) 

> this point and even the registers needing to be accessed are across PCI
> and we could be half way through a PCI configuration cycle.
> 
> The -mm EDAC code works on the basic assumption that unrecovered ECC is
> a system halter although that is configurable.

I don't know what you could do over the default code for K8 at least.
And on modern Intel server chipsets I would expect it also to not
be needed.

-Andi


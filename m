Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVKWQ7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVKWQ7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVKWQ7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:59:25 -0500
Received: from mx1.suse.de ([195.135.220.2]:19681 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932098AbVKWQ7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:59:24 -0500
Date: Wed, 23 Nov 2005 17:59:23 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123165923.GJ20775@brahms.suse.de>
References: <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132766489.7268.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 05:21:29PM +0000, Alan Cox wrote:
> On Mer, 2005-11-23 at 17:39 +0100, Andi Kleen wrote:
> > I much prefer the MSR bit too. Unfortunately it doesn't exist
> > (or rather I bet it exists somewhere, just undocumented) on Intel 
> > systems.
> 
> The MSR bits will break things like ECC scrubbing however. That can be

You mean it might break an insane hack in someone's ECC scrubbing
implementation. But last time I talked to people about this
they suggested just using an uncacheable mapping instead of 
this horrible thing. Uncached is actually what you want there,
not relying on some undocumented lock bus cycle behaviour.

IMHO that would be much better and actually
have a chance of working over multiple generation.
 
> Certainly it would be cleaner and easier to save the MSR, scrub and put
> it back than do the fixup magic. Some drivers would need auditing as
> they seem to use locked ops or xchg (implicit lock) to lock with a PCI
> DMA master.

Which drivers? I don't think there is anything in tree. I went
over all the drivers early in the x86-64 port.

I'm sure I would have noticed because they very likely needed inline
assembly for this and this generally broke when moving to x86-64.

DRM did some tricks, but generally not with the hardware I believe,
only between user/kernel space.

-Andi


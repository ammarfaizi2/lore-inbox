Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVBFNn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVBFNn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVBFNn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:43:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:36281 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261227AbVBFNny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:43:54 -0500
Date: Sun, 6 Feb 2005 14:43:37 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206134337.GA30476@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <1107695097.22680.92.camel@laptopd505.fenrus.org> <20050206130929.GI30109@wotan.suse.de> <20050206133133.GA4124@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206133133.GA4124@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:31:33PM +0100, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Sun, Feb 06, 2005 at 02:04:57PM +0100, Arjan van de Ven wrote:
> > > 
> > > > Hmm, I got a report that it doesn't work anymore with 
> > > > 2.6.11rcs on x86-64. I haven't looked  closely yet,
> > > > but it wouldn't surprise me if this change isn't also involved.
> > > 
> > > PT_GNU_STACK change is there since like 2.6.6 (and was put in by a suse person)
> > > To me that is a strong indication that you are wrong on your
> > > suspicion...
> > 
> > Nah, the change to break 32bit userland mmap/mprotect like this was only 
> > put in after 2.6.10. 
> 
> i suspect there may be some fundamental misunderstanding here. The
> change to honor PT_GNU_STACK (on 64-bit) was added in April 2004 and
> appeared in 2.6.6. The change to enforce the protection bits on x86 NX
> CPUs (32-bit) was added in June 2004 and appeared in 2.6.8. I.e. it's
> been part of the upstream kernel for more than half a year. Try it and
> boot 2.6.8, you'll get NX protection. (I'm not sure about when it was
> enabled for 32-bit emulation on the x64 kernel, you should be the one to
> know that - but IIRC it was enabled prior 2.6.10.)

I suspect it was afterwards. All the reports about grub/mono/etc. not working
anymore etc. only appear now. It's possible that there wasn't
enough testing before or the testing happened with completely
different semantics (like Fedora on grub) 

Anyways, I don't care about the 32bit change much because nobody seems to 
test that one anyways. Basically all the NX capable machines
are 64bit capable and often run 64bit kernels, and even if people run
32bit kernels they tend to run non PAE kernels where the problem is hidden.

The main thing what annoys me is that the x86-64 32bit emulation
seems to effectively serve as a testing ground for 32bit changes now,
because the stuff is not tested on 32bit.

And it's already enough work to keep the 32bit emulation working,
without having to care about additional issues like this.

> so i think you are on to the wrong victim :-)

I don't think so, no.

Linus, can you please tell me what you prefer? If you think
it's better to only disable this on x86-64 I can change that too. 
But it would be probably the wrong thing to do, because
then the same issues will all reappear later.

-Andi

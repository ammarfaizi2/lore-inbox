Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbTIJT3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTIJT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:26:47 -0400
Received: from gprs145-173.eurotel.cz ([160.218.145.173]:2179 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265661AbTIJTYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:24:46 -0400
Date: Wed, 10 Sep 2003 21:24:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Luca Veraldi <luca.veraldi@katamail.com>, alexander.riesen@synopsys.COM,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910192426.GE2589@elf.ucw.cz>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910095255.GA21313@mail.jlokier.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The overhead implied by a memcpy() is the same, in the oder of magnitude,
> > > ***whatever*** kernel version you can develop.
> > 
> > yes a copy of a page is about 3000 to 4000 cycles on an x86 box in the
> > uncached case. A pagetable operation (like the cpu setting the accessed
> > or dirty bit) is in that same order I suspect (maybe half this, but not
> > a lot less). Changing pagetable content is even more because all the
> > tlb's and internal cpu state will need to be flushed... which is also a
> > microcode operation for the cpu. And it's deadly in an SMP environment.
> 
> I have just done a measurement on a 366MHz PII Celeron.  The test is
> quite crude, but these numbers are upper bounds on the timings:
> 
> 	mean 813 cycles to:
> 
> 		page fault
> 		install zero page
> 		remove zero page
> 
> 		(= read every page from MAP_ANON region and unmap, repeatedly)
> 
> 	mean 11561 cycles to:
> 
> 		page fault
> 		copy zero page
> 		install copy
> 		remove copy
> 
> 		(= write every page from MAP_ANON region and unmap, repeatedly)
> 
> I think that makes a clear case for avoiding page copies.

Can you make it available so we can test on, say, 900MHz athlon? Or
you can have it tested on 1800MHz athlon64, that's about as high end
as it can get.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

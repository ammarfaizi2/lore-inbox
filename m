Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWJCQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWJCQsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWJCQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:48:09 -0400
Received: from xenotime.net ([66.160.160.81]:13488 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932300AbWJCQsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:48:07 -0400
Date: Tue, 3 Oct 2006 09:49:26 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Message-Id: <20061003094926.0e99d13f.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<p73venk2sjw.fsf@verdi.suse.de>
	<9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	<Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	<20061002191638.093fde85.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	<20061002213809.7a3f995f.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
	<20061003092339.999d0011.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 09:37:45 -0700 (PDT) Linus Torvalds wrote:

> 
> 
> On Tue, 3 Oct 2006, Randy Dunlap wrote:
> > 
> > Yes, that works.
> 
> Ok. I'll commit that simple thing, and add a comment on why we're 
> apparently doing the same thing twice (you do need _both_ of those things: 
> the "disable_x86_fxsr" will make sure all other CPU's also get cleared, 
> while the "clear_bit()" will clear it immediately on the boot CPU)
> 
> I'll leave the no387/nofxsr linking alone for now. The main reason to use 
> no387 would seem to be just testing that emulation works at all, and I 
> guess we can just tell people to use the "no387 nofxsr" combination.
> 
> So Randy, with this you can boot all the way into user space, and some FP 
> apps still work too?

My few trivial float and double apps work.
Is there any particular test/workload that you want me to run?

> (Of course, user-space may be buggy and use SSE etc without testing for 
> whether the CPU actually supports it - if the install process has 
> installed some special SSE-version of a library depending on what the CPU 
> claimed at that point, or if somebody uses "cpuid" directly rather than 
> asking the kernel. So there's no way we're going to _guarantee_ that this 
> works in user space, but at least a well-behaved user-space that works on 
> a i486 should hopefully be ok).


---
~Randy

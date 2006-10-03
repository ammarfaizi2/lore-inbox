Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWJCQhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWJCQhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJCQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:37:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932240AbWJCQhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:37:52 -0400
Date: Tue, 3 Oct 2006 09:37:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <20061003092339.999d0011.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
 <p73venk2sjw.fsf@verdi.suse.de> <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org> <20061002191638.093fde85.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002213809.7a3f995f.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org> <20061003092339.999d0011.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, Randy Dunlap wrote:
> 
> Yes, that works.

Ok. I'll commit that simple thing, and add a comment on why we're 
apparently doing the same thing twice (you do need _both_ of those things: 
the "disable_x86_fxsr" will make sure all other CPU's also get cleared, 
while the "clear_bit()" will clear it immediately on the boot CPU)

I'll leave the no387/nofxsr linking alone for now. The main reason to use 
no387 would seem to be just testing that emulation works at all, and I 
guess we can just tell people to use the "no387 nofxsr" combination.

So Randy, with this you can boot all the way into user space, and some FP 
apps still work too?

(Of course, user-space may be buggy and use SSE etc without testing for 
whether the CPU actually supports it - if the install process has 
installed some special SSE-version of a library depending on what the CPU 
claimed at that point, or if somebody uses "cpuid" directly rather than 
asking the kernel. So there's no way we're going to _guarantee_ that this 
works in user space, but at least a well-behaved user-space that works on 
a i486 should hopefully be ok).

			Linus

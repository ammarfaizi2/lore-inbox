Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTEKNtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTEKNtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:49:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64128 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261433AbTEKNtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:49:07 -0400
Date: Sun, 11 May 2003 15:01:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jos Hulzink <josh@stack.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct x86 reboot vector
Message-ID: <20030511140144.GA5602@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com> <200305111137.29743.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305111137.29743.josh@stack.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink wrote:
> On Sunday 11 May 2003 05:50, Linus Torvalds wrote:
> > Hmm.. Doesnt' a _real_ hardware reset actually use a magic segment that
> > isn't even really true real mode? I have this memory that the reset value
> > for a i386 has CS=0xf000, but the shadow base register actually contains
> > 0xffff0000. In other words, the CPU actually starts up in "unreal" mode,
> > and will fetch the first instruction from physical address 0xfffffff0.
> >
> > At least that was true on an original 386. It's something that could
> > easily have changed since.

I got my info from an article on the net which says that a 386 does
behave as you say, but it is possible for the system designer to
arrange that it boots into the 286-compatible vector at physical
address 0x000ffff0.  It states that the feature is specifically so
that system designers don't have to create a "memory hole" (that's as
much detail as it gives).

I can't be arsed to look in a real 386 manual though :)

> Source: 80386 Programmers Reference Manual, Intel (1986)
> 
> EIP is set 0000FFF0H
> CS is set F000H
> 
> After RESET, lines A31-A20 are FORCED high till a far JMP is done.
> 
> So, unfortunately we have to say Linus is right once again. Damn ;-) My 
> conclusion is that we are unable to use the CPU reset as the reference for 
> warm boots, for we can't control A312-A20 in real mode. But as far as I can 
> see, my arguments still hold...

You can set up unreal mode but it is quite fiddly.

-- Jamie

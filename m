Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281513AbRKVTfK>; Thu, 22 Nov 2001 14:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRKVTfA>; Thu, 22 Nov 2001 14:35:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43722 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281513AbRKVTet>;
	Thu, 22 Nov 2001 14:34:49 -0500
Date: Thu, 22 Nov 2001 14:34:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anuradha Ratnaweera <anuradha@gnu.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.15-pre9
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111221422040.29272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Nov 2001, Linus Torvalds wrote:

> Quite frankly, right now I'm in "handle only bugs that can crash the
> system mode". Anything that takes 497 days to see is fairly low on my
> priority list. My highest priority, in fact, is to get 2.4.15 out without
> any embarrassment.

Umm...
	a) /proc/interrupts has buffer overflows.
	b) I have a patch that should fix them (conversion to seq_file,
done for all architectures)
	c) while completely straightforward, it's large (every subarchitecture
of m68k and mips seems to have its own get_irq_list()) and may contain typos
in architectures I've no access to.
	d) holes had been there for quite a while and it's either
"cat /proc/interrupts always causes memory corruption" or "everything OK"

I'm not quite sure where it is - if we were in -pre<small> I'd definitely
say that it's worth merging, so that trivial typos could be caught before
the release; the hole obviously deserves fixing.  OTOH, merging that in -final
means that we are risking "2.4.15 doesn't compile on <architecture>"...

Comments?


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291751AbSBHTLE>; Fri, 8 Feb 2002 14:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291749AbSBHTKy>; Fri, 8 Feb 2002 14:10:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21194 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291718AbSBHTKq>;
	Fri, 8 Feb 2002 14:10:46 -0500
Date: Fri, 8 Feb 2002 14:10:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@ns.caldera.de>,
        yodaiken <yodaiken@fsmlabs.com>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.33.0202082156530.16418-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0202081405230.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Ingo Molnar wrote:

> > I'm going to send ext2-without-BKL patches to Linus - tonight or
> > tomorrow. I really wonder what effect that would have on the things.
> 
> oh, that is a really cool thing!
> 
> llseek() is unrelated, and i think pretty gross. Is there any other reason
> to llseek()'s i_sem usage other than the 64-bit atomic update of the file
> offset value? We can do lockless, SMP-correct 64-bit updates on x86 pretty
> easily.

Umm...  Wait a second.  You've seen the problems on ->i_sem variant
of llseek()?  My apologies - I've misparsed you.

I seriously suspect that BKL-for-lseek() will be good enough once we
kill BKL in ext2_get_block() and friends.  IOW, I doubt that
generic_file_lseek() showing up in BKL contention is the real
problem...


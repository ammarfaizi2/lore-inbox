Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315579AbSECHDx>; Fri, 3 May 2002 03:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315583AbSECHDw>; Fri, 3 May 2002 03:03:52 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315579AbSECHDu>; Fri, 3 May 2002 03:03:50 -0400
Date: Fri, 3 May 2002 09:04:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503090434.C11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <143790000.1020367912@flay> <20020502205741.O11414@dualathlon.random> <150570000.1020379194@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:39:54PM -0700, Martin J. Bligh wrote:
> > The difference is that if you use discontigmem you don't clobber the
> > common code in any way, there is no "logical/ordinal" abstraction,
> > there is no special table, it's all hidden in the arch section, and the
> > pgdat you need them anyways to allocate from affine memory with numa.
> 
> I *want* the logical / ordinal abstraction. That's not a negative thing -
> it reduces the number of complicated things I have to think about,
> allowing me to think more clearly, and write correct code ;-)

That's just overhead. you don't need an additional table
ordinal/logical things.

the only case nonlinear will pay off is when you have to deal with a
single pgdat with physical huge holes in the middle of its per-node
mem_map. You don't have those holes in the middle of the mem_map of each
node, so it's cleaner and faster to avoid nonlinear for you, it's just
overhead.

nonlinear instead definitely pays off with the origin 2k layout shown by
Ralf, or with the iseries machine if the partitioning mandates an huge
number of discontigous chunks.

> 
> Not having a multitude of zones to balance in the normal discontigmem
> case also seems like a powerful argument to me ...
> 
> M.


Andrea

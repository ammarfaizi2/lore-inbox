Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRGFUBz>; Fri, 6 Jul 2001 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266826AbRGFUBo>; Fri, 6 Jul 2001 16:01:44 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:61708 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S266828AbRGFUBe>;
	Fri, 6 Jul 2001 16:01:34 -0400
Date: Fri, 6 Jul 2001 14:02:20 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010706140220.A6572@ftsoj.fsmlabs.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010704002436.C1294@ftsoj.fsmlabs.com> <9hvjd4$1ok$1@penguin.transmeta.com> <20010706023835.A5224@ftsoj.fsmlabs.com> <9i50uf$tla$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9i50uf$tla$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jul 06, 2001 at 06:44:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that was not easy to miss.  I was simply being clear.  The plan9
compiler, thus its take on inline asm, doesn't run on ia64 and alpha as far
as I can see from the latest release.

} NONE of my examples were about the x86.
} 
} I gave the alpha as a specific example.  The same issues are true on
} ia64, sparc64, and mips64.  How more "modern" can you get? Name _one_
} reasonably important high-end CPU that is more modern than alpha and
} ia64.. 
} 
} On ia64, you probably end up with function calls costing even more than
} alpha, because not only does the function call end up being a
} synchronization point for the compiler, it also means that the compiler
} cannot expose any parallelism, so you get an added hit from there.  At
} least with other CPU's that find the parallelism dynamically they can do
} out-of-order stuff across function calls. 

Yes, that's how I saw it didn't relate to the topic at hand.  I suggested
measurement rather than theory to determine whether the branch washes out
or not.  "Everyone knows" is a much weaker statement than "I can show".

} Did you READ my mail at all?

I definitely agree there.  If you need an instruction or two that the
compiler doesn't offer then it's a loss to call a function and inline asm
is worthwhile.  If this is a common enough case it's worth the compiler
adding inline asm support.  I'm not sure how often that is.  My own
subjective experience has been that calls to such code are rare enough that
they fall well into the realm of optimization the uncommon case.

I've used inline asm gratuitously in linux (it's peppered all over the ppc
code) because I had the feature.  I don't think that's a strong argument
for adding it to a compiler that doesn't support it, though.

} There are lots of good arguments for function calls: they improve icache
} when done right, but if you have some non-C-semantics assembler sequence
} like "cli" or a spinlock that you use a function call for, that would
} _decrease_ icache effectiveness simply because the call itself is bigger
} than the instruction (and it breaks up the instruction sequence so you
} get padding issues). 

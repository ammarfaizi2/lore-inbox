Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSLBJAc>; Mon, 2 Dec 2002 04:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSLBJAc>; Mon, 2 Dec 2002 04:00:32 -0500
Received: from ns.suse.de ([213.95.15.193]:9231 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261663AbSLBJAb>;
	Mon, 2 Dec 2002 04:00:31 -0500
Date: Mon, 2 Dec 2002 10:07:56 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>, ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021202090756.GA26034@wotan.suse.de>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com.suse.lists.linux.kernel> <1038804400.4411.4.camel@rth.ninka.net.suse.lists.linux.kernel> <p737kesu9bt.fsf@oldwotan.suse.de> <20021202.002815.58826951.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202.002815.58826951.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The data is where I'd say the bloat would be, and lo and behold is a
> nearly 7-fold increase for the sample you give us _only_ in the .data
> section.

.data is normally not a significant part of programs, because few programs
use global variables that heavily (yes, there are exceptions, like that emacs 
thing, but it's not common) 

It appear big in ls because it's a very small program, but even there
are absolute numbers don't make much difference (1K vs 7K, even 1K 
data needs one 4K page so the actual bloat is only another 4K) 

Regarding the stack use: we're using 6.3K kernel stack + separate interrupt
stack in the kernel. While there were a few problems with stack overflow 
it was usually very stupid bugs (like someone declaring a big long/pointer
array that just fit on 32bit, but exceeded it on 64bit). The normal
stack frame tend to be not that much bigger.

There is some heap bloat from pointers, but the effects are fairly
limited and I doubt ls will suffer from it significantly. Of course
when you're performance limited on a given problem it may be a good
idea to benchmark both -m32 and -m64, just to see if it's cache bound
by pointers. But I think -m64 is a good default nevertheless, simply
because the generated code is much better.

> BTW, I bet your dynamic relocation tables are a bit larger too.

Somewhat, but does it matter?  They are not kept in memory anyways.


-Andi

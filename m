Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUBUACk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUBUACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:02:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5625 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261437AbUBUAB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:01:58 -0500
Message-ID: <403551A1.7070208@mvista.com>
Date: Thu, 19 Feb 2004 16:15:29 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Tom Rini <trini@kernel.crashing.org>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz>	<20040204152137.500e8319.akpm@osdl.org>	<20040204232447.GC256@elf.ucw.cz>	<20040204235508.GB1086@smtp.west.cox.net> <20040204161626.1a2f8885.akpm@osdl.org>
In-Reply-To: <20040204161626.1a2f8885.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> 
>>Andrew, what features of George's version don't you like?
> 
> 
> This is bad:
> 
> akpm:/usr/src/25> grep '^+#ifdef' patches/kgdb-ga.patch | wc -l 
>      83
> 
> and the fact that it touches 36 different files.

Been away from this for a while, but I do think this needs a comment.  The fact 
that it touches 36 files is tilted rather strongly in that a good number of 
those files are in the Document/* tree.  I.e. there is a rather larger amount of 
documentation.

As to the #ifdefs, I once worked on a kernel (HPUX if you must know) where you 
could NOT remove the debug stub and its bits.  Turns out the kernel began to 
depend on the code that was supposed to be debugging it.  I rather strongly try 
to avoid Heisenberg and the nasty thinks that arise from this sort of thing.  I 
think you will find that most of those #ifdefs are "#ifdef CONFIG_KGDB" so that 
it you turn it off it is just as if the patch was not done (save the configure 
script, of course).

There is also the attempt to make one patch cover several kernels (such as in 
the 2.4 case where we may have O(1) or not) and also the preempt or not AND at 
the same time, want to debug the preempt code.
> 
> Any time I've had to do any maintenance work against that stub I get lost
> in a twisty maze and just whine at George about it.  It's just all over the
> place.  Yes, this is partly the nature of the beast, but I don't see that a
> ton of effort has been put into reducing the straggliness.

Yes, I agree.  Some of this is caused by the need to work with a rather fixed 
interface to gdb.  We would, for example, like to tell gdb to flush its cache 
from time to time.  It would also be nice if gdb were to hint to us about what 
it was trying to do.  The single step over a break point comes to mind here, as 
does the function call set up.  Still, improvements can be made.
> 


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


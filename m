Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbVKBPy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVKBPy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKBPy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:54:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965097AbVKBPyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:54:25 -0500
Date: Wed, 2 Nov 2005 07:54:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <52ll07a844.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0511020746330.27915@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
 <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home>
 <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
 <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com>
 <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com>
 <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> <52ll07a844.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Roland Dreier wrote:
> 
> I think we're actually agreeing.  My kmalloc/kzalloc patch is a cute
> hack but magic tricks like that aren't going to shrink the kernel by
> very much and it's probably not worth merging complications like that.

Right. I don't like having too many ways of doing the same thing - it just 
confuses things and makes different people have different "coding styles" 
and makes things less maintainable (I think the perl philosophy is 
broken).

> The way to a smaller kernel is for a lot of people to do a lot of hard
> work and look at where we can trim fat.

Yes. On the other hand, I do believe that bloat is a fact of life. 
Eventually somebody younger and leaver will come along and displace us. 
It's how things should be. We can (and should try to, of course) only 
delay the inevitable ;)

The fact is, we do do more, and we're more complex. Out VM is a _lot_ more 
complex, and our VFS layer has grown a lot due to all the support it has 
for situations that simply weren't an issue before. And even when not 
used, that support is there.

> For your last suggestion, maybe someone can automate running Andi's
> bloat-o-meter?  I think the hard part is maintaining comparable configs.

Yes. And we should probably make -Os the default. Apparently Fedora 
already does that by just forcibly hacking the Kconfig files.

With modern CPU's, instructions are almost "free". The real cost is in 
cache misses, and that tends to be doubly true of system software that 
tends to have a lot more cache misses than "normal" programs (because 
people try hard to batch up system calls like write etc, so by the time 
the kernel is called, the L1 cache is mostly flushed already - possibly 
the L2 too. And interrupts may be in the "fast path", but they'd sure as 
hell better not happen so often that they stay cached very well etc etc).

So -Os probably performs better in real life, and likely only performs 
worse on micro-benchmarks. Sadly, micro-benchmarks are often very 
instructive in many other ways.

			Linus

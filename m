Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUIBWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUIBWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIBWmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:42:44 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:20934 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269166AbUIBWgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:36:03 -0400
Date: Thu, 2 Sep 2004 18:35:57 -0400
From: Tom Vier <tmv@comcast.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902223557.GA15505@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:08:07PM -0700, Linus Torvalds wrote:
> > What about microkernels? They do tcp in userspace.
> 
> No they don't. They do TCP in a separate address space from user space, 
> that just also happens to be separate from the "microkernel address 
> space".

Well, I'd call that userspace (if it has a pid and it's own addr space, like
every other proc).

> So a microkernel will have _more_ address spaces, and they won't be "user
> space". They'll be "server deamon space" or something. Now, that's also
> why they tend to have performance problems - because you need to copy the
> data between different address spaces, and switch the CPU context etc
> around.

Just out of curiousity, what do you think of L4? I don't remember the
numbers, but it wasn't much slower than linux (iirc), even on x86. I think
k42 has msg passing close to the speed of a syscall. (Bulk data could use
shared mem, maybe.)

Anyway, it would be neat to have a tcp/ip daemon. You could run experimental
code w/o fear of it clobbering other things. Somethings, of course, a
microkernel can't help (if the rootfs's fs daemon dies, you're screwed). A
little bit more containment from bad kernel code would be nice.

(BTW, for those who don't know, mach optimized away msg passing and used a
single addr space, once code was "trusted". You could choose speed over
protection. That wasn't a hard choice since Mach msg passing sucks. Mach
gave microkernels a bad name.)

> Not user space. They may be "ring 3" from a CPU standpoint, but they 
> aren't user space from a _user_ standpoint - it's still very much a 
> separate address space, with domain protection.

How are they different from regular user procs, other then being trusted to
manage certain resources?
> In short: you _need_ to have a separate address space (either kernel, or
> "TCP server" or whatever) if you want to have reliable, secure and
> generally usable TCP.

Exokernels are another topic. 8)

> > As long as a trusted process keeps data such as free ports, what's the
> > problem?
> 
> None - because it's not user space any more. 

Yes it is, it's a user process.

> Well, performance might still suck, of course. And it does. 

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE

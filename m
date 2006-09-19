Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752005AbWISCSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWISCSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 22:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWISCSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 22:18:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752005AbWISCSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 22:18:25 -0400
Date: Mon, 18 Sep 2006 19:18:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au
Subject: Re: Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <9a8748490609181747i9da3107q593ab99ced48bced@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609181909090.4388@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> 
 <Pine.LNX.4.64.0609181549200.4388@g5.osdl.org> 
 <9a8748490609181614r55178f1djab68eb48bd36f7de@mail.gmail.com> 
 <Pine.LNX.4.64.0609181642200.4388@g5.osdl.org>
 <9a8748490609181747i9da3107q593ab99ced48bced@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Sep 2006, Jesper Juhl wrote:
> 
> Booting with: vga=normal no387 nofxsr
> gets me no forther.   These are all the messages I get:
> 
> boot: 2.6.18rc7git2 vga=normal no387 nofxsr
> Loading 2.6.18rc7git2...................................
> BIOS data check successful
> Uncompressing Linux... Ok, booting the kernel.
> 
> And then the system hangs and requires a power cycle.
> 
> So unfortunately that does't help much :-(

Ok. The next phase is to try to figure out where it hangs, and since it 
happens very early, that's most often most easily done the hard way: add 
some code that reboots the machine, and if the machine hangs, you didn't 
reach it.

These days there's a slightly easier approach: if you enable PM_TRACE 
support (you need to enable PM and PM_DEBUG and EXPERIMENTAL to get it), 
you can do

	#include <resume-trace.h>

at the top of a file, and add a sprinkling of "TRACE_RESUME(x)" calls 
(where "x" is some integer in the range 0-15 that you can use to save off 
the iteration count in a loop, for example - leave at 0 if you're not 
interested).

And then, when it hangs, once you reboot into the same kernel (without the 
"no387", so that it works ;), it should tell you where the last 
trace-point was fairly early in the bootup dmesg's.

(It _will_ screw up your time-of-day clock in the process, though, which 
is why tracing is so hard to enable on purpose ;)

		Linus

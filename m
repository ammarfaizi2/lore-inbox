Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUBAB2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 20:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUBAB2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 20:28:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63916
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264855AbUBAB2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 20:28:06 -0500
Date: Sun, 1 Feb 2004 02:28:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040201012803.GN26076@dualathlon.random>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401894DA.7000609@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 09:06:34PM -0800, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> 
> > Please let me know if you have any comments or suggestions. 
> 
> I really don't like this special address in the vdso approach.  Yes,
> it's unfortunately done for x86-64 as well but this doesn't mean the
> mistakes have to be repeated.

we investigated all possible implementations and we choosed for x86-64
the most efficient possible one. I think the current api was suggested
originally by hpa. Any other implementation would be running slower
period, so I wouldn't call it a mistake, I definitely call it a great
success, infact it is the best performing one for x86 too (this is why I
think john is using it). I know it's not nice from a computer science
theorical standpoint compared to other much slower implementations, but
when I run gettimeofday I want it to run as fast as possible, and I
don't care about anything else (well, besides the result being correct
of course ;), and I think the industry at large has my same needs. So I
definitely wouldn't trade it with anything else.

I'm unsure if we took care of implementing the backwards compatibility
-ENOSYS in the kernel at the next offsets of the vsyscalls, for making
it trivially extensible, if they're still missing we may want to add
them (there's no need to waste physical ram to do that btw). I had them
in my todo list for a while but at least from my part I never
implemented it, I'm sure I mentioned this had to be implemented a few
times though. Not sure if Andi or somebody else added the compatibility
-ENOSYS in the meantime. This is the sort of thing that nobody will
care about until it's too late. Well, it's not too bad anyways, the
current upgrade path would simply force an upgrade of kernel after
adding a glibc that has knowledge of the new vsyscalls, and overall
there would be no risk of any silent malfunction, it could only segfault
apps "safely". Also there is already space for at least two more
vsyscalls that currently are returning -ENOSYS. So overall even if we
don't add it, it probably won't matter much.

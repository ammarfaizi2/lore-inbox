Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265865AbUGDXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUGDXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGDXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 19:33:09 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:60032 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S265865AbUGDXdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 19:33:00 -0400
Date: Mon, 5 Jul 2004 01:32:50 +0200
From: andrea@cpushare.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20040704233250.GF7281@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <20040704143526.62d00790.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704143526.62d00790.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:35:26PM -0700, Andrew Morton wrote:
> Of course, yes, the patch is sufficiently safe and simple for it to be

Ok, great.

> mergeable in 2.6, if this is the way we want to do secure computing.  I'd

In the last weekends I evaluated many different ways to solve the issue
(most of them in userspace because they would have the huge advantage of
working in other OS too, the python way that parsed the bytecode looked
quite intriguing, but it's an order of magnitude slower compared to x86
bytecode and it was a lot more complex to make it work with the math
module and similar other safe operations, plus it was non portable to
non-x86 arch [though portable to other x86 OS] and I believe it was less
secure since the virtual machine was still involved).

At the end this linux centric kernel-space solution I'm proposing is the
only simple enough way that I would be confortable enough to trust
myself without feeling to risk anything, plus it will run the stuff at
full speed and with zero memory resource waste for another virtual
machine. This approach basically can only break if the cpu has bugs
(like 0xf00f or an mmx capable processor on a non-mmx aware OS, mmx is
not backwards compatible cpu feature w.r.t. security) but linux is
getting everything right in terms of cpu bugs.

BTW, of course this will also require a "safe" userspace loader, that
will take care of closing all file descriptors and to set the stack
rlimit before enabling the kernel feature, but that's very easy to
implement safely (even easier than the kernel side).

One interesting thing is that the vsyscalls will make gettimeofday
available too, but I don't think the output of gettimeofday can be
considered sensitive data. Though I need to keep an eye open on the
vsyscall page to be sure nothing sensitive goes in there.

> wonder whether the API should be syscall-based rather than /proc-based, and

I find the /proc-based simpler, but I certainly wouldn't be against
making it a syscall. So just let me know if you prefer to change it to a
syscall. The syscall would be a bit faster to run but it's not a fast
path.

> whether there should be a config option for it.

I don't think it worth to have a config option for this (you could
return to use testb instead of testw but it doesn't seem to be
significant enough to require a config option),

> But the wider questions are stuff like "where is all this coming from",
> "where will it all end up" and "what are the alternatives".

I'm not ready to talk about my usage, but it has absolutely nothing to do
with the kernel (except for needing this kind of feature from either the
kernel, or from an higher level virtual machine). So this probably
wouldn't be the appropriate forum.

Thanks a lot for the quick and positive comments.

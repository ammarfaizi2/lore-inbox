Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUHBK2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUHBK2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUHBK0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:26:47 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:25577 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266477AbUHBK0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:26:32 -0400
Date: Mon, 2 Aug 2004 12:25:27 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: chris@scary.beasts.org, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
Message-ID: <20040802102527.GK6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random> <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com> <20040801150119.GE6295@dualathlon.random> <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com> <1091393114.31139.5.camel@localhost.localdomain> <20040801231047.GI6295@dualathlon.random> <1091401677.31405.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091401677.31405.3.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, Aug 02, 2004 at 12:08:00AM +0100, Alan Cox wrote:
> One of the things that you can sensibly do I think which will also avoid
> a performance hit is to use the same kernel path as strace and friends
> do for syscall tracing but capture and verify the syscall in kernel mode
> rather than trapping back out. That will at least keep the usual fast
> path unharmed by the security toys.

The usual fast path is already unharmed by the security toys like
syscall auditing and seccomp mode (my only slowdown I introduced with
seccomp was to replace a testb with a testw, that doesn't count as a
slowdown, does it?). The only way to speedup the usual fast path is by
removing ptrace, everything already hooks into the ptrace testb/w.

About ptrace major issue being speed that's mostly true, but I'm not
sure what happens to uml if the tracer gets killed by oom, maybe it just
crashes at the next syscall, maybe not, dunno. I feel a lot safer in
having the secure computing happening inside seccomp than inside uml
from my part. I considered using uml before doing seccomp, but seccomp
was going to be a lot simpler and safer (and faster but I don't need
throughput in read/write/sigreturn/exit ;).

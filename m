Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUCIQia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbUCIQia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:38:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6669
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262045AbUCIQiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:38:25 -0500
Date: Tue, 9 Mar 2004 17:39:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309163905.GM8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309155917.GH8193@dualathlon.random> <20040309160709.GA10577@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309160709.GA10577@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 05:07:09PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > > or run the attached test-mmap2.c code, which simulates a very small DB
> > > app using only 1800 vmas per process: it only maps 8 MB of shm and
> > > spawns 32 processes. This has an even more lethal effect than the
> > > previous code.
> > 
> > this use more cpu than the previous one, but no other differences.
> 
> how fast is the system you tried this on? If it's faster than the 500

xeon 4-way 2.5ghz

> MHz box i tried it on then please try the attached test-mmap3.c. (which
> is still not doing anything extreme.)

it's not attached, but I guess I can hack the mmap2 myself too by just
increasing the number of tasks and number of mmaps ;).

But before doing more tests I think I will finish my anon_vma work and
the objrmap optimizations, then I can concentrante on the testing. At
the moment we already know various bits that can be optimized, so I
prefer to get those implemented first.

another important thing is that we've a reschedule point for every
different page we unmap, not sure if it's the case right now (I didn't
concentrate much on the callers yet).

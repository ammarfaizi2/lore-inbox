Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273868AbRIRGMJ>; Tue, 18 Sep 2001 02:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273867AbRIRGLu>; Tue, 18 Sep 2001 02:11:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5946 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273866AbRIRGLa>; Tue, 18 Sep 2001 02:11:30 -0400
Date: Tue, 18 Sep 2001 08:11:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918081146.J698@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <3BA6E032.587A1DBF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA6E032.587A1DBF@zip.com.au>; from akpm@zip.com.au on Mon, Sep 17, 2001 at 10:48:34PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 10:48:34PM -0700, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > Ok, the big thing here is continued merging, this time with Andrea.
> > 
> 
> In one test here the VM changes seem fragile, and slower.
> 
> Dual x86, 512 megs RAM, 512 megs swap.  No highmem.
> 
> The workload is:
> 
> 	while true
> 	do
> 		/usr/src/ext3/tools/usemem 300
> 	done
> 
> 	(This just mallocs 300 megs, touches it then exits)
> 
> in parallel with
> 
> 	time /usr/src/ext3/tools/bash-shared-mapping -n 5 -t 3 foo 300000000
> 
> on ext2.
> 
> (bash-shared-mapping is a tool which I wrote for ext3.  It's one of the
>  most aggressive VM/MM stress testers around, and has found a number of
>  kernel bugs).
> 
> On 2.4.9-ac10, the b-s-m run took 294 seconds.  On 2.4.10-pre11 it
> took 330 seconds DESPITE the fact that one of the b-s-m instances
> was oom-killed quite early in the test.
> 
> `vmstat' took about thirty seconds to start (this is usual), but
> was promptly killed, despite having (presumably) a small RSS.  Instances
> of `usemem' were oom-killed quite frequently.  In 2.4.9-ac10, nothing
> was oom-killed.

should be the very same problem identified by Marcelo. I'm wondering why
I didn't reproduced here during testing, 512mbytes is not highmem and my
desktop has 512mbytes too and it didn't killed anything yet. As for the
slowdown there are a few localized places to look at. but let's fix the
oom first.

> Andrea, it would be most useful if you were to spend some time (say, four hours)
> commenting the code and telling us how it works.

I will do that and I'll answer to any question ASAP, no panic. We may
even want to change part of the core logic over time if it doesn't
perform wonderfully. But first prio at the moment is to fix the oom you
also noticed (the "hiding" logic mentioned by Marcelo), the rest of the
changes should be a very solid base for a very solid and fast 2.4 vm.

Andrea

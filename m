Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273866AbRIRG1D>; Tue, 18 Sep 2001 02:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273867AbRIRG0w>; Tue, 18 Sep 2001 02:26:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56847 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273866AbRIRG0g>; Tue, 18 Sep 2001 02:26:36 -0400
Date: Tue, 18 Sep 2001 02:02:37 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918081146.J698@athlon.random>
Message-ID: <Pine.LNX.4.21.0109180201460.7152-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> On Mon, Sep 17, 2001 at 10:48:34PM -0700, Andrew Morton wrote:
> > Linus Torvalds wrote:
> > > 
> > > Ok, the big thing here is continued merging, this time with Andrea.
> > > 
> > 
> > In one test here the VM changes seem fragile, and slower.
> > 
> > Dual x86, 512 megs RAM, 512 megs swap.  No highmem.
> > 
> > The workload is:
> > 
> > 	while true
> > 	do
> > 		/usr/src/ext3/tools/usemem 300
> > 	done
> > 
> > 	(This just mallocs 300 megs, touches it then exits)
> > 
> > in parallel with
> > 
> > 	time /usr/src/ext3/tools/bash-shared-mapping -n 5 -t 3 foo 300000000
> > 
> > on ext2.
> > 
> > (bash-shared-mapping is a tool which I wrote for ext3.  It's one of the
> >  most aggressive VM/MM stress testers around, and has found a number of
> >  kernel bugs).
> > 
> > On 2.4.9-ac10, the b-s-m run took 294 seconds.  On 2.4.10-pre11 it
> > took 330 seconds DESPITE the fact that one of the b-s-m instances
> > was oom-killed quite early in the test.
> > 
> > `vmstat' took about thirty seconds to start (this is usual), but
> > was promptly killed, despite having (presumably) a small RSS.  Instances
> > of `usemem' were oom-killed quite frequently.  In 2.4.9-ac10, nothing
> > was oom-killed.
> 
> should be the very same problem identified by Marcelo. I'm wondering why
> I didn't reproduced here during testing, 512mbytes is not highmem and my
> desktop has 512mbytes too and it didn't killed anything yet. As for the
> slowdown there are a few localized places to look at. but let's fix the
> oom first.

Try to run several memory hungry threads (thus hiding more pages).


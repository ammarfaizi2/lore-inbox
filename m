Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277146AbRJQU2P>; Wed, 17 Oct 2001 16:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277148AbRJQU2F>; Wed, 17 Oct 2001 16:28:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25104 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277146AbRJQU14>; Wed, 17 Oct 2001 16:27:56 -0400
Date: Wed, 17 Oct 2001 17:06:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <20011017222108.C12055@athlon.random>
Message-ID: <Pine.LNX.4.21.0110171704090.11396-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Oct 2001, Andrea Arcangeli wrote:

> On Wed, Oct 17, 2001 at 11:21:03AM -0700, Linus Torvalds wrote:
> > 
> > On Wed, 17 Oct 2001, Marcelo Tosatti wrote:
> > > >
> > > > And I've for a long time thought about adding a "readahead()" system call.
> > > > There are just too many uses for it, it has come up in many different
> > > > areas..
> > >
> > > There is a paper on USENIX 2001 which does implement directory readahead
> > > and it shows huge improvements for some workload.
> > 
> > Hmm.. The implementation is trivial, it's really just a simple 3-line
> > while-loop, with the rest of the code just doing argument checking etc.
> > 
> > Attached is the kernel diff ("ra-diff") along with a stupid program
> > ("preread.c"), cribbed mostly from Pauls first patch to use it to pre-read
> > a while tree.
> > 
> > It took much longer to compile the kernel and reboot, and write the
> > test-program than it did to write the patch itself ;)
> > 
> > It walks the whole kernel tree in 0.2 seconds of CPU-time on my machine
> > (of course, if it actually needs to start IO, the 0.2 seconds becomes 0.3
> > seconds of CPU time and almost a minute and a half of wall-clock.
> > Anyway, it clearly isn't a CPU-hog like doing a real "read" would have
> > been).
> 
> I think with directory readahead Marcelo meant a transparent kernel
> heuristic in the readdir path. ext2_get_page is completly synchronous
> and it's reading one page at time, that's bad but it can be improved
> transparently to userspace, just like we do with the files, and also
> like the old code was doing before the directory in pagecache IIRC.

Exactly. 

Btw, the USENIX 2001 paper is called "Design and Implementation of a
Predictive File Prefetching Algorithm".

They have a Linux implementation of their complex prediction algo, but I
think directory readahead itself makes sense for most stuff.


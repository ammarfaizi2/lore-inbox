Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277751AbRJIO5Q>; Tue, 9 Oct 2001 10:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277752AbRJIO47>; Tue, 9 Oct 2001 10:56:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42760 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277751AbRJIO4X>; Tue, 9 Oct 2001 10:56:23 -0400
Date: Tue, 9 Oct 2001 11:34:47 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <20011009165002.H15943@athlon.random>
Message-ID: <Pine.LNX.4.21.0110091129260.5604-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Oct 2001, Andrea Arcangeli wrote:

> On Tue, Oct 09, 2001 at 10:44:37AM -0200, Marcelo Tosatti wrote:
> > 
> > Hi, 
> > 
> > I've been testing pre6 (actually its pre5 a patch which Linus sent me
> > named "prewith 16GB of RAM (thanks to OSDLabs for that), and I've found
> > out some problems. First of all, we need to throttle normal allocators
> > more often and/or update the low memory limits for normal allocators to a
> > saner value. I already said I think allowing everybody to eat up to
> > "freepages.min" is too low for a default.
> > 
> > I've got atomic memory failures with _22GB_ of swap free (32GB total):
> > 
> >  eth0: can't fill rx buffer (force 0)!
> > 
> > Another issue is the damn fork() special case. Its failing in practice:
> > 
> > bash: fork: Cannot allocate memory
> > 
> > Also with _LOTS_ of swap free. (gigs of them)
> 
> It could be just fragmentation but the fact it doesn't happen in
> non-highmem pretty much shows that shows the memory balancing isn't
> doing the right thing, you hide the problem with the infinite loop for
> non atomic order 0 allocations and that's just broken, as best it will
> be slower in collecting the right pages away.
> 
> My approch shouldn't fail so easily in fork despite I'm not looping in
> fork either, because I'm trying to do better decisions since the first
> place in the memory balancing, I don't wait the infinite loop to
> eventually collect away the right pages.

The problem may well be in the memory balancing Andrea, but I'm not trying
to hide it with the infinite loop.

The infinite loop is just a guarantee that we'll have a reliable way of
throttling the allocators which can block. Not doing the infinite loop is
just way too fragile IMO and it is _prone_ to fail in intensive
loads. 

If the problem is the highmem balancing, I'll love to get your fixes and
integrate with the infinite loop logic, which is a separated (related,
yes, but separate) thing.


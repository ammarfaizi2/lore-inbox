Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318350AbSG3Q40>; Tue, 30 Jul 2002 12:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318351AbSG3Q40>; Tue, 30 Jul 2002 12:56:26 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:5874 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318350AbSG3Q4Y>; Tue, 30 Jul 2002 12:56:24 -0400
Date: Tue, 30 Jul 2002 12:59:43 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730125943.B10315@redhat.com>
References: <20020730054111.GA1159@dualathlon.random> <20020730091140.A6726@infradead.org> <20020730164320.GH1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730164320.GH1181@dualathlon.random>; from andrea@suse.de on Tue, Jul 30, 2002 at 06:43:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 06:43:20PM +0200, Andrea Arcangeli wrote:
> > 
> > Please don't.  First Ben has indicated on kernel summit that the abi might
> > change and I think it's a bad idea to lock him into the old ABI just because
> 
> What I heard and that I remeber crystal clear is that Ben indicated that
> the API isn't changing for a long time, and that's been stable so far,
> I could imagine why.

I suspect what Christoph is remember is that the in-kernel API was still 
in flux and up for discussion.

> I'm trying to do my best to avoid having to merge the code I quoted
> above, that's disgusting and since the api isn't gonna change anwyays
> like Ben said I'm trying to do the right thing to avoid clashes with
> syscall 250 as well.

syscall 250 isn't used in anything Red Hat shipped, that was a matter 
of experimentation I was doing in recent aio development trees (which 
is what the 2.4.18 patches are, as they still cause that VM to OOM under 
rather trivial io patterns).

> Really last thing: one of the major reasons I don't like the above code
> besides the overhead and complexity it introduces is that it doesn't
> guarantee 100% that it will be forward compatible with 2.5 applications
> (the syscall 250 looks not to check even for the payload, I guess they
> changed it because it was too slow to be forward compatible in most
> cases), the /dev/urandom payload may match the user arguments if you're
> unlucky and since we can guarantee correct operations by doing a syscall
> registration, I don't see why we should make it work by luck.

You haven't looked at the code very closely then.  It checks that the 
payload matches, and that the caller is coming from the vsyscall pages.  
Yes, the dynamic syscall thing is a horrific kludge that shouldn't be 
used, but the vsyscall technique is rather useful.  This is something 
that x86-64 gets wrong by not requiring the vsyscall page to need an 
mmap into the user's address space: UML cannot emulate vsyscalls by 
faking the mmap.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

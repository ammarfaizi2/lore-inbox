Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQJ3Ik1>; Mon, 30 Oct 2000 03:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbQJ3IkR>; Mon, 30 Oct 2000 03:40:17 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8198 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129050AbQJ3IkB>; Mon, 30 Oct 2000 03:40:01 -0500
Date: Mon, 30 Oct 2000 01:36:42 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030013642.A19869@vger.timpanogas.org>
In-Reply-To: <200010300823.BAA19834@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200010300823.BAA19834@vger.timpanogas.org>; from MAILER-DAEMON@vger.timpanogas.org on Mon, Oct 30, 2000 at 01:23:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > I just guess the end result will be as crash prone as Netware when you install any third
> > party software ;) 
> > 
> > lazy mm is probably a better path, as long as you stay in kernel threads and a single user mm
> > it'll never switch VMs.
> 
> It's not that bad.  Some code has been running for years and will be OK.  
> Also, the number of Ooops people get anyway on Linux today is about the
> same state as Abends were in NetWare in their frequency in Live customers
> accounts.  I've also seen miscreant user apps in Linux wreck havoc 
> from user space as deadly as an Oops.
> 
> It's not the activity in the lan path that's the problem, it's the switching
> period that's the problem.  The fix goes in the loader -- trusted apps get 
> loaded in the kernel, non-trusted apps get loaded in a ring 3 address space.
> The WTD thing I described stops them from context switching until the 
> system goes ile, since LAN I/O always gets moved to the front of the 
> work queue, if you remember my post describing it.  NetWare does this
> trick by holding off CR3 reloads to apps until the server goes idle
> relative to incoming or outging I/O.  Linus just lets both happen 
> all over the place.  I'll show you end of December with the port.  Ring 3
> apps will still work - you'll just be able to load some of them at ring 0,
> and run like bat out of hell.
> 
> You are right though, Linux is like a tank going 25 miles an hour crushing
> everything in it's path, while NetWare is an aluminum frame speed racer 
> that weighs 20 lbs., gets 1000 miles to the gallon, runs at MACH VI, and
> will explode in flames if it hits a tack in the road...
> 
> :-)
> 
> > > stack.  Since you look at MANOS code, you'll note that in 
> > > CONTEXT.386, I do and add esp, 3 * 4 instead of poppping the segment
> > > registers off the stack if they are in the kernel address space.  
> > > 
> > > Linux should do the same, if possible as an optimization.
> > 
> 
> 
> 
> > Interesting. You could do easily the same in Linux by changing (in 2.2) the SAVE_ALL macro
> > in arch/i386/kernel/irq.h and doing the same in ret_from_intr's RESTORE_ALL macro (after
> > changing it to a RESTORE_ALL_INT or you'll break system calls) 
> > 
> > Actually I don't even know why irq.h's SAVE_ALL even loads __KERNEL_CS, it should be already
> > set by the interrupt gate. __KERNEL_DS probably needs to be still loaded, but only when
> > you came from user space.
> 
> Sounds like a fun patch.  I'll get to work on it.  Might want to ping Linus,
> and let him put this one in, since it's his code, and would be a very easy 
> fix.  The more lipo-suction we could do, the better.
> 
> :-)
> 
> Jeff
> 
> 
> 
> > 
> > -Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

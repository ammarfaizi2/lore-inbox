Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283753AbRK3SdV>; Fri, 30 Nov 2001 13:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283747AbRK3SdM>; Fri, 30 Nov 2001 13:33:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27762 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S283753AbRK3SdB>; Fri, 30 Nov 2001 13:33:01 -0500
Date: Fri, 30 Nov 2001 19:33:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Google Test and 2.4.16
Message-ID: <20011130193323.P2997@athlon.random>
In-Reply-To: <3C0542F3.5A9F0EAA@mvista.com> <20011129034300.H1465@athlon.random> <3C07CD6F.19365686@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C07CD6F.19365686@mvista.com>; from jpuhlman@mvista.com on Fri, Nov 30, 2001 at 10:18:23AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 10:18:23AM -0800, Jeremy Puhlman wrote:
> Andrea Arcangeli wrote:
> 
> > On Wed, Nov 28, 2001 at 12:02:59PM -0800, Jeremy Puhlman wrote:
> > > Ok yesterday got the google tests running...The machine I ran it on
> > > was a standard (Old) white box...Athlon k6-450 with 128 MB of
> > > Ram....Using 256 MB of swap....The google test tries to use an
> > > adjustable 1/2 terra byte Block size...This is unrealistic for an
> > > embedded system or my system for that matter..So in trying to tune the
> > > test to the system it seems they would not run unless the block size
> > > was less then 60 MB...Not sure what the deal was...I tried turning on
> > > memory-overcommit but no dice...
> > >
> > > So basically I ran the test once through and every thing went fine...The
> > >
> > > test didn't seem to really stress the system very much...
> > >
> > > So I ran the same program 4 times, concurrently...The system did not
> > > seem to lose any responsiveness....This did stress the vm system since
> > > each of the processes were grabbing 60 megs...
> > >
> > > I did find that once the 4 processes finished their runs. I ran one
> > > more just for fun...Then the system locked up...
			       ^^^^^^^^^^^^^^^^^^^^
> >
> > this won't happen in 2.4.15aa1.
> >
> > Andrea
> 
> Yes it does happen on 2.4.15aa1....Actually 2.4.15aa1 does even get through
> the first set of runs....see attached opps/sysreqs/system.map...

ah but you get an oops! That has nothing to do with the bug triggered by
the google workload.  I thought "the system locked" above meant it was a
live lock like it was happening before fixing the kernel bug that was
generating the live lock with the google workload. I couldn't imagine
"the system locked" meant "I got an oops", sorry.

So let's check the Oops:

Unable to handle kernel NULL pointer dereference at virtual address
00000200
 printing eip:
00000200
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000200>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b77a0   ecx: c8800000   edx: 00000002
esi: 00000002   edi: c10456c0   ebp: c025b4c0   esp: c7fe7f20
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c7fe7000)
Stack: c10456a4 c0126911 c02b77a0 c7fe6000 0000060e c025b610 0000004e
0000001d
       c11e7d50 c0820000 c11e7b90 00000001 0000001f c025b610 000001d0
c025b610
       c0126b94 000001d0 c7fe7f88 00000020 00000020 000001d0 c0126bff
c7fe7f88
Call Trace: [<shrink_cache+0x321>] [<shrink_caches+0x64>]
[<try_to_free_pages+0x5f>] [<kswapd_balance_pgdat+0x51>]
[<kswapd_balance+0x16>]
   [<kswapd+0xa1>] [<kswapd+0x0>] [<kernel_thread+0x2b>]

this sounds like faulty hardware. Are you sure your ram is not buggy?
I will start now an infinite loop of the google workload. How many runs
it takes exactly before you can reproduce btw?

Before fixing the bug I could reproduce the live lock just during the
first run. So to verify the problem was fixed I run 3/4 runs of the
workload but never more than this (mainly because of the pause() that
forced me to C^c without automating the loop, I will now drop the
pause() and start an infinite loop).

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265091AbRGEUqL>; Thu, 5 Jul 2001 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265438AbRGEUqB>; Thu, 5 Jul 2001 16:46:01 -0400
Received: from sdsl-66-80-62-153.dsl.sca.megapath.net ([66.80.62.153]:48910
	"EHLO ripple.fruitbat.org") by vger.kernel.org with ESMTP
	id <S265091AbRGEUp5>; Thu, 5 Jul 2001 16:45:57 -0400
Date: Thu, 5 Jul 2001 13:45:23 -0700 (PDT)
From: "Peter A. Castro" <doctor@fruitbat.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <994279551.1116.0.camel@tux>
Message-ID: <Pine.LNX.4.21.0107051219080.4734-100000@gremlin.fruitbat.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jul 2001, Ronald Bultje wrote:

> Hi,

Hi back at you :-)

> you might remember an e-mail from me (two weeks ago) with my problems
> where linux would not boot up or be highly instable on a machine with
> 256 MB RAM, while it was 100% stable with 128 MB RAM. Basically, I still
> have this problem, so I am running with 128 MB RAM again.

This can mean (but is not limited to) that the second memory module is
bad, or can't keep up with the DRAM controller.  An obvious test is to
replace your existing memory module with the other memory module and see
if you experience problems.  If you experience no problems, then it's not
the module.  Most likely it's the DRAM controller (or a capacitence
problem due to timing).  Some BIOSs allow you to adjust the DRAM
controller timings (RAS, CAS, clock).  You may have to slow down the
timings to stabalize the memory access.

I have a DELL computer at work that is supposed to be able to take 128M
(4 banks of 32M) in SIMMs, but no matter what brand of memory (I went
through 4 different manufacturers), it always caused OS crashes.  Yet, if
I load it with 64M (4 banks of 16M) its completely stable.  That
computers BIOS doesn't allow me to change the DRAM timings, so I'm stuck
with 64M.  This is just to illustrate that it might not be the memory,
but the controller thats the problem. 

> I've been running Mandrake 7.2 on another machine for some time - no
> problem, until..... I added another 64 MB RAM and tried to install
> redhat (25 times (!!!)) and Mandrake 8.0... Both crash with memory
> faults..... Redhat just freezes or givesa a python warning, Mandrake
> gives a segfault with a warning that "memory is missing".... Both refuse
> to complete installation...

When you boot the installer (either from CD or floppy) you get the option
to add kernel parameters before the installer kernel actually boots.  Try
adding the parameter "mem=128M" or "mem=64M".  This will restrict the
installer to using a subset of the total memory.  In my experience, the
installer environment of most distributions is not very robust, but once
installed, the normal system is quite stable.

> I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> my house with more than 128 MB RAM?!? Can someone please point out to me
> that he's actually running kernel-2.4.x on a machine with more than 128
> MB RAM and that he's NOT having severe stability problems?
> And can that same person PLEASE point out to me why 2.4.x is crashing on
> me (or help me to find out...)?

Really, we need more information than "can't linux-2.4.x run on ANY
machine".  What brand/make motherboard?

> First machine is a Intel P-II 400 with 128 MB RAM (133 MHz SDRAM) and
> crashing when I insert an additional 128 - it's running RH-7.0 with
> kernel-2.4.4. Second machine is an AMD Duron 600 with 196 MB RAM (also
> 133 MHz SDRAM), crashing during the installation of both Mandrake 8.0
> and Redhat 7.1 and which used to run stable with 128 MB RAM or 64 MB RAM
> with Mandrake-7.2. Win2k runs stable on this machine in all
> configurations.

Each OS allocates the physical memory differently.  MS-Windows typically
allocates physical memory sequentually.  Linux tends to uses both ends of
the memory pool.  For a proper test, you need to load enough programs so
that all of physical memory will be utilized.  Win2k may be "stable"
because you aren't loading enough of the system to touch the second bank
of memory.  Please try running several large programs and exercise them
all together for several minutes.  You can use the task manager to find
the total memory used on the system. 

> I'm getting desperate.... win2k is running stable and it's scary to see
> linux crash while win2k runs stable and smooth.

It's kinda funny, but I actually use MS-Windows NT as a memory/controller
tester ;-).  In my experience, I've found that Windows is much more
demanding/picky of the hardware than Linux is (Linux installer
experiences being the notable exception). 

> (ps I'm not subscribed to the list - please CC a copy to me when
> replying)
> 
> Thanks in advance for any help on this,
> --
> Ronald Bultje

-- 
Peter A. Castro <doctor@fruitbat.org> or <Peter.Castro@oracle.com>
	"Cats are just autistic Dogs" -- Dr. Tony Attwood


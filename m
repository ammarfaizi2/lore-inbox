Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbRA3QZi>; Tue, 30 Jan 2001 11:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbRA3QZ2>; Tue, 30 Jan 2001 11:25:28 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21005 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129906AbRA3QZP>; Tue, 30 Jan 2001 11:25:15 -0500
Date: Tue, 30 Jan 2001 10:19:58 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Todd <todd@unm.edu>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
Message-ID: <20010130101958.A18047@vger.timpanogas.org>
In-Reply-To: <20010129164953.A15219@vger.timpanogas.org> <Pine.A41.4.31.0101292123270.54650-100000@aix06.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.A41.4.31.0101292123270.54650-100000@aix06.unm.edu>; from todd@unm.edu on Mon, Jan 29, 2001 at 09:41:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 09:41:21PM -0700, Todd wrote:

Todd,

I ran the tests on a box that has a limit of 70MB/S PCI throughput.  
There are GaAs (Gallium Arsenide) implementations of SCI that run 
well into the Gigabyte Ranges, and I've seen some of this hardware.  
The NUMA-Q chipsets in Sequents cluster boxes are actually SCI.  
Sun Microsystems uses SCI as their clustering interconnect for their 
Sparc servers.  The adapters these drivers I posted support are a bi-CMOS 
implementation of the SCI LC3 chipsets, and even though they are 
bi-CMOS, the Link speed on the back end is still 500 MB/S --
very respectable.

The PCI-SCI cards these drivers support in PCI systems have been clocked up 
to 140 MB/S+ on those systems that have enough bandwidth to actually 
push this much data.  These boards can pump up to 500MB/S over the 
SCI fabric, however, current PCI technology doesn't allow you to 
push this much data.  I also tested on the D320 chipsets, the newer 
D330 chipsets on the PSB66 cards support the 66Mhz bus and have been 
measured up to the Max PCI speeds.

The PCI-SCI adapters run circles around G-Enet on systems that can 
really pump this much data through the PCI bus.  Also, the numbers I 
posted are doing push/pull DMA transfers between user_space -> user_space 
in another system with **NO COPYING**.  Ethernet and LAN networking always 
copies data into userspace -- SCI has the ability to dump it directly 
into user space pages without copying.  That's what is cool about SCI, 
you can pump this data around with almost no processor utilization -- 
important on a cluster if you are doing computational stuff -- you need 
every cycle you can squeeze, and don't want to waste them copying 
data all over the place.  Sure, G-Enet can pump 124 MB/S, but the 
processor utilitzation will be high, and there will be lots of 
copying going on in the system.   What numbers does G-Enet provide 
doing userspace -> userspace transfers, and at what processor 
overhead?  These are the types of things that are the metrics for 
a good comparison.  Also, G-Enet has bandwidth limitations, the 
SCI standard does not, it's only limited by the laws of Physics
(which are being reached in the Dolphin Labs in Norway).

The GaAs SCI technology I have seen has hop latencies in the SCI 
switches @ 16 nano-seconds to route a packet, with xfer rates into
the Gigabytes per second -- very fast and low latency.   

These cards will use whatever PCI bandwidth is present in the host 
system, up to 500 MB/S.  As the PCI bus gets better, nice to know 
SCI is something that will keep it's value, since 500 MB/S gives us 
a lot of room to grow into.    

I could ask Dolphin for a GaAs version of the LC3 card (one board would
cost the equivalent to the income of a small third world nation), and 
rerun the tests on a Sparc system or Sequent system, and watch G-Enet
system suck wind in comparison.  

:-)

I posted the **ACCURATE** numbers from my test, but I did clarify that I 
was using a system with a limp PCI bus.

Jeff


> folx,
> 
> i must be missing something here.  i'm not aware of a PCI bus that only
> supports 70 MBps but i am probably ignorant.  this is why i was confused
> by jeff's performance numbers.  33MHz 32-bit PCI busses should do around
> 120MB/s (just do the math 33*32/8 allowing for some overhead of PCI bus
> negotiation), much greater than the numbers jeff is reporting.  66 MHz
> 64bit busses should do on the order of 500MB/s.
> 
> the performance numbers that jeff is reporting are not very impressive
> even for the slowest PCI bus.  we're seeing 993 Mbps (124MB/s) using the
> alteon acenic gig-e cards on 32-bit cards on a 66MHz bus.  i would expect
> to get somewhat slower on a 33MHz bus but not catastrophically so
> (certainly nothing as slow as 60MB/s or 480Mb/s).
> 
> what am i misunderstanding here?
> 
> todd
> 
> On Mon, 29 Jan 2001, Jeff V. Merkey wrote:
> 
> > Date: Mon, 29 Jan 2001 16:49:53 -0700
> > From: Jeff V. Merkey <jmerkey@vger.timpanogas.org>
> > To: linux-kernel@vger.kernel.org
> > Cc: jmerkey@timpanogas.org
> > Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
> >
> >
> > Relative to some performance questions folks have asked, the SCI
> > adapters are limited by PCI bus speeds.  If your system supports
> > 64-bit PCI you get much higher numbers.  If you have a system
> > that supports 100+ Megabyte/second PCI throughput, the SCI
> > adapters will exploit it.
> >
> > This test was performed in on a 32-bit PCI system with a PCI bus
> > architecture that's limited to 70 MB/S.
> >
> > Jeff
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
> 
> =========================================================
> Todd Underwood, todd@unm.edu
> 
> criticaltv.com
> news, analysis and criticism.  about tv.
> and other stuff.
> 
> =========================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

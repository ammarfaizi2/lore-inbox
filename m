Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136459AbRD3Gqw>; Mon, 30 Apr 2001 02:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136460AbRD3Gqm>; Mon, 30 Apr 2001 02:46:42 -0400
Received: from front5m.grolier.fr ([195.36.216.55]:47764 "EHLO
	front5m.grolier.fr") by vger.kernel.org with ESMTP
	id <S136459AbRD3Gqf> convert rfc822-to-8bit; Mon, 30 Apr 2001 02:46:35 -0400
Date: Mon, 30 Apr 2001 05:35:14 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Steffen Persvold <sp@scali.no>
cc: nick@snowman.net, lkml <linux-kernel@vger.kernel.org>, davej@suse.de,
        troels@thule.no
Subject: Re: ServerWorks LE and MTRR
In-Reply-To: <3AEC9823.EEC8EC46@scali.no>
Message-ID: <Pine.LNX.4.10.10104300519330.782-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Apr 2001, Steffen Persvold wrote:

> nick@snowman.net wrote:
> > On Sun, 29 Apr 2001, Steffen Persvold wrote:
> > 
> > > I've learned it the hard way, I have two types : Compaq DL360 (rev 5) and a
> > > Tyan S2510 (rev 6). On the compaq machine I constantly get data corruption on
> > > the last double word (4 bytes) in a 64 byte PCI burst when I use write
> > > combining on the CPU. On the Tyan however the transfer is always ok.
> > >
> > 
> > Are you sure that is not due to board design differences?
> 
> No I can't be 100% certain that the layout of the board isn't the reason since
> I haven't asked ServerWorks about this and it doesn't say anything in their
> docs (yes my company has the NDA, so I shouldn't get to much in detail here),
> but if this was the case it would be totally wrong to disable write combining
> on any LE chipset.
> 
> The test case that I have been using to trigger this is sort of special because
> we are using SCI shared memory adapters to write (with PIO) into remote nodes
> memory, and the bandwidth tends to get quite high (approx 170 MByte/sec on LE
> with write combining). I've been able to run this case on 5 different
> motherboards using the LE and HE-SL ServerWorks chipsets, but only two of them
> are LE (the DL360 and the S2510). Everything works fine with write-combining on
> every motherboard except the DL360 (which has rev 5).
> 
> One basic test case that I haven't tried, could be to enable write-combining on
> your PCI graphics adapter memory and see if the X display gets screwed up.

Done since 8 months on my Supermicro 370 DLE board. /proc/pci tells about 
2 PCI bridges rev. 5. The 64bit PCI (bus 1) is interfacing a LSI53C1010
33MHz 64 bit PCI-SCSI controller. The other devices (3dfx, SYM53C895, ...)
are on PCI bus #0. The machine does network using an external modem only.
Never got a single glitch (linux-2.2.18), but the machine is not a server
but my workstation I use at home.

Here is /proc/pci layout:
PCI devices found:
  Bus  0, device   0, function  1:
    Host bridge: Unknown vendor CNB30LE PCI Bridge (rev 5).
      Medium devsel.  Master Capable.  Latency=16.  
  Bus  0, device   0, function  0:
    Host bridge: Unknown vendor CNB30LE PCI Bridge (rev 5).
      Medium devsel.  Master Capable.  Latency=32.  
  Bus  0, device   1, function  0:
    SCSI storage controller: NCR 53c895 (rev 1).
      Medium devsel.  IRQ 16.  Master Capable.  Latency=72.  Min Gnt=30.Max Lat=64.
      I/O at 0xde00 [0xde01].
      Non-prefetchable 32 bit memory at 0xfeaefe00 [0xfeaefe00].
      Non-prefetchable 32 bit memory at 0xfeaec000 [0xfeaec000].
  Bus  0, device   2, function  0:
    SCSI storage controller: NCR 53c810 (rev 18).
      Medium devsel.  IRQ 18.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=64.
      I/O at 0xd400 [0xd401].
      Non-prefetchable 32 bit memory at 0xfeaeff00 [0xfeaeff00].
  Bus  0, device   3, function  0:
    VGA compatible controller: 3Dfx Unknown device (rev 1).
      Vendor id=121a. Device id=5.
      Fast devsel.  Fast back-to-back capable.  IRQ 20.  
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc000000].
      Prefetchable 32 bit memory at 0xf8000000 [0xf8000008].
      I/O at 0xd800 [0xd801].
  Bus  0, device   6, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 31.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeaed000 [0xfeaed000].
      I/O at 0xd000 [0xd001].
      Non-prefetchable 32 bit memory at 0xfe900000 [0xfe900000].
  Bus  0, device  15, function  0:
    ISA bridge: Unknown vendor Unknown device (rev 79).
      Vendor id=1166. Device id=200.
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device  15, function  1:
    IDE interface: Unknown vendor Unknown device (rev 0).
      Vendor id=1166. Device id=211.
      Medium devsel.  Master Capable.  Latency=64.  
      I/O at 0xffa0 [0xffa1].
  Bus  0, device  15, function  2:
    USB Controller: Unknown vendor Unknown device (rev 4).
      Vendor id=1166. Device id=220.
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xfeaee000 [0xfeaee000].
  Bus  1, device   1, function  1:
    SCSI storage controller: NCR Unknown device (rev 1).
      Vendor id=1000. Device id=20.
      Medium devsel.  IRQ 25.  Master Capable.  Latency=72.  Min Gnt=17.Max Lat=18.
      I/O at 0xe800 [0xe801].
      Non-prefetchable 64 bit memory at 0xfebffc00 [0xfebffc04].
      Non-prefetchable 64 bit memory at 0xfebfc000 [0xfebfc004].
  Bus  1, device   1, function  0:
    SCSI storage controller: NCR Unknown device (rev 1).
      Vendor id=1000. Device id=20.
      Medium devsel.  IRQ 24.  Master Capable.  Latency=72.  Min Gnt=17.Max Lat=18.
      I/O at 0xe400 [0xe401].
      Non-prefetchable 64 bit memory at 0xfebff800 [0xfebff804].
      Non-prefetchable 64 bit memory at 0xfebfa000 [0xfebfa004].

> I will try to get some information from ServerWorks about this problem, but I'm
> not sure if ServerWorks would be happy if I told you the answer (because of the
> NDA).

Hope this thread will let them properly answer. You should told them
about, in my opinion ...
You may then tell the answer to mtrr.c that is unable sign NDAs... :-)

Regards,
   Gérard.

> Regards,
> -- 
>  Steffen Persvold                        Systems Engineer
>  Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
>  Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
>           Fax  : (+47) 2262 8951         N-0621 Oslo, Norway
> 
>  USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
>                                          Houston, Texas 77042, USA
> 


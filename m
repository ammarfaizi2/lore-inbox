Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbRENIKq>; Mon, 14 May 2001 04:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbRENIKf>; Mon, 14 May 2001 04:10:35 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:56192 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S262034AbRENIK1>; Mon, 14 May 2001 04:10:27 -0400
Date: Mon, 14 May 2001 17:09:52 +0900
Message-Id: <200105140809.f4E89qO11455@norma.kjist.ac.kr>
From: root <root@norma.kjist.ac.kr>
To: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 3c590 vs. tulip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen (ak@suse.de) wrote
>
>On Fri, May 11, 2001 at 09:27:29AM -0400, Dan Mann wrote: 
>> I was just wondering if anybody had an idea which nic card might be a better 
>> choice for me; I have a pci 3c590 and a pci smc that uses the tulip driver. 
>> I don't have the card number for the smc with me handy, however I know both 
>> cards were manufactured in 1995. Is either card/driver a better choice for 
>> a mildly used file server (I am running 2.4.4 Linus)? 
>
>As of 2.4.4 newer 3c90x (I guess you mean that, 3c59x should be mostly 
>extinct now) are a better choice because they support zero copy TX and 
>hardware checksumming while tulip does not. 

On http://www.scyld.com/expert/100mbps.html
Venerable Don Becker wrote:

> 
> DEC "Tulip" 21140/21142/21143 
>     Bus master, with same clean and fast packet interface of the 10Mbs
>     21040, but a with different serial subsubsystem. It's used on the SMC
>     PCI EtherPower and most other 100Mbs cards.
>     A limitation of the current chips is that packets may only be received
>     into long-aligned buffers, which results in the IP header being
>     misaligned. For some word-oriented architectures, such as Digital's
>     own Alpha, this results in pointless copying. Programming info: The
>     datasheet is readily available online or from DEC.
>     Driver: I've written a Linux device driver that works with most
>     Tulip-based adapter. 
>     Multicast support: The DEC Tulip chip has the best design of the
>     commodity chips. Its reception filter has several modes. In addition to
>     the common hardware multicast hash filter mode (with 512 entries,
>     rather than the common 64 entries), it has a mode where it can
>     accept any of 16 specific addresses, either multicast or physical. 
>     Large packet support: The tulip chips can be configured to extend
>     the normal Tx jabber clock from 1.6-2.0 msec. (2048 to 2560
>     transmitted octets) to 26-33 msec. Similarly, the "Rx watchdog"
>     timer can be disabled so that any length packet may be received.
>     (Untested.)
> 3Com Vortex 
>     Uses primarily a programmed-I/O interface similar to the 3c509, but
>     has a limited bus master capability. The chip is used only on the
>     3c595 board.
>     Programming info: The programming manual is readily available
>     from 3Com. 
>     Driver: I've written a Linux device driver for the 3c590 and 3c595. 
>     Large packet support: The Vortex chips can be explicitly
>     configured to support 4.5K (FDDI-sized) packets. 
>     Multicast support: The 3Com Vortex chips, like the rest of the
>     EtherLink III series, have no hardware multicast filter. Multicast
>     reception is enabled by a "receive all multicast packets" bit.
> 3Com Boomerang 
>     An update to the 3Com Vortex, this chip primarily uses a full
>     descriptor-based bus-master interface, similar to the AMD, Tulip
>     and Speedo3 chips. The programmed-I/O interface of the Vortex is
>     currently retained, but is scheduled to be deleted in future chip
>     revisions. This chip is used only on the 3Com EtherLink III XL
>     boards, the 3c900 series.
>     Programming info: The programming manual will soon be available
>     from 3Com. 
>     Driver: I've enhanced the Linux Vortex device driver to use this
>     chip in PIO mode. A new driver supporting the full-bus-master
>     mode is in progress. 
>     Large packet support: Like the Vortex chip, the Boomerang can be
>     explicitly configured to support 4.5K (FDDI-sized) packets. 
>     Multicast support: This chip, like the rest of the EtherLink III
>     series, have no hardware multicast filter. Multicast reception is
>     enabled by a "receive all multicast packets" bit.
> Intel Speedo-3 i82557/i82558 
>     The chip has an interface similar to the other Intel network chips,
>     with a direct PCI interface and the "SCB" implemented as registers
>     visible in I/O and memory space. The chip is used on the Intel
>     EtherExpress/Pro100B and 100+ boards, several OEM boards, and a
>     custom board from Allied Telesyn.
>     The i82558 chip integrates a i82555 transceiver, adds flow control,
>     has improved firmware, and adds power
>     management/wake-up-packet control. Programming info:
>     Technical details are very difficult to obtain, and usually requires
>     signing a NDA with Intel. 
>     Driver: I've written a Linux device driver for the i82557 that
>     demonstrates one way to use the Speedo-3. 
>     Large packet support: Unknown. 
>     Multicast support: The Intel EtherExpress PCI Pro 100B has a
>     hardware multicast filter, but it illustrates characteristic Intel
>     quirkiness and difficulty of use. A set-multicast-list command is
>     queued on the Tx packet queue. The chip processes the list of
>     multicast addresses to accept, and fills in an internal hash table.
>     During the (presumably short) period that the set-multicast-list
>     command is being processed, no packets are received(!). 

Basically, it appears that Don Becker praised the Tulip chipset the most.  
How much important is "zero copy TX and hardware checksumming"?

Best regards,

Hugh

ghsong at kjist dot ac dot kr



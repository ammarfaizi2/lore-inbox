Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287572AbSALWCg>; Sat, 12 Jan 2002 17:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287574AbSALWC2>; Sat, 12 Jan 2002 17:02:28 -0500
Received: from svr3.applink.net ([206.50.88.3]:6668 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287572AbSALWCQ>;
	Sat, 12 Jan 2002 17:02:16 -0500
Message-Id: <200201122202.g0CM23Sr008372@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "Prof. Brand " <brand@jupiter.cs.uni-dortmund.de>,
        timothy.covell@ashavan.org
Subject: Re: strange kernel message when hacking the NIC driver
Date: Sat, 12 Jan 2002 15:58:13 -0600
X-Mailer: KMail [version 1.3.2]
Cc: "Pei Zheng" <zhengpei@msu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200201122137.g0CLbCR26740@jupiter.cs.uni-dortmund.de>
In-Reply-To: <200201122137.g0CLbCR26740@jupiter.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 January 2002 15:37, Prof. Brand  wrote:
> Timothy Covell <timothy.covell@ashavan.org> said:
> > On Thursday 10 January 2002 23:20, Timothy Covell wrote:
> >
> > Let me clarify what I said earlier.  You cannot have
> > identical MAC addresses on two different NICs.
>
> You sure can. Look at your nearest Sun machine with two NICs for an
> example.

And why don't you connect those two NICs with the same MACs to
the same HUB and see how well that works.


>
> >                                                Indeed,
> > it is impossible w/o trying to fool the kernel into
> > redefining the NICs hardware based MAC address.
>
> It is not "fooling", you can set the MAC address on some cards by software.
> Kernel has nothing to do with it.
>
> > As concerns TCP/IP, you can define two NICs to have the
> > same IP address, but you will only end up confusing
> > your switch/HUB router which assumes a 1 to 1 mapping
> > of MACs to IPs.   The whole point of ICMP is to
> > discover this mapping via ARP requests.
>
> TCP/IP is a 4(5) level protocol stack:
>
> 0 Hardware [Cribbed from ISO]
> 1 Device driver
> 2 IP [Includes ICMP]
> 3 TCP and UDP
> 4 Applications
>
> A switch/hub works on Ethernet frames, i.e., at the hardware level. It has
> absolutely no idea of mappings of MACs to IPs.
>
> ICMP is part of the IP layer, the whole of the mapping of IPs to MACs is
> (conceptually at least) part of the device driver layer. This includes ARP,
> DHCP et al. ICMP has nothing to do with ARP.


If you have two NICs with the identical MAC address on the same segment,
your ethernet routing will become confused.  The ARP table keeps a map
of MAC to IP address.   This table assumes a 1 to 1 relationship.   If you
try to reach a host but fail due to routing issues, then ICMP sends out 
DESTINATION HOST UNKNOWN/HOST UNREACHABLE messages.  
So, ICMP and very much to do with ARP.

The whole ISO Model is flawed because there really is not
a clean delineation among the layers.   For example, BGP uses TCP
to route IP, so it's an ISO layer 3 process, but it makes use of TCP
which is layer 4.  So, you need layer 4 to define layer 3.   Crazy huh.
The same argument can be shifted to the Internet Model, which is
IHMO, an after-the-fact idea that came from trying to apply ISO to
Internet.


-- 
timothy.covell@ashavan.org.

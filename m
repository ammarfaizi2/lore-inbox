Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270138AbRIAGpp>; Sat, 1 Sep 2001 02:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRIAGpg>; Sat, 1 Sep 2001 02:45:36 -0400
Received: from [213.22.99.48] ([213.22.99.48]:31880 "EHLO aeminium.aeminium.pt")
	by vger.kernel.org with ESMTP id <S270138AbRIAGpZ>;
	Sat, 1 Sep 2001 02:45:25 -0400
Date: Sat, 1 Sep 2001 07:45:34 +0100 (WEST)
From: Nuno Miguel Fernandes Sucena Almeida <slug@aeminium.org>
To: linux-kernel@vger.kernel.org
Subject: natsemi.c (linux 2.4.9) - Something Wicked happened! 18000
Message-ID: <Pine.LNX.4.21.0109010708370.19262-100000@aeminium.aeminium.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	i'm not subscribed in linux kernel, so please excuse the
following. I bought a PCI NIC with the national semiconductor
DP83815 chip. The system is a dual PIII running linux 2.4.9 and with only
1 processor (PIII are expensive:/). So, here's the problem. After
installing the driver module for this card and connecting with a
cross-cable to another card (tested with 10Mbps 3com509 and 100Mbps
IntelPro) after the first ping a get the error:

/usr/src/kernels/linux_2.4.9/drivers/net$ping 10.2.0.2
PING 10.2.0.2 (10.2.0.2): 56 data bytes
64 bytes from 10.2.0.2: icmp_seq=0 ttl=255 time=0.8 ms

--- 10.2.0.2 ping statistics ---
5 packets transmitted, 1 packets received, 80% packet loss

and at /var/log/kern.log (or dmesg of course)

kernel: eth2: Setting full-duplex based on negotiated link capability.
kernel: eth2: Something Wicked happened! 18000.

With tcpdump at the other computer i got all the echo send icmp packets
but the NS NIC didn't seem to receive the echo reply packets!

I searched the linux kernel mailing list and found a post with this same
error. Tried to override link negotiation with mii-diag but no luck.

They said that after an upgrade from 2.4.5 to 2.4.6 the error
started to appear. So, i grabbed the natsemi.c source code from 2.4.5,
compiled it and the system is now working fine, even with 100MbpsTx-FD,
giving 10MByte/s.

I saw a recent post from Tim Hockin (thockin@sun.com) with a patch for
this driver for 2.4.8 but after looking at it i saw that it also changed other
 files and not only natsemi.c so i decided not to apply it.

The question is: now i have the system working (i hope) but there seems to
be a patch available for a long time and its very frustrating to find out
that the kernel is not updated with it. I had a similar problem with the
IntelPro 100 NIC on a toshiba PC - had to grab the source from intel.com
but only after spending a lot of time searching the web and with NO
information of this at the driver source :/

--


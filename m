Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVJSP5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJSP5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJSP5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:57:41 -0400
Received: from xenotime.net ([66.160.160.81]:41641 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751129AbVJSP5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:57:40 -0400
Date: Wed, 19 Oct 2005 08:57:37 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3c900 boot-time kernel commandline parameters in 2.4.25
In-Reply-To: <20051019105239.GA9858@kestrel>
Message-ID: <Pine.LNX.4.58.0510190838550.23358@shark.he.net>
References: <20051019105239.GA9858@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005, Karel Kulhavy wrote:

> How do I tell Linux kernel 2.4.25 on boot-time kernel commandline to
> switch my eth0
> -----------------------------------------------------------------------
>   Bus  1, device   3, function  0:
>     Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang] (rev
> 0).
>       IRQ 11.
>       Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
>       I/O at 0xc000 [0xc03f].
> -----------------------------------------------------------------------
>
> to TP transceiver and 10/100 autonegotiation?
>
> I looked into Documentation/00-INDEX and into kernel-parameters.txt and
> found just
>
> "        ether=          [HW,NET] Ethernet cards parameters (irq,
>                         base_io_addr, mem_start, mem_end, name.
>                         (mem_start is often overloaded to mean something
>                         different and driver-specific).
> "
>
> which neither doesn't answer my question neither point to any
> documentation where my question could be answered.

Yes, there are lots of drivers where it is necessary to look
in the driver source file to determine actual parameter usage.

For the 3c59x driver, mem_start is overloaded (as in the doc above) as:


0x8000			debug level 7
0x4000			debug level 2
0x0400			enable WOL
0x0200			full duplex
0x0010			bus master
0x000m			media override value, index into media_table:

0: { "10baseT",   Media_10TP,0x08, XCVR_10base2, (14*HZ)/10},
1: { "10Mbs AUI", Media_SQE, 0x20, XCVR_Default, (1*HZ)/10},
2: { "undefined", 0,			0x80, XCVR_10baseT, 10000},
3: { "10base2",   0,			0x10, XCVR_AUI,	(1*HZ)/10},
4: { "100baseTX", Media_Lnk, 0x02, XCVR_100baseFx, (14*HZ)/10},
5: { "100baseFX", Media_Lnk, 0x04, XCVR_MII,	(14*HZ)/10},
6: { "MII",		 0,		0x41, XCVR_10baseT, 3*HZ },
7: { "undefined", 0,			0x01, XCVR_10baseT, 10000},
8: { "Autonegotiate", 0,		0x41, XCVR_10baseT, 3*HZ},
9: { "MII-External",	 0,		0x41, XCVR_10baseT, 3*HZ },
10: { "Default",	 0,		0xFF, XCVR_10baseT, 10000},

so don't use 2 or 7 for the media override value.
In your case, I guess you want mem_start=8.

-- 
~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQLUJ4p>; Thu, 21 Dec 2000 04:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbQLUJ4f>; Thu, 21 Dec 2000 04:56:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:20231 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129732AbQLUJ41>; Thu, 21 Dec 2000 04:56:27 -0500
Date: Thu, 21 Dec 2000 04:26:25 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: Julian Anastasov <ja@ssi.bg>,
        Robert Högberg <robho956@student.liu.se>,
        Andre Hedrick <andre@linux-ide.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Extreme IDE slowdown with 2.2.18
In-Reply-To: <200012210758.XAA07609@pobox.com>
Message-ID: <Pine.LNX.4.31.0012210416360.748-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Barry K. Nathan wrote:

>[snip]
>> message saying UDMA 3/4/5 is not supported.  It also claims the
>> MVP3 chipset is UDMA-33 only, whereas all relevant docs I can
>> muster including the mobo manual state the board is UDMA-66
>> capable.  Mental note to myself: Do not enable WORD93 invalidate.
>> ;o)
>
>I'm somewhat tired and busy, so I'll post URLs without quoting anything
>from them (look at the data in *all* of them, and connect the dots, before
>you come to any conclusions). Short version of the story: Some MVP3's
>support UDMA-66, some don't -- it depends on the southbridge. 596B & 686A
>do, others don't.
>
>http://www.via.com.tw/news/98mvp3nr.htm
>http://www.via.com.tw/products/prodmvp3.htm
>http://www.via.com.tw/support/faq.htm#ide

Thanks for the info!  Here is the most relevant portion I found:

      * Q: Which VIA Chipsets support UDMA 66?
        A: For UDMA 66 you must first make sure that you're southbridge is
        either VT82C596B or VT82C686A. You must also have a UDMA 66
        capable hard drive and be using an 80 pin cable which enables
        faster transmission of data. Windows 98 is UDMA 66 enabled, but if
        you have Win95 you should install our busmaster drivers.


Here is my mobo info:

2 root@asdf:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Flags: bus master, medium devsel, latency 16
        Memory at d8000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 23)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at e000
        Capabilities: [c0] Power Management version 2

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 30)
        Flags: medium devsel



Clear as mud.  Board docs say it does ATA66, so I am assuming it
is the VT82C596B model.  lspci doesn't appear to know which it is
though.  The numbers on the chip itself are:

VT82C596B
        ^

Thus indicating from all the info I've collected so far, that my
hardware setup according to docs, is ata66.

My drive is ATA100 capable so that is no problem.  80 conductor
cable...

12Mb/s on drive rated 37Mb/s sustained..  ;o(

Without Andre's fine IDE patches I get 5Mb/s...  12M/s is better
than 5.

Getting 1/2 of the hardware specs rated values would even be
nice...  I think it is shoddy hardware with made up specs
myself..  makes a good sell to people...  ;o)


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

If you're interested in computer security, and want to stay on top of the
latest security exploits, and other information, visit:

http://www.securityfocus.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

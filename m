Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132467AbQLHXIB>; Fri, 8 Dec 2000 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132658AbQLHXHu>; Fri, 8 Dec 2000 18:07:50 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:51973 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132467AbQLHXHp>; Fri, 8 Dec 2000 18:07:45 -0500
Message-ID: <3A3162A0.825FA107@Hell.WH8.TU-Dresden.De>
Date: Fri, 08 Dec 2000 23:37:20 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0012081254360.26353-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> Ok. Can you send me the entire dump? Also, it would be helpful if you
> could try to determine when exactly it happens (upon insmod, upon ifconfig
> up, or upon receiving some packets later).

I have the eepro driver compiled into a monolithic kernel. After rebooting
a couple dozen times trying to find a pattern I can't see one, except for
one fact worth noticing.

As long as the network cable is pulled, everything's groovy. Kernel boots
nicely without triggering it, ifconfig doesn't trigger it, route doesn't
trigger it, but putting the cable in, immediately triggers it upon packet
traffic.

* put cable in *

eth0: card reports no RX buffers.
eth0: card reports no resources.
eth0: card reports no RX buffers.
eth0: card reports no resources.

:> ifconfig eth0 down

eth0: 0 multicast blocks dropped.

Is it worth analyzing packet traffic and comparing with the timestamps in
syslog to see what kind of packet triggers it, or whether any packet
triggers it?

> Stupid question: are you sure this is not due to the DNS server being
> unreachable?...

Maybe due to the issues with the NIC. All interesting hosts are now
in /etc/hosts, so we'll see.


Other stuff that might be of interest:

PCI Info:

  Bus  0, device  13, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd4800fff].
      I/O at 0x9800 [0x983f].
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd40fffff].               

Card shares IRQ 9 with 2 other devices:

    irq  9:       620 acpi, bttv, eth0

Need any other info?

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

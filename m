Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSL3H7s>; Mon, 30 Dec 2002 02:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSL3H7r>; Mon, 30 Dec 2002 02:59:47 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:60133 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S266761AbSL3H7q>;
	Mon, 30 Dec 2002 02:59:46 -0500
To: Joshua Kwan <joshk@mspencer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA and hermer/orinoco_cs drivers b0rken?
References: <87u1h3fim2.fsf@lapper.ihatent.com>
	<20021226003405.014f0638.joshk@mspencer.net>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 30 Dec 2002 05:17:26 +0100
In-Reply-To: <20021226003405.014f0638.joshk@mspencer.net>
Message-ID: <87u1gwuomh.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <joshk@mspencer.net> writes:

> Hi,
> 
> Are you using the modules from the kernel source or from pcmcia-cs? Are
> you using yenta_socket or pcmcia-cs? pcmcia-cs has given me a lot more
> positive results than trying to use yenta_socket and the built in kernel
> modules. Also, try binding your card IDs to use wavelan_cs instead and
> see if it works (maybe those cards are a bit older and as such need
> older drivers.)
> 

Avoiding the kernel-side PCMCIA-stuff and using the standalone package
got me a lot further. After a few tweaks int he config files I get the
interface up and things startes to happen:

lapper root # ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:09:5B:27:DC:F9  
          inet addr:172.31.255.242  Bcast:172.31.255.247  Mask:255.255.255.248
          inet6 addr: fe80::209:5bff:fe27:dcf9/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:8 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:516 (516.0 b)
          Interrupt:11 Base address:0x100 

lapper root # iwconfig eth1
Warning: Driver for device eth1 has been compiled with version 14
of Wireless Extension, while this program is using version 13.
Some things may be broken...

eth1      IEEE 802.11-DS  ESSID:"humbug"  Nickname:"lapper.ihatent.com"
          Mode:Ad-Hoc  Frequency:2.417GHz  Cell: 02:09:A7:FB:DC:F9  
          Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3  
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:6875-6262-61   Encryption mode:open
          Power Management:off
          Link Quality:0  Signal level:0  Noise level:0
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

Seems I need to get the wireless tools rebuilt and I'll be in touch
with a WLAN in a few hours, but this all seems swell now.

After inserting the card (NetGear MA401) I get this in my log tho:

eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.03
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:09:5B:27:DC:F9
eth1: Station name "Prism  I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 11, io 0x0100-0x013f
eth1: Error -110 setting multicast list.
eth1: Error -110 setting multicast list.
eth1: Error -110 setting multicast list.
eth1: Error -110 setting multicast list.
eth1: Error -110 setting multicast list.
eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
eth1: Error -110 writing packet to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.

If you have an idea about the errors, drop me a line, and if not I'll
dig into it :)

mvh,
A

> Hope this helps you.
> Regards
> 
> -Josh
> 

Sure did :)

-A

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131994AbRBOBKU>; Wed, 14 Feb 2001 20:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132007AbRBOBKB>; Wed, 14 Feb 2001 20:10:01 -0500
Received: from imcs.rutgers.edu ([165.230.57.130]:57021 "EHLO imcs.Rutgers.EDU")
	by vger.kernel.org with ESMTP id <S131994AbRBOBJ5>;
	Wed, 14 Feb 2001 20:09:57 -0500
Date: Wed, 14 Feb 2001 19:59:19 -0500 (EST)
From: Rob Cermak <cermak@IMCS.rutgers.edu>
To: linux-kernel@vger.kernel.org
cc: jonathan_brugge@hotmail.com
Subject: More (other) NIC info/Problem: NIC doesn't work anymore, SIOCIFADDR-errors
Message-ID: <Pine.SOL.4.21.0102141940470.3550-100000@imcs.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathon,

You and I might have the same problem.  I have 2 3COM cards (ISA/PCI) and
1 Tulip card in a single PC and I loose functionality in one 3COM card
using the 2.4.XXXX series; IRQ and IOBASE is wrong.  Using stock Redhat
built kernels, they operate fine.

Feb 7 21:42:50 anole kernel: Linux version 2.2.16-22
(root@porky.devel.redhat.com)  (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Tue Aug 22 16:49:06 EDT 2000 
Feb 7 21:43:03 anole kernel: tulip.c:v0.91g-ppc 7/16/99
becker@cesdis.gsfc.nasa.gov
Feb 7 21:43:03 anole kernel: eth0: Digital DC21041 Tulip rev 17 at 0xfc00,
00:00:C0:5C:45:01, IRQ 10.
Feb 7 21:43:03 anole kernel: eth0: 21041 Media table, default media 0800
(Autosense ).
Feb 7 21:43:03 anole kernel: eth1: 3c509 at 0x340 tag 1, 10baseT port,
address 00 10 5a 1c e5 fe, IRQ 7.
Feb 7 21:43:03 anole kernel: 3c509.c:1.16 (2.2) 2/3/98
becker@cesdis.gsfc.nasa.gov.
Feb 7 21:43:03 anole kernel: eth2: 3c509 at 0x320 tag 2, AUI port, address
00 20 a f 0a 62 0d, IRQ 5.
Feb 7 21:43:03 anole kernel: 3c509.c:1.16 (2.2) 2/3/98
becker@cesdis.gsfc.nasa.gov.

2.4.1-ac11 results (with isapnp stuff!):
Feb 13 19:58:58 anole kernel: Linux version 2.4.1-ac11
(root@anole.sjrcd.org) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #1
Tue Feb 13 19:29:28 EST 2001
Feb 13 19:58:59 anole kernel: isapnp: Scanning for Pnp cards...
Feb 13 19:58:59 anole kernel: isapnp: Card '3Com 3C509B EtherLink III'
Feb 13 19:58:59 anole kernel: isapnp: 1 Plug & Play card detected total
  * my guess is this biloxes up resource somewhere...
Feb 13 20:08:52 anole kernel: eth1: 3c509 at 0x340 tag 1, 10baseT port,
address 00 10 5a 1c e5 fe, IRQ 7.
Feb 13 20:08:52 anole kernel: 3c509.c:1.16 (2.2) 2/3/98
becker@cesdis.gsfc.nasa.gov.
Feb 13 20:08:52 anole kernel: eth2: 3c509 at 0x320 tag 2, AUI port,
address 00 20 a f 0a 62 0d, IRQ 5.
Feb 13 20:08:52 anole kernel: 3c509.c:1.16 (2.2) 2/3/98
becker@cesdis.gsfc.nasa.gov.

I'm building 2.2.19pre11 to see if things are still working out.
I think I narrowed it down to the ISAPNP code entering the network
drivers...I need to do more testing...

Rob Cermak
--

Subject : dual 3c509 cards break from 2.2.17-14 (Redhat versions) to 2.4.x 
          through 2.4.1-ac11
----- Message Text -----
Stock Redhat 7.x 2.2.16 and 2.2.17 kernels are able to correctly
detect 3c509 cards with this result:

Feb 13 20:14:44 anole kernel: eth1: 3c509 at 0x340 tag 1, 10baseT port,
address 00 10 5a 1c e5 fe, IRQ 7.
Feb 13 20:14:44 anole kernel: eth2: 3c509 at 0x320 tag 2, AUI port,
address  00 20 af 0a 62 0d, IRQ 5.

The printer port on the PC (x86) has been disabled through the BIOS.  The
above kernels operate as expected and I can ping and do normal network
traffic.

Any 2.4.x kernel causes both cards to appear on IRQ 5 and renders one of
the cards useless.

Stock unpatched 2.4.0:

Feb  7 19:25:16 anole kernel: eth1: 3c509 at 0x220, 10baseT port, address
00 10 5a 1c e5 fe, IRQ 5.
Feb  7 19:25:16 anole kernel: eth2: 3c509 at 0x320, AUI port, address  00
20 af 0a 62 0d, IRQ 5.

Same result with the recent patched 2.4.1 with ac11.   I'll
continue checking other patched versions of the kernel and try
and locate where things might have went awry and post a message; if
someone else doesn't find it first.

>From what I gather, it might have something do ISAPNP stuff.
Rob

---------- Forwarded message ----------
Date: Wed, 14 Feb 2001 12:00:16 +0100
From: Jonathan Brugge <jonathan_brugge@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem: NIC doesn't work anymore, SIOCIFADDR-errors

I've got a problem with my network. I can't get the card running, though it 
worked perfectly before. Below what happens and the errors I get:
-----------------------------------
odysseus:/# ifconfig

// No active devices found.

odysseus:/# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:20:18:80:B0:95
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:9 Base address:0xde00
lo        Link encap:Local Loopback
          LOOPBACK  MTU:16192  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

// It finds eth0 and the loopback, they aren't active.

odysseus:/# ifdown eth0
ifdown: interface eth0 not configured

// Just what should happen...

odysseus:/# ifup eth0
SIOCSIFADDR: Bad file descriptor
eth0: unknown interface: Bad file descriptor
SIOCSIFNETMASK: Bad file descriptor
eth0: unknown interface: Bad file descriptor
odysseus:/# ifup lo
SIOCSIFADDR: Bad file descriptor
lo: unknown interface: Bad file descriptor
lo: unknown interface: Bad file descriptor
odysseus:/#

// This is where I loose the track. These seem to be kernel-messages, but I 
can't find them in the kernel-source (looked in the kernel-subdirectory and 
the net-subdirectory).
There are some other SIOC*-texts, but no SIOCSIFADDR or SIOCIFNETMASK in 
those dirs.
The problem appeared after booting, everything worked perfect before.
Nothing has changed that could affect network or ethernet-card, afaik.
It's not hardware-related: the card still works in Win98SE and after placing 
another card (same type), the problem still persists.
I did a kernel-recompile, but that hasn't solved it. Still the same error.
I'm running 2.4.0-prerelease.
The card is a PCI-card. It has a Winbond W89C940F-chip on it and the kernel 
uses NE2k-drivers, I think.
I did a fsck on my HD, which didn't solve it either.
The light on the card blinks all the time, like there's something wrong. I 
haven't looked whether it does so in Windows too.
Ifup / Ifdown version: 0.6.4-3
No messages in /var/log[syslog|messages|kern.log|ksymoops/*] about this.

Anyone who can tell me what's going on here?

Jonathan Brugge
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



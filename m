Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131793AbRBEAGK>; Sun, 4 Feb 2001 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRBEAGA>; Sun, 4 Feb 2001 19:06:00 -0500
Received: from cloudburst.umist.ac.uk ([130.88.119.66]:6670 "EHLO
	cloudburst.umist.ac.uk") by vger.kernel.org with ESMTP
	id <S131793AbRBEAFs>; Sun, 4 Feb 2001 19:05:48 -0500
From: "Thomas Stewart" <T.Stewart@student.umist.ac.uk>
To: Urban Widmark <urban@teststation.com>
Date: Mon, 5 Feb 2001 00:07:14 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: d-link dfe-530 tx (bug-report)
CC: Jonathan Morton <chromi@cyberspace.org>,
        Manfred <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        ksa1 <ksa1@gmx.de>
Message-ID: <3A7DEEB2.20915.276D09D@localhost>
In-Reply-To: <3A7D77B5.ABF5A850@colorfullife.com>
In-Reply-To: <Pine.LNX.4.30.0102042130100.26061-300000@cola.teststation.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Feb 2001, at 23:31, Urban Widmark wrote:

> On Sun, 4 Feb 2001, Manfred wrote:
> 
> > Ok, I've attached a patch that performs an unconditional reset in
> > tx_timeout().
> > 
> > I don't have the hardware, could you test it?
> 
> The changed startup code doesn't break anything for me.
> 
> > I also found newer via documentation on via's ftp site:
> > ftp.via.com.tw/public/lan/Products/NIC/VT86C100A, from Sept 98
> 
> You've done even better than that:
> ftp.via.com.tw/public/lan/Products/NIC/VT6102
> :)
> 
> 
> For those of you with vt6102s that don't like being rebooted from
> win98 I have modified Manfred's patch to try and really reset the card
> at startup.
> 
> CmdReset is not instant, it may need a delay. There is also a "force
> software reset" operation that sounds good, I assume that one also
> could use a delay so I gave it 6ms.
> 
> This will probably not fix things, but it would be nice if you could
> test it as well as Manfred's variant. (I know it's painful to reboot
> into win98 all the time :)
> 
> You shouldn't have to reboot between testing each of the patches
> (assumes via-rhine.o as a module). Just make sure the module is
> unloaded and reloaded. So a single win98 trip would allow testing both
> of them.
> 
> The via-diag.c program has a bug when looking at vt6102's. They have
> 256 bytes of registers, not just 128. The attached patch fixes this
> (no need to use the -Ii switches). Checking the output again when the
> card is working and not working could give some clue. There are some
> power save states in the higher registers that look suspicious.
> 
> 0x96 contains "PHY address at suspend well"
> 0x94-0x95 contains "MII address at suspend well"
> (at suspend well == in power save mode?)
> 
> Finally, MII PHYs can be reset by setting bit15 in MII register 0.
> During the search for the PHY it could try resetting each address.
> 
> /Urban
> 

Right, i patched the via-diag and its showing more regs.

I applyed Manfred's patch but that changed nothing.
Then I applyed your patch and still changed nothing as you suspected.
But there are regs that are different.

Not working:-
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:00:00:00:00:00.
 Tx disabled, Rx disabled, half-duplex (0x0004).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x21: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 00000000 216c0000 00000004 00000000 00000000 00000000 
07c62000 07c62120
 0x020: 00000400 00000600 07c61010 07c62010 00000000 00000600 
07c61810 07c62020
 0x040: c0000000 00e0824e 07c80402 07c62120 00000000 00000000 
00000000 feffffff
 0x060: 00000000 00000000 00000000 0006131f 00008100 08000080 
02470000 00000000
 0x080: 03012000 00000000 00000000 00000000 06000080 00000000 
00000000 00000000
 0x0A0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
 0x0C0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
 0x0E0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73
 ***WARNING***: No MII transceivers found!

Working:-
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:50:ba:6e:d8:55.
 Tx disabled, Rx disabled, half-duplex (0x0004).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x21: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 6eba5000 216c55d8 00000004 00000000 80000000 00000000 
07c620e0 07c62180
 0x020: 00000400 00000600 07c85010 07c620f0 00000000 00000600 
07c85810 07c62000
 0x040: 00000000 00e08000 00000000 07c62190 00000000 00000000 
00000000 fefffffd
 0x060: 00000000 00000000 00000000 00061108 ffff9f00 08000080 
02470000 00000000
 0x080: 00012000 00000000 00000000 00000000 06000080 00080000 
00000000 00000000
 0x0A0: 01010000 01010000 00000000 00000000 ffffffff ffffffff 
ffffffff ffffffff
 0x0C0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
 0x0E0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 50 ba 6e d8 55 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73
 MII PHY found at address 8, status 0x782d.
 MII PHY #8 transceiver registers:
   3000 782d 0016 f880 01e1 4461 ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0022 ff40 0050 ffc0 00a0 ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff.


regards
tom

---------------------------------------------------------
 This message is ROT-13 encoded twice for extra security
 Thomas Stewart - t.stewart@student.umist.ac.uk
 This should contain no attachments
---------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

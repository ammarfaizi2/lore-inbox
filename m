Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRBCRNO>; Sat, 3 Feb 2001 12:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130244AbRBCRNE>; Sat, 3 Feb 2001 12:13:04 -0500
Received: from cloudburst.umist.ac.uk ([130.88.119.66]:26130 "EHLO
	cloudburst.umist.ac.uk") by vger.kernel.org with ESMTP
	id <S130241AbRBCRM7>; Sat, 3 Feb 2001 12:12:59 -0500
From: T.Stewart@student.umist.ac.uk
To: Urban Widmark <urban@teststation.com>
Date: Sat, 3 Feb 2001 17:14:22 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: DFE-530TX with no mac address
CC: linux-kernel@vger.kernel.org
Message-ID: <3A7C3C6E.7296.82EE32@localhost>
In-Reply-To: <3A7B599F.18307.47A4F1@localhost>
In-Reply-To: <Pine.LNX.4.30.0102031246490.13570-200000@cola.teststation.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Feb 2001, at 14:02, Urban Widmark wrote:

> This is intresting. Your card reports that it is stopped while the
> other report show normal values on most things. Does this change if
> you try and send something (like a ping)? Common to both reports is
> that the transceivers don't respond.
> 
> The functioning card reports a PHY ID of 0016 f880, wonder which chip
> that is ... ?
> 
> 
> The attached patch for the via-daig program plays with a few
> registers.
> 
> Run it as 'via-diag -aaeemm -I' then do a 'ifconfig eth0 down;
> ifconfig eth0 up' and see if anything happens.
> 
> If this doesn't work you may want to play "guess the register". A fun
> game for all ages, made more fun by using obfuscated english. There is
> a datasheet here for a chip similar to the ones you have.
>  http://www.via.com.tw/pdf/productinfo/vt86c100a.pdf
Ye, sounds like a fun game ;-)

See bottom for via-diag outputs.

It looks as thought your I switchs do not fix the prob. There is still 
no Station address (00:00:00:00:00:00). The next thing I did was 
look at the working output again:-

VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 6eba5000 206c55d8 00000c5a 4eff0000 80000000 
00000000 01264010 01264190
 0x020: 80000400 00000600 079ae810 01264020 80000000 
00000600 079ad010 01264030
 0x040: 00000000 00e08000 00000000 012641a0 00000000 
00000000 013c013c feffffff
 0x060: 00000000 00000000 00000000 00061108 782d8100 
08000080 02470000 00000000
<SNIP>
EEPROM contents (Assumed from chip registers):
0x100:  00 50 ba 6e d8 55 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73

I noticed that the mac address was stored in the registers and 
eprom. I guess it would not be as easy as just writing the mac 
back in the blank eprom and registers?

Is there a reset 'thing' for thses chips, that sets them back to 
factory tests (like switching them off)?

So.....How do I go about playing this game?

tom

freshboot of linux, no eth0 confg done, via-diag -aaeemm
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:00:00:00:00:00.
 Tx disabled, Rx disabled, half-duplex (0x0004).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x21: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 00000000 216c0000 00000004 00000000 00000000 
00000000 01264000 01264120
 0x020: 00000400 00000600 01362010 01264010 00000000 
00000600 01362810 01264020
 0x040: c0000000 00e0824e 07c49402 01264120 00000000 
00000000 00000000 feffffff
 0x060: 00000000 00000000 00000000 0006131f 00008100 
08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73
 ***WARNING***: No MII transceivers found!

ifconfig eth0 up, via-diag -aaeemm -I
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:00:00:00:00:00.
 Tx enabled, Rx enabled, half-duplex (0x081a).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x20: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 00000000 206c0000 0000081a 4eff0000 00000000 
00000000 01264000 01264100
 0x020: 00000400 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
 0x040: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 feffffff
 0x060: 00000000 00000000 00000000 0e091308 00008100 
08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 09 0e 00 00 47 02 73 73
 ***WARNING***: No MII transceivers found!

ifconifig eth0 down, ifconfig eth0 up, via-diag -aaeemm
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:00:00:00:00:00.
 Tx enabled, Rx enabled, half-duplex (0x081a).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x20: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 00000000 206c0000 0000081a 4eff0000 00000000 
00000000 01264000 01264100
 0x020: 00000400 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
 0x040: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 feffffff
 0x060: 00000000 00000000 00000000 00061301 00008100 
08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73
 ***WARNING***: No MII transceivers found!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

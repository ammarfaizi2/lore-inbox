Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263347AbREXCZq>; Wed, 23 May 2001 22:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263348AbREXCZg>; Wed, 23 May 2001 22:25:36 -0400
Received: from kullstam.ne.mediaone.net ([66.30.138.210]:2432 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S263347AbREXCZX>; Wed, 23 May 2001 22:25:23 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: tulip driver BROKEN in 2.4.5-pre4
In-Reply-To: <3B08E5F1.BD33D6F7@stud.uni-saarland.de>
Organization: none
Date: 23 May 2001 22:24:38 -0400
In-Reply-To: <3B08E5F1.BD33D6F7@stud.uni-saarland.de>
Message-ID: <m2eltfmql5.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Studierende der Universitaet des Saarlandes  <masp0008@stud.uni-sb.de> writes:

> Could you post the output of
> 
> #tulip-diag -mm -aa -f
> 
> with the broken driver?
> Some code that's required for Linksys Tulip clones was moved from pnic
> specific part into the generic part, perhaps that causes problems.

i have a 21041 dec tulip which has failed to work with
linux-2.4.5-pre[3-5] kernel drivers.  (it also fails with the
sourceforge devel version tulip-1.1.7)

it appears that the card gets lodged in full duplex mode.  however,
this could just be a superficial syndrome.

anyhow, here is the output of tulip-diag -mm -aa -f from the *broken*
driver

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21140 Tulip adapter at 0xfc00.
Digital DS21140 Tulip chip registers at 0xfc00:
 0x00: fff88000 ffffffff ffffffff 03421000 03421200 fc000102 e3840000 fffe0000
 0x40: fffe0000 ffffdff0 ffffffff fffe0000 ffffff59 ffffffff 1c09fdc0 fffffec8
 Port selection is 100mbps-SYM/PCS 100baseTx scrambler, half-duplex.
 Transmit stopped, Receive stopped, half-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit threshold is 128.
   No MII transceivers found!
Index #2: Found a Digital DC21041 Tulip adapter at 0xf080.
Digital DC21041 Tulip chip registers at 0xf080:
 0x00: ffe08000 ffffffff ffffffff 0ee4e000 0ee4e200 fc000112 fffe0200 fffe0000
 0x40: fffe0000 ffff4bf8 ffffffff fffe0000 000050c8 ffffef01 ffffffff ffff0008
 Port selection is full-duplex.
 Transmit stopped, Receive stopped, full-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000050c8.
   No MII transceivers found!
  Internal autonegotiation state is 'Negotiation complete'.



and here is one working dump for comparison (driver 0.9.14 from
sourceforge)

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21140 Tulip adapter at 0xfc00.
Digital DS21140 Tulip chip registers at 0xfc00:
 0x00: fff88000 ffffffff ffffffff 03421000 03421200 fc000102 e3840000 fffe0000
 0x40: fffe0000 fff597ff ffffffff fffe0000 ffffff59 ffffffff 1c09fdc0 fffffec8
 Port selection is 100mbps-SYM/PCS 100baseTx scrambler, half-duplex.
 Transmit stopped, Receive stopped, half-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit threshold is 128.
   No MII transceivers found!
Index #2: Found a Digital DC21041 Tulip adapter at 0xf080.
Digital DC21041 Tulip chip registers at 0xf080:
 0x00: ffe08000 ffffffff ffffffff 0ee4e000 0ee4e200 fc660000 fffe2002 ffffebef
 0x40: fffe0000 ffff03ff ffffffff fffe0000 000001c8 ffffef05 ffffff3f ffff0008
 Port selection is half-duplex.
 Transmit started, Receive started, half-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000001c8.
   No MII transceivers found!
  Internal autonegotiation state is 'Autonegotiation disabled'.


-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130592AbQLITb6>; Sat, 9 Dec 2000 14:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130756AbQLITbt>; Sat, 9 Dec 2000 14:31:49 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:19721 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S130592AbQLITbo>; Sat, 9 Dec 2000 14:31:44 -0500
Date: Sat, 9 Dec 2000 19:00:59 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4test12pre7 pcmcia bug?
Message-ID: <Pine.LNX.4.10.10012091839390.31421-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The aforementioned kernel seems to have a minor bug on
(at least) my laptop -- it looks like a potential off-
by-one in the socket handling:

After a clean bootup:
# cardctl status 0
  no card
# cardctl status 1
  no card

Insert a card in socket 0
# cardctl status 0
  no card
# cardctl status 1
  5V 16-bit PC Card
  function 0: [ready]

Eject card:
# cardctl status 0
  no card
# cardctl status 1
  no card

Insert card in socket 1:
# cardctl status 0
  5V 16-bit PC Card
  function 0: [ready]
# cardctl status 1
  no card

With both cards:
# cardctl status 0
  5V 16-bit PC Card
  function 0: [ready]
# cardctl status 1
  5V 16-bit PC Card
  function 0: [ready]


I once managed to make it assign a socket 0 card to both sockets
and completely ignore socket 1, but can't reproduce this now.

Matthew.


# lspci 
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:02.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
00:02.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
00:04.0 VGA compatible controller: Trident Microsystems Cyber 9525 (rev 49)
00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
00:0a.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291687AbSBNOiw>; Thu, 14 Feb 2002 09:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291689AbSBNOin>; Thu, 14 Feb 2002 09:38:43 -0500
Received: from tsi.enst.fr ([137.194.130.2]:32183 "EHLO raven.enst.fr")
	by vger.kernel.org with ESMTP id <S291687AbSBNOi1>;
	Thu, 14 Feb 2002 09:38:27 -0500
From: Jean-Francois Cardoso <cardoso@tsi.enst.fr>
Message-ID: <15467.52241.51293.271578@jude.enst.fr>
Date: Thu, 14 Feb 2002 15:39:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc1: Tulip driver fails to initialize 21140 card
X-Mailer: VM 6.99 under Emacs 20.7.1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The tulip driver in 2.4.18-rc1 does not behave with my 21140 card:

1) At boot time, the tulip.o module is loaded OK but ifconfig only 
   shows errors for both RX and TX --> no network.


2) The card can be made to work by briefly unplugging/replugging the
   ethernet wire into the hub.  After that, networking works, even
   though the log says eth0 uses half-duplex which does not sound good 
   to me (who is an ignorant).


3) The old_tulip driver in vmlinuz-2.2.19-6.3mdk work well with this
   card.


I provide various outputs below.  Let me know if any other bits are needed.

Cheers, JF.

(PS: Jeff has been CC'ed in another message)


========================================================================

vmlinuz-2.2.19-6.3mdk messages 
-------------------------------------------------------------------
	tulip.c:v0.89H 5/23/98 becker@cesdis.gsfc.nasa.gov
	eth0: Digital DS21140 Tulip at 0x1000, 00 c0 fd 02 11 6f, IRQ 10.
	eth0:  EEPROM default media type Autosense.
	eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
	eth0:  MII transceiver found at MDIO address 1, config 3000 status 782d.


2.4.18-rc1 messages
-----------------------------------------------------
	Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
	PCI: Found IRQ 10 for device 00:0d.0
	tulip0:  EEPROM default media type Autosense.
	tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
	tulip0:  MII transceiver #1 config 3000 status 782d advertising 05e1.
	eth0: Digital DS21140 Tulip rev 34 at 0x1000, 00:C0:FD:02:11:6F, IRQ 10.

    On bringing up the interface:
        eth0: Setting half-duplex based on MII#1 link partner capability of 0000.


lspci output
------------

   Verbose for the NIC:

	00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Flags: bus master, medium devsel, latency 165, IRQ 10
	I/O ports at 1000 [size=128]
	Memory at f4000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]
   
   Terse for the rest:

	00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
	00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
	00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
	00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
	00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 21)




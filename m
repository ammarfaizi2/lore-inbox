Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUKWN3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUKWN3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUKWN3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:29:08 -0500
Received: from lucidpixels.com ([66.45.37.187]:55451 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261236AbUKWN2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:28:24 -0500
Date: Tue, 23 Nov 2004 08:28:21 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 Multiple Drivers For Multi-Port Nic Question
Message-ID: <Pine.LNX.4.61.0411230822170.3740@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it matter what driver I use for a tulip-based board?
It is tulip based, but two drivers seem to work for it.

Below is tulip.o:

Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0: ***WARNING***: No MII transceiver found!
eth1: Digital DS21140 Tulip rev 34 at 0xd4858c00, 00:00:D1:20:35:50, IRQ 11.
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip1: ***WARNING***: No MII transceiver found!
eth2: Digital DS21140 Tulip rev 34 at 0xd485a800, EEPROM not present, 
00:00:D1:20:35:51, IRQ 11.
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip2:  Controller 2 of multiport board.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip2: ***WARNING***: No MII transceiver found!
eth3: Digital DS21140 Tulip rev 34 at 0xd485c400, EEPROM not present, 
00:00:D1:20:35:52, IRQ 11.
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
tulip3:  Controller 3 of multiport board.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip3: ***WARNING***: No MII transceiver found!
eth4: Digital DS21140 Tulip rev 34 at 0xd485e000, EEPROM not present, 
00:00:D1:20:35:53, IRQ 11.
eth0: no IPv6 routers present
eth1: no IPv6 routers present
eth4: Setting full-duplex based on MII#1 link partner capability of 45e1.

Using de4x5.o:

ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:02:05.0: DC21140 at 0xdc00, h/w address 00:00:d1:20:35:51,
eth%d: Using generic MII device control. If the board doesn't operate,
please mail the following dump to the author:

MII device address: 21
MII CR:  0
MII SR:  ffff
MII ID0: 0
MII ID1: ffff
MII ANA: 0
MII ANC: ffff
MII 16:  0
MII 17:  ffff
MII 18:  0

       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:02:06.0: DC21140 at 0xd880, h/w address 00:00:d1:20:35:51,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
0000:02:07.0: DC21140 at 0xd800, h/w address 00:00:d1:20:35:51,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
eth4: media is 100Mb/s full duplex.

If I load the mii driver first, then load the tulip driver, I get:

Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip0:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth1: Digital DS21140 Tulip rev 34 at 0xd485ec00, 00:00:D1:20:35:50, IRQ 
11.
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip1:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth2: Digital DS21140 Tulip rev 34 at 0xd4860800, EEPROM not present, 
00:00:D1:20:35:51, IRQ 11.
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip2:  Controller 2 of multiport board.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip2:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth3: Digital DS21140 Tulip rev 34 at 0xd4862400, EEPROM not present, 
00:00:D1:20:35:52, IRQ 11.
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
tulip3:  Controller 3 of multiport board.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip3:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip3:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth4: Digital DS21140 Tulip rev 34 at 0xd4864000, EEPROM not present, 
00:00:D1:20:35:53, IRQ 11.

When I load the de4x5 driver with mii loaded, I get:

ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:02:04.0: DC21140 at 0xdc80, h/w address 00:00:d1:20:35:50,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:02:05.0: DC21140 at 0xdc00, h/w address 00:00:d1:20:35:51,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:02:06.0: DC21140 at 0xd880, h/w address 00:00:d1:20:35:51,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
0000:02:07.0: DC21140 at 0xd800, h/w address 00:00:d1:20:35:51,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com

I am not sure if anyone will read this far, but if they do question, which 
driver do I use in this situation?

What are the benefits of one over the other?


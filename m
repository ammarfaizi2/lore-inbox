Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUIBQer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUIBQer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUIBQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:34:47 -0400
Received: from [212.227.36.84] ([212.227.36.84]:11187 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268186AbUIBQem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:34:42 -0400
Message-ID: <41374B9F.6000404@convergence.de>
Date: Thu, 02 Sep 2004 18:34:39 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: Dual-Ethernet DECchip 21142/43 doesn't like cold boots 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual-ethernet DECchip 21142/43 based card in my system. The 
problem is, that the device doesn't work after a cold boot.

After I have powered up my system, the syslog shows the following 
message and the device doesn't work.

-----------------------------schnipp------------------------------------
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0: ***WARNING***: No MII transceiver found!
eth0: Digital DS21143 Tulip rev 33 at 0xe280ff80, 00:00:D1:1B:EF:2E, IRQ 11.
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1: ***WARNING***: No MII transceiver found!
eth1: Digital DS21143 Tulip rev 33 at 0xe2811f00, EEPROM not present, 
00:00:D1:1B:EF:2F, IRQ 11.
-----------------------------schnipp------------------------------------

A simple shutdown and warm boot gives the desired result:

-----------------------------schnipp------------------------------------
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth0: Digital DS21143 Tulip rev 33 at 0xe280ff80, 00:00:D1:1B:EF:2E, IRQ 11.
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 33 at 0xe2811f00, EEPROM not present, 
00:00:D1:1B:EF:2F, IRQ 11.
-----------------------------schnipp------------------------------------

Any other warm reboots works as well.

"lspci -v" says the following about this card:

-----------------------------schnipp------------------------------------
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 21)
Subsystem: Cogent Data Technologies, Inc. ANA-6922/TX Fast Ethernet
Flags: bus master, medium devsel, latency 64, IRQ 11
I/O ports at bc00 [size=128]
Memory at cfefff80 (32-bit, non-prefetchable) [size=128]
Expansion ROM at cfe80000 [disabled] [size=256K]

02:08.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 21)
Flags: bus master, medium devsel, latency 64, IRQ 11
I/O ports at b800 [size=128]
Memory at cfefff00 (32-bit, non-prefetchable) [size=128]
Expansion ROM at cfe40000 [disabled] [size=256K]
-----------------------------schnipp------------------------------------

The same problem exists with 2.4.26 w/o ACPI. As you can imagine it's 
quite annoying to restart the system once everytime after a cold startup.

Is anyone interested in this bug report? All comments or hints 
appreciated, because I haven't worked with the Linux network code up to 
now. 8-)

CU
Michael.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264881AbSJVVjy>; Tue, 22 Oct 2002 17:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264906AbSJVVjy>; Tue, 22 Oct 2002 17:39:54 -0400
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:7768 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264881AbSJVVjw>; Tue, 22 Oct 2002 17:39:52 -0400
Date: Tue, 22 Oct 2002 17:45:55 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: CS4236B stopping working as of 2.5.44
Message-ID: <Pine.LNX.4.43.0210221733150.3106-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.43, my CS4236B soundcard worked. As of 2.5.44, it no longer
functions. I believe it might be the PnP changes.

2.5.43:
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: Card 'U.S.Robotics Inc. Sportster 33.6 FAX Internal'
isapnp: 2 Plug & Play cards detected total
<snip>
<Crystal audio controller (CS4236B)> at 0x534 irq 5 dma 1,3
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones...

And the card works.


With 2.5.44:
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
pnp: pnp: match found with the PnP device '00:00' and the driver 'system'
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: Card 'U.S.Robotics Inc. Sportster 33.6 FAX Internal'
isapnp: 2 Plug & Play cards detected total
<snip>
cs4232: Must set io, irq and dma.
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: CS4236B detected
pnp: the device '01:01.00' has been activated
ad1848: ISAPnP reports 'CS4236B' at i/o 0x534, irq 5, dma 1, 3

2.5.44:
razor:~# echo "foo" > /dev/dsp
bash: /dev/dsp: No such device


2.5.44 config:
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_DEBUG=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_SOUND=y
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_CS4232=y

razor:~# lspci
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X (rev 5c)
02:0a.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
02:0b.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)



--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461





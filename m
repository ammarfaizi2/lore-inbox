Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424194AbWLBV4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424194AbWLBV4i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424205AbWLBV4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:56:38 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:25274 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1424194AbWLBV4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:56:37 -0500
Message-ID: <4571F690.8040809@ccr.jussieu.fr>
Date: Sat, 02 Dec 2006 22:56:32 +0100
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
Organization: Universite Pierre & Marie Curie - Paris 6
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Bernard Pidoux F6BVP <pidoux@ccr.jussieu.fr>
Subject: Confusing stream of atkbd messages after failed boot
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem with kernel 2.6.19 :

When booting thare are a series of uninterrupted messages about
atkbd.c spurious ACK on isa0060 / seri0
and a kernel panic.

This is with 2.6.19 while 2.6.18.3 was fine on the same machine.

First I want to say that the main board, CPU, chipset and bios are quite
old : ASUS P2BF, PII 267.284 MHz Katmath.

The main system characteristics is ACPI : RSPD (v000 ASUS    ) @
0x000f7da0 returning an >>> ERROR : Invalid checksum

As a result there is no asus acpi module used.

Here is lspci dump :
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge
(rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 01)
00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 04)

On another less old mainboard ASUS P3BF there are no problems with
keyboard on 2.6.19 :
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)

I tried to make module atkbd but the keyboard would not work at all.
Same for kernel 2.6.18.3. No active keyboard when module atkbd.ko is
selected.

Now concerning the SATA question. When making install 2.6.19 kernel it
failed claiming that module ata_piix was not satisfied.
Although I have no SCSI device, the only solution was to validate ALL
the following make menuconfig options in order to satisfy dependencies.

SCSI device support
<M> SCSI device support
<M> SCSI disk support

Serial ATA (prod) / and Parallel ATA experimental drivers

<M> ATA device support
<M> AHCI SATA support
<M> Intel PIIX / ICH SATA support

As a result the following modules are loaded :
sd_mod, ahci, ata_piix, libata, scsi_mod

This seems rather complicated for a quite simple IDE disk system.

Finally, I must say that on my second Linux machine, there is query for
 ata_piix and no need for the above modules.
As IDE interfaces are the same I would be glad to know why such a
difference ?

Please Cc: to me as I am not on the list.

Bernard, f6bvp


-----------

List:       linux-kernel
Subject:    Confusing stream of atkbd messages after failed boot
From:       "Alan J. Wylie" <alan () wylie ! me ! uk>
Date:       2006-12-02 13:56:13
Message-ID: 17777.34301.958405.967354 () wylie ! me ! uk
[Download message RAW]


On upgrading to 2.6.19, I didn't bother reading the release notes, did
a "make oldconfig", and rebooted. The boot failed (since the SATA
.config options had been moved) and I was presented with a continous
stream of error messages:

atkbd.c: Spurious ACK on isa0060/serio
  Some program might be trying to access hardware directly.

These seem to be as a result of the keyboard LEDs being flashed.

They cause the real error message:

Cannot open root device

and the preceding kernel messages which show a lack of detection of
the SATA hard drive to be rapidly scrolled off screen.

The atkbd message should at the very least be rate limited.

-- 
Alan J. Wylie
http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery





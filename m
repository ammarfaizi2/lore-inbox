Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130452AbRBEPKk>; Mon, 5 Feb 2001 10:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbRBEPKU>; Mon, 5 Feb 2001 10:10:20 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:43268 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S130529AbRBEPKN>; Mon, 5 Feb 2001 10:10:13 -0500
Date: Mon, 5 Feb 2001 15:08:02 +0000
To: linux-kernel@vger.kernel.org
Subject: VIA silent disk corruption - likely fix
Message-ID: <20010205150802.A1568@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found the cause of silent disk corruption on my A7V motherboard,
and it might affect all boards with the same North bridge (KT133 etc).

For some reason the IDE controller(s) was sometimes picking up stale
data during bus master DMA to the drive. Assuming that there was no bug
in the CPU it had to be the North bridge that was caching the stuff when
it shouldn't have been. I assume the problem would also apply to other
bus masters (SCSI, NIC etc).

Scanning the motherboard manual showed up a chipset setting "PCI master
read caching" which I suspect is the culprit. According to the manual
this defaults to "on" for Athlons and "off" for Durons (obviously other
BIOSes / MB might treat this setting differently). Unfortunately my BIOS
does not allow me to change this setting independently [1], I only have
the choice of running the machine in "normal" or "optimal" configuration
to alter this setting ("optimal" is the default).

In "normal" mode my machine is rock solid and I see no corruption,
however "normal" mode also changes a lot of other settings (AGP speed,
DRAM interleave etc). Anyone experiencing such corruption should look
for a BIOS setting which disables this "feature".

If anyone out there has a BIOS which allows them to change just this one
setting can they diff the "lspci -vvxxx" output with the setting off and
then on so we can isolate which host bridge biti(s) control this feature.
Maybe we can then add it to 'pci_quirks' and reduce the number of VIA
corruption reports.

P.

[1] the BIOS appears to let you change the option but it defaults the
option the moment you leave the "advanced settings" screen :-(
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

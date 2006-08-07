Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWHGVM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWHGVM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWHGVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:12:21 -0400
Received: from us.cactii.net ([66.160.141.151]:51729 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S932376AbWHGVML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:12:11 -0400
Date: Mon, 7 Aug 2006 23:11:46 +0200
From: Ben Buxton <kernel@bb.cactii.net>
To: linux-kernel@vger.kernel.org
Subject: SATA S3 resume problems on HP NC6400 notebook
Message-ID: <20060807211146.GA17092@cactii.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get S3 suspend working on a new HP Nc6400 notebook PC, and
I'm having problems getting SATA restarted on resume. 

The SATA controller is an intel ICH7/AHCI, as shown in this lspci -v:

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 01)
        Subsystem: Hewlett-Packard Company Unknown device 30ad
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Hewlett-Packard Company Unknown device 30ad
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 40a0 [size=16]

00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 01) (prog-if 01 [AHCI 1.0])
        Subsystem: Hewlett-Packard Company Unknown device 30ad
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 58
        I/O ports at 13f0 [size=8]
        I/O ports at 15f4 [size=4]
        I/O ports at 1370 [size=8]
        I/O ports at 1574 [size=4]
        I/O ports at 40d0 [size=16]
        Memory at f4785000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [70] Power Management version 2

The BIOS on this notebook is pretty basic, at least as far as user
configuration options goes. I tried the ata_piix driver, but the SATA
controller wasn't detected, and there's no way to change the bios mode.

I read about -mm6 and tried to give it a go, but I get this error:

ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0x2 frozen
ata1.00: tag 0 cmd 0x35 Emask 0x14 stat 0x40 err 0x0 (ATA bus error)
ata1: waiting for device to spin up (8 secs)
ata1: soft resetting port
ata1: softreset failed (1st FIS failed)
ata1: softreset failed, retrying in 5 secs
ata1: hard resetting port
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: COMRESET failed (device not ready)
ata1: hardreset failed, retrying in 5 secs
ata1: hard resetting port
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: COMRESET failed (device not ready)
ata1: reset failed, giving up

After a while, there are SCSI errors reported, naturally.

And this is the error with 2.6.17.7 vanilla.

ata1: handling error/timeout
ata1: port reset. p_is 400000 is 0 pis 400000 cmd 2004 tf 80 ss 113 se 4050000
ata1: status=0x50 { DriveReady SeekComplete }
sda: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0x8b8008e

Which repeats before ext3 gives an error.

So...what can I do to help get this up and running?

Ben


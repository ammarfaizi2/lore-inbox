Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUHNXAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUHNXAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUHNXAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:00:39 -0400
Received: from pcp04473995pcs.brmngh01.mi.comcast.net ([68.40.98.164]:38528
	"EHLO cyborean.com") by vger.kernel.org with ESMTP id S266271AbUHNXAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:00:18 -0400
Message-ID: <32914.10.100.42.2.1092524416.squirrel@10.100.42.2>
Date: Sat, 14 Aug 2004 19:00:16 -0400 (EDT)
Subject: Symbios hangs on boot since 2.6.6
From: "George Glover" <hyperborean@comcast.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I believe this error has been reported once before and I was not able to
track down a response.

http://marc.theaimsgroup.com/?l=linux-kernel&m=108332206118640&w=2

Starting with (linux-2.6.6) sym-2.1.18j I see: (written + re-typed)

...
sym0: <1010-33> rev 0x1 at pci 0000:00:08.0 irq 169
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: QUANTUM   Model: ATLAS10KII_36SCA  Rev: QK6C
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:1:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:1:0): Beginning Domain Validation
sym0:1: wide asynchronous.
sym0:1:0: ABORT operation started.
sym0:1:0: ABORT operation timed-out.
sym0:1:0: DEVICE RESET operation started.
sym0:1:0: DEVICE RESET operation timed-out.
sym0:1:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0: SCSI BUS operation completed.
...
It repeats and ends with a HOST RESET operation and the system stops.


A "normal" boot sequence from linux-2.6.5 is:
...
sym0: <1010-33> rev 0x1 at pci 0000:00:08.0 irq 169
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18i
  Vendor: QUANTUM   Model: ATLAS10KII_36SCA  Rev: QK6C
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:1:0: tagged command queuing enabled, command queue depth 16.
  Vendor: QUANTUM   Model: ATLAS10KII_36SCA  Rev: QK6C
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:2:0: tagged command queuing enabled, command queue depth 16.
  Vendor: QUANTUM   Model: ATLAS10KII_36SCA  Rev: QK6C
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:4:0: tagged command queuing enabled, command queue depth 16.
  Vendor: QUANTUM   Model: ATLAS10KII_36SCA  Rev: QK6C
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:8:0: tagged command queuing enabled, command queue depth 16.
sym1: <1010-33> rev 0x1 at pci 0000:00:08.1 irq 177
sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18i
  Vendor: QUANTUM   Model: XP34550W          Rev: LXY4
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym1:0:0: tagged command queuing enabled, command queue depth 16.
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)


The relevant adapter(s) is:

00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3
SCSI Ad
apter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1040
        Flags: bus master, medium devsel, latency 72, IRQ 169
        I/O ports at c000 [size=256]
        Memory at f9006000 (64-bit, non-prefetchable) [size=1K]
        Memory at f9002000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2

00:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3
SCSI Ad
apter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1040
        Flags: bus master, medium devsel, latency 72, IRQ 177
        I/O ports at c400 [size=256]
        Memory at f9004000 (64-bit, non-prefetchable) [size=1K]
        Memory at f9000000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2

Thank's in advance to anyone with advice!

George




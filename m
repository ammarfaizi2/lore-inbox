Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263928AbRFMArN>; Tue, 12 Jun 2001 20:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263929AbRFMArC>; Tue, 12 Jun 2001 20:47:02 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:18181 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S263928AbRFMAqt>;
	Tue, 12 Jun 2001 20:46:49 -0400
Date: Tue, 12 Jun 2001 20:46:47 -0400
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: linux-kernel@vger.kernel.org
Subject: IRQ problems w/VIA Apollo VP2/97 & NCR 53c875
Message-ID: <20010612204647.A14088@saturn.tlug.org>
Mail-Followup-To: Mike Frisch <mfrisch@saturn.tlug.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: IRQ conflict on VIA Apollo VP2/97-based motherboard between
dual controllers on NCR 53c875 (Diamond Fireport 40).  Kernel version is
2.4.5-ac9.

--- cut here ---

00:00.0 Host bridge: VIA Technologies, Inc. VT82C595/97 [Apollo VP2/97]
(rev 04)
        Flags: bus master, 66Mhz, medium devsel, latency 64

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 25)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 6000 [size=16]

--- cut here ---

When I attempt to mobprobe the ncr53c8xx module, I get the following
output:

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0b.0
IRQ routing conflict in pirq table for device 00:0b.0
IRQ routing conflict in pirq table for device 00:0b.1

It appears that something is getting confused and doesn't want to allow
the two controllers of this card to share the same IRQ.

Here is the relevent output from 'lspci -v':

--- cut here ---

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 14)
        Subsystem: Diamond Multimedia Systems FirePort 40 Dual SCSI
Controller
        Flags: bus master, medium devsel, latency 144, IRQ 10
        I/O ports at 6c00 [size=256]
        Memory at e2001000 (32-bit, non-prefetchable) [size=256]
        Memory at e2002000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 14)
        Subsystem: Diamond Multimedia Systems FirePort 40 Dual SCSI
Controller
        Flags: bus master, medium devsel, latency 144, IRQ 10
        I/O ports at 7000 [size=256]
        Memory at e2003000 (32-bit, non-prefetchable) [size=256]
        Memory at e2004000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

--- cut here --

There are no other devices using IRQ10.  Is this a lost cause?  This
controller and drives in their current configuration can be moved to an
Intel based machine and works flawlessly.  I have yet to see this
controller work on this VIA motherboard.

Any assistance is appreciated.

Thanks,

Mike.

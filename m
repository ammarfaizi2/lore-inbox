Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTBLSFO>; Wed, 12 Feb 2003 13:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbTBLSFO>; Wed, 12 Feb 2003 13:05:14 -0500
Received: from p15108950.pureserver.info ([217.160.128.7]:48105 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id <S267268AbTBLSFM>; Wed, 12 Feb 2003 13:05:12 -0500
Date: Wed, 12 Feb 2003 19:15:08 +0100
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19: an old known VIA DMA problem?
Message-ID: <20030212181508.GB11777@lisa>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-pre11 i686
X-Editor: VIM 6.0
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On one of my production machines I found this:

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status timeout: status=0xd0 { Busy }
hda: drive not ready for command
ide0: reset: success

The system is up for 96 Days now and this message block appeared two times
since then. It is running a vanilla 2.4.19 Kernel.

I found discussions about that in the archives for early kernel versions
arround 2.4.2 or something so I wonder if this problem is still
known to be there or whats going on with this.

Are there any significant changes from 2.4.19 to 2.4.20 regarding
this behavior?

What can I do to solve this issue?

Thanks for any hints.

-Marc

PS: Some system information:

pluto:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8139 (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a)
pluto:~#

pluto:~# hdparm -i /dev/hda

/dev/hda:

 Model=IC35L040AVVA07-0, FwRev=VA2OA52A, SerialNo=VNC202A2LM62LA
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5

pluto:~#

pluto:~# cat /proc/interrupts
           CPU0
  0:  829757208    IO-APIC-edge  timer
  1:          2    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
 14:   17588439    IO-APIC-edge  ide0
 15:   38953770   IO-APIC-level  eth0
NMI:          0
LOC:  829796901
ERR:          0
MIS:          0
pluto:~#

-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end

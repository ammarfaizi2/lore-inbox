Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVBUJty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVBUJty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVBUJty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 04:49:54 -0500
Received: from canardo.mork.no ([148.122.252.1]:40890 "EHLO canardo.mork.no")
	by vger.kernel.org with ESMTP id S261933AbVBUJtt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 04:49:49 -0500
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Organization: Delighted of Daredevils
References: <3zVzJ-1GD-5@gated-at.bofh.it> <3zVzM-1GD-17@gated-at.bofh.it>
	<3zW2R-1Yl-15@gated-at.bofh.it> <3zWvU-2tS-25@gated-at.bofh.it>
	<3zWYX-2Ob-23@gated-at.bofh.it>
Date: Mon, 21 Feb 2005 10:49:46 +0100
In-Reply-To: <3zWYX-2Ob-23@gated-at.bofh.it> (David =?iso-8859-1?Q?H=E4rde?=
 =?iso-8859-1?Q?man's?= message of
	"Sun, 20 Feb 2005 12:00:19 +0100")
Message-ID: <87ekfa8cp1.fsf@obelix.mork.no>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I might have a new datapoint to add to this discussion:
I've got a IBM Thinkpad T42 with 1 GB RAM.  Never had any problems
with PCMCIA, but that's probably just because another PCI device has
been mapped into the hole in the BIOS memory map:

bjorn@obelix:~$ grep e820 /var/log/dmesg 
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff50000 (usable)
 BIOS-e820: 000000003ff50000 - 000000003ff67000 (ACPI data)
 BIOS-e820: 000000003ff67000 - 000000003ff79000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)

bjorn@obelix:~$ cat /proc/iomem 
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ff4ffff : System RAM
  00100000-002d4013 : Kernel code
  002d4014-00399f3f : Kernel data
3ff50000-3ff66fff : ACPI Tables
3ff67000-3ff78fff : ACPI Non-volatile Storage
3ff79000-3ff793ff : 0000:00:1f.1
3ff80000-3fffffff : reserved
40000000-403fffff : PCI CardBus #03
40400000-407fffff : PCI CardBus #03
40800000-40bfffff : PCI CardBus #07
40c00000-40ffffff : PCI CardBus #07
b0000000-b0000fff : 0000:02:00.0
  b0000000-b0000fff : yenta_socket
b1000000-b1000fff : 0000:02:00.1
  b1000000-b1000fff : yenta_socket
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4
c0100000-c01fffff : PCI Bus #01
  c0100000-c010ffff : 0000:01:00.0
    c0100000-c010ffff : radeonfb
c0200000-c020ffff : 0000:02:01.0
  c0200000-c020ffff : e1000
c0210000-c021ffff : 0000:02:02.0
  c0210000-c021ffff : ath
c0220000-c023ffff : 0000:02:01.0
  c0220000-c023ffff : e1000
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : radeonfb
ff800000-ffffffff : reserved

bjorn@obelix:~$ lspci -vv -s 0:1f.1
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 3ff79000 (32-bit, non-prefetchable) [size=1K]



Bjørn
-- 
You have the lack of intelligence of a sadist.  

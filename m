Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTIRWLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 18:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTIRWLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 18:11:08 -0400
Received: from catv-d5deb78c.bp13catv.broadband.hu ([213.222.183.140]:40076
	"EHLO dap.index") by vger.kernel.org with ESMTP id S262175AbTIRWLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 18:11:03 -0400
Subject: problem changing DMA on SiImage680
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1063922940.4979.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Sep 2003 00:09:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've reported earlier that the CMD649 chipset locks up the entire
machine when the kernel tries to change DMA on a channel where's active
transfer going on.. now, I've been tried it with a SiI680 card, the
result is better, but still sad: just the card freezes up, the system
stays alive and the four drives become offline..

 is it sure that a good idea to play with DMA if an error occurs? it
would be much better to get an I/O error instead of this lockups and
card freezes for me.. so can I disable this 'feature' easily with a
little hack? I think it's not too hard, so could you help me with a
hint, please?


the test:

console 1:
# dd if=/dev/hdf of=/dev/null bs=4k

console 2:
# hdparm -d0 /dev/hde
hde: set_drive_speed_status: status=0xd0 { Busy }
hde: set_drive_speed_status: status=0xff { Busy }
hde: DMA disabled
hdf: dma_timer_expiry: dma status == 0x40
hdf: timeout waiting for DMA
hdf: timeout waiting for DMA
hdf: status timeout: status=0xff { Busy }

hdf: drive not ready for command
ide2: reset timed-out, status=0xff
hdf: status timeout: status=0xff { Busy }

hdf: drive not ready for command
ide2: reset timed-out, status=0xff
blk: queue c0479690, I/O limit 4095Mb (mask 0xffffffff)
end_request: I/O error, dev 21:40 (hdf), sector 166920
[...]


configuration:
uname -a:
Linux dap 2.4.22 #5 SMP Thu Sep 18 22:38:56 CEST 2003 i686 unknown

lspci -vvvv:
[...]
00:0d.0 RAID bus controller: CMD Technology Inc: Unknown device 0680 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3680
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 01
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at d400 [size=4]
        Region 2: I/O ports at d800 [size=8]
        Region 3: I/O ports at dc00 [size=4]
        Region 4: I/O ports at e000 [size=16]
        Region 5: Memory at ef100000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
[...]

drives (but seems like it's doesn't matter):
hde: ST31720A, ATA DISK drive
hdf: Maxtor 90650U2, ATA DISK drive
hde: 3329424 sectors (1705 MB), CHS=3303/16/63, DMA
hdf: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=12495/16/63, UDMA(66)


tia,
-- 
  DaP

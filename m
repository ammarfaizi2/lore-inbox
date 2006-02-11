Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWBKJfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWBKJfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWBKJfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:35:34 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:23826 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1751318AbWBKJfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:35:33 -0500
Date: Sat, 11 Feb 2006 10:35:20 +0100
From: iSteve <isteve@rulez.cz>
To: linux-kernel@vger.kernel.org
Subject: Packet writing issue on 2.6.15.1
Message-ID: <20060211103520.455746f6@silver>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I've wanted to try out packet writing on my Plextor CD-RW (PLEXTOR CD-R
PREMIUM, ATAPI CD/DVD-ROM drive). Setting up device via "pktcdvd 0 /dev/hdc"
went without any problem and I had the device created. 

I then mounted UDF on the device, /proc/mounts reported it as rw. However, when
attempting to write and then sync, the sync fails and I get sinister output in
dmesg (below). I wonder what causes this issue and if I may resolve it somehow.

Thanks in advance for reply.
-- 
 -- iSteve

System details:

Motherboard: MSI KT4 Ultra
IDE controller used onboard:
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a
[Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 14
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Layout of devices on IDE controller: primary-master: hard disk, primary-slave: 
hard disk, secondary-master: this plextor cd-rw, secondary-slave: teac cd-rom.

Kernel: 2.6.15.1 + swsup2, vesafb-tng (as module, not loaded), squashfs.


Dmesg output since the first moment pktcdvd is involved:

pktcdvd: inserted media is CD-RW
pktcdvd: detected zero packet size!
pktcdvd: Variable packets, 32 blocks, Mode-1 disc
pktcdvd: Max. media speed: 10
pktcdvd: write speed 10x
pktcdvd: 26562kB available on disc
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp
2006/02/04 19:03 (1000)
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13184
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13192
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13200
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13208
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13216
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13224
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13232
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13240
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13248
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13256
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13264
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13272
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13280
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13288
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13296
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 13304
Buffer I/O error on device pktcdvd0, logical block 3299
lost page write due to I/O error on pktcdvd0
Buffer I/O error on device pktcdvd0, logical block 3300
lost page write due to I/O error on pktcdvd0
Buffer I/O error on device pktcdvd0, logical block 3303
lost page write due to I/O error on pktcdvd0
Buffer I/O error on device pktcdvd0, logical block 3305
lost page write due to I/O error on pktcdvd0
Buffer I/O error on device pktcdvd0, logical block 3306
lost page write due to I/O error on pktcdvd0

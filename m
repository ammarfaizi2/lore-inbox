Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTKJPKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTKJPKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:10:24 -0500
Received: from ncircle.nullnet.fi ([62.236.96.207]:27551 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S263775AbTKJPKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:10:21 -0500
Message-ID: <29277.194.237.142.13.1068477017.squirrel@ncircle.nullnet.fi>
In-Reply-To: <20031110054327.22352.qmail@linuxmail.org>
References: <20031110054327.22352.qmail@linuxmail.org>
Date: Mon, 10 Nov 2003 17:10:17 +0200 (EET)
Subject: Re: (HPT372A) DMA/Interrupt problems, again
From: "Tomi Orava" <tomimo+linux-kernel@ncircle.nullnet.fi>
To: "Gavin Baker" <gavbaker@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have an Highpoint "RocketRaid 133" dual channel PCI IDE "raid"
> controller that uses an HPT372A.

>   hdg: status timeout: status=0xd0 {Busy}
>
>   hdg: DMA disabled
>   hdg: drive not ready for command
>   ide3: reset: master: error (0x00?)
>   hdg: status timeout: status=0xd0 {Busy}
>
>   hdg: drive not ready for command
>   ide3: reset: master: error (0x00?)
>   end-request: I/O error, dev hdg, sector xxxxxx
>   EXT3-fs error (device md0): ext3_get_inode_loc: unable to read inode
>   block - inode = xxxxxx, block = xxxxxx

There was some discussion couple of weeks ago about a
similar problem with HPT374-controller. However, we did not
find a solution for this problem, even though there was a 3-4
persons who had seen this problem with different hardware
configuration.

I'm starting to wonder if the case is not really about a problem
in HPT366-driver but somewhere lower in IDE/interrupt code
as I got the following errors just an hour ago, with Sil680-controller.

The problem occurs only on _heavy_ I/O-access ie. whenever
I'm updating Postresql database with lkml web-archive data for example.
On normal/light use the system works just fine.

Do other people see this error a lot ?

Regards,
Tomi Orava

PS. Has anyone with enough knowledge about Linux memory handling
       checked if Mark Bellon's slab-patch (msg subject:
       "PATCH (2.4.x) - Interrupts disabled for a long time")
       might somehow affect these IDE-problems ? Didn't see
       any comments about the patch yet ...

----------------------------------------------------------------------------------
hde: dma_timer_expiry: dma status == 0x21
hde: error waiting for DMA
hde: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

blk: queue c0466908, I/O limit 4095Mb (mask 0xffffffff)
hde: dma_timer_expiry: dma status == 0x21
hde: error waiting for DMA
hde: dma timeout retry: status=0xd0 { Busy }

hde: DMA disabled
ide2: reset timed-out, status=0xd0
hde: status timeout: status=0xd0 { Busy }

hde: drive not ready for command
ide2: reset timed-out, status=0xd0
end_request: I/O error, dev 21:02 (hde), sector 58728019
raid1: Disk failure on hde2, disabling device.
^IOperation continuing on 1 devices
-------------------------------------------------------------------------------------

The hardware in this case was:

Epox 8K9A3+/1.4Mhz AMD/TB
CMD/Sil 680 ide-controller:
2xMAXTOR 6L060J3 (D740X)

----------------------------------------------------------------
00:09.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
        Subsystem: CMD Technology Inc PCI0680
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 01
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9c00 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at df000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 80 06 07 00 90 0a 01 00 04 01 01 40 00 00
10: 01 90 00 00 01 94 00 00 01 98 00 00 01 9c 00 00
20: 01 a0 00 00 00 00 00 df 00 00 00 00 95 10 80 06
30: 00 00 00 00 60 00 00 00 00 00 00 00 11 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 20 00 00 50 e8 37 00 00 20 00 00 40 e8 37
80: 03 00 00 00 03 00 00 00 00 00 11 00 00 00 00 00
90: ec ff 01 09 ff ff ff 44 00 00 00 18 00 00 00 00
a0: 01 60 8a 32 8a 32 dd 62 c1 10 92 43 01 40 09 40
b0: 01 60 8a 32 8a 32 dd 62 c1 10 92 43 01 40 09 40
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00








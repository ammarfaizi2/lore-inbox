Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272229AbTGYRhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTGYRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:37:20 -0400
Received: from devil.servak.biz ([209.124.81.2]:26844 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S272229AbTGYRgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:36:21 -0400
Subject: Re: Firewire
From: Torrey Hoffman <thoffman@arnor.net>
To: Ben Collins <bcollins@debian.org>
Cc: Sam Bromley <sbromley@cogeco.ca>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030725161803.GJ1512@phunnypharm.org>
References: <20030725012723.GF23196@ruvolo.net>
	 <20030725012908.GT1512@phunnypharm.org>
	 <1059103424.24427.108.camel@daedalus.samhome.net>
	 <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net>
	 <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net>
	 <20030725142926.GD1512@phunnypharm.org>
	 <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net>
	 <20030725161803.GJ1512@phunnypharm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059155483.2525.16.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jul 2003 10:51:24 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email is a little long because of all the log output... I hope all
the people on the cc line don't mind.

So, I applied Ben's last patch, added an extra debug line to print
jiffies, expire, and packet->sendtime in abort_timedouts, and enabled
the "excessive debugging output" config option. 

This was based on 2.6.0-test1-ac3.   When I booted, with nothing plugged
into the firewire card, this is the tail of the dmesg log:

SCSI subsystem initialized
ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:02:0b.0
PCI: Sharing IRQ 10 with 0000:02:01.0
ohci1394_0: Remapped memory spaces reg 0xec893000
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 000000ff
ohci1394_0: 8 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 00406300:00001c47
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=1 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e8201000-e82017ff]  Max Packet=[2048]
ohci1394_0: request csr_rom address: e6770000
ohci1394_0: IntEvent: 00030010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ieee1394: TLABEL: splicing pending packets for abort_requests
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8956 received
ieee1394: Including SelfID 0x56897f80
ohci1394_0: SelfID for this node is 0x807f8956
ohci1394_0: SelfID complete
ohci1394_0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ieee1394: Initiating ConfigROM request for node 00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts:
ieee1394: TLABEL: jiffies=4294693285d, expire=98d, packet->sendtime=4294693186d:
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 7ee60404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00160 ffc00000 00000000 7ee60404
ieee1394: TLABEL: Checking for tlabel 0
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00160 ffc00000 00000000 7ee60404
ieee1394: send packet local: ffc00540 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts:
ieee1394: TLABEL: jiffies=4294693717d, expire=98d, packet->sendtime=4294693618d:
ieee1394: received packet: ffc00540 ffc0ffff f0000400
ieee1394: send packet local: ffc00560 ffc00000 00000000 7ee60404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00560 ffc00000 00000000 7ee60404
ieee1394: TLABEL: Checking for tlabel 1
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00560 ffc00000 00000000 7ee60404
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 9 for device 0000:02:09.0
PCI: Sharing IRQ 9 with 0000:00:1f.2
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xec897800, 00:A0:CC:D2:4A:8A, IRQ 9.
ieee1394: send packet local: ffc00940 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts:
ieee1394: TLABEL: jiffies=4294694149d, expire=98d, packet->sendtime=4294694050d:
ieee1394: received packet: ffc00940 ffc0ffff f0000400
ieee1394: send packet local: ffc00960 ffc00000 00000000 7ee60404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00960 ffc00000 00000000 7ee60404
ieee1394: TLABEL: Checking for tlabel 2
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00960 ffc00000 00000000 7ee60404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394_0: Starting transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
ieee1394: TLABEL: not pending or no response expected, returning
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
(END)

When I plugged in a firewire device (which happened to be an IDE CDRW in
an external bridge case) I got an endless spew of messages dumped to the
log, until I unplugged the firewire cable:

Jul 25 10:32:26 torrey kernel: ohci1394_0: IntEvent: 00020010
Jul 25 10:32:26 torrey kernel: ohci1394_0: irq_handler: Bus reset requested
Jul 25 10:32:26 torrey kernel: ohci1394_0: Cancel request received
Jul 25 10:32:26 torrey kernel: ieee1394: TLABEL: splicing pending packets for abort_requests
Jul 25 10:32:26 torrey kernel: ohci1394_0: Got RQPkt interrupt status=0x00008409
Jul 25 10:32:26 torrey kernel: ohci1394_0: Single packet rcv'd
Jul 25 10:32:26 torrey kernel: ohci1394_0: Got phy packet ctx=0 ... discarded
Jul 25 10:32:26 torrey kernel: ohci1394_0: IntEvent: 00010000
Jul 25 10:32:26 torrey kernel: ohci1394_0: SelfID interrupt received (phyid 1, root)
Jul 25 10:32:26 torrey kernel: ohci1394_0: SelfID packet 0x807f8762 received
Jul 25 10:32:26 torrey kernel: ieee1394: Including SelfID 0x62877f80
Jul 25 10:32:26 torrey kernel: ohci1394_0: SelfID packet 0x817f89d4 received
Jul 25 10:32:26 torrey kernel: ieee1394: Including SelfID 0xd4897f81
Jul 25 10:32:26 torrey kernel: ohci1394_0: SelfID for this node is 0x817f89d4
Jul 25 10:32:26 torrey kernel: ohci1394_0: SelfID complete
Jul 25 10:32:26 torrey kernel: ohci1394_0: PhyReqFilter=ffffffffffffffff
Jul 25 10:32:26 torrey kernel: ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC1 node_id: 0xFFC1
Jul 25 10:32:26 torrey kernel: ohci1394_0: Cycle master enabled
Jul 25 10:32:26 torrey kernel: ieee1394: NodeMgr: Processing host reset for knodemgrd_0
Jul 25 10:32:26 torrey kernel: ieee1394: Initiating ConfigROM request for node 00:1023
Jul 25 10:32:26 torrey kernel: ieee1394: send packet 400: ffc00d40 ffc1ffff f0000400
Jul 25 10:32:26 torrey kernel: ohci1394_0: Inserting packet for node 00:1023, tlabel=3, tcode=0x4, speed=2
Jul 25 10:32:26 torrey kernel: ohci1394_0: Starting transmit DMA ctx=0
Jul 25 10:32:26 torrey kernel: ohci1394_0: IntEvent: 00000001
Jul 25 10:32:26 torrey kernel: ohci1394_0: Got reqTxComplete interrupt status=0x00008012
Jul 25 10:32:26 torrey kernel: ohci1394_0: Packet sent to node 0 tcode=0x4 tLabel=0x03 ack=0x12 spd=0 data=0x00000000 ctx=0
Jul 25 10:32:26 torrey kernel: ieee1394: TLABEL: appending packet to pending list
Jul 25 10:32:26 torrey kernel: ohci1394_0: IntEvent: 00000020
Jul 25 10:32:26 torrey kernel: ohci1394_0: Got RSPkt interrupt status=0x00008451
Jul 25 10:32:26 torrey kernel: ohci1394_0: Single packet rcv'd
Jul 25 10:32:26 torrey kernel: ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x6 length=20 ctx=0 tlabel=21
Jul 25 10:32:26 torrey kernel: ieee1394: received packet: ffc10d60 ffc00000 00000000 45863a04
Jul 25 10:32:26 torrey kernel: ieee1394: TLABEL: Checking for tlabel 3
Jul 25 10:32:26 torrey kernel: ieee1394: TLABEL: tlabel 3 in list
Jul 25 10:32:27 torrey kernel: ieee1394: TLABEL: Found tlabel
Jul 25 10:32:27 torrey kernel: abel=0x27 ack=0x12 spd=0 data=0x00000000 ctx=0
Jul 25 10:32:27 torrey kernel: ieee1394: TLABEL: appending packet to pending list
Jul 25 10:32:27 torrey kernel: ohci1394_0: IntEvent: 00000020
Jul 25 10:32:27 torrey kernel: ohci1394_0: Got RSPkt interrupt status=0x00008451
Jul 25 10:32:27 torrey kernel: ohci1394_0: Single packet rcv'd
Jul 25 10:32:27 torrey kernel: ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x6 length=20 ctx=0 tlabel=21
Jul 25 10:32:27 torrey kernel: ieee1394: received packet: ffc19d60 ffc00000 00000000 00c00054
Jul 25 10:32:27 torrey kernel: ieee1394: TLABEL: Checking for tlabel 39
Jul 25 10:32:27 torrey kernel: ieee1394: TLABEL: tlabel 39 in list
Jul 25 10:32:27 torrey kernel: ieee1394: TLABEL: Found tlabel
Jul 25 10:32:27 torrey kernel: ieee1394: send packet 400: ffc0a140 ffc1ffff f0000444
Jul 25 10:32:28 torrey kernel: ohci1394_0: Inserting packet for node 00:1023, tlabel=40, tcode=0x4, speed=2
Jul 25 10:32:28 torrey kernel: ohci1394_0: Waking transmit DMA ctx=0
Jul 25 10:32:28 torrey kernel: ohci1394_0: IntEvent: 00000001
Jul 25 10:32:28 torrey kernel: ohci1394_0: Got reqTxComplete interrupt status=0x00008012
Jul 25 10:32:28 torrey kernel: ohci1394_0: Packet sent to node 0 tcode=0x4 tLabel=0x28 ack=0x12 spd=0 data=0x00000000 ctx=0
Jul 25 10:32:28 torrey kernel: ieee1394: TLABEL: appending packet to pending list
Jul 25 10:32:28 torrey kernel: ohci1394_0: IntEvent: 00000020
Jul 25 10:32:28 torrey kernel: ohci1394_0: Got RSPkt interrupt status=0x00008451
Jul 25 10:32:28 torrey kernel: ohci1394_0: Single packet rcv'd
Jul 25 10:32:28 torrey kernel: ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x6 length=20 ctx=0 tlabel=21
Jul 25 10:32:28 torrey kernel: ieee1394: received packet: ffc1a160 ffc00000 00000000 083c003a
Jul 25 10:32:28 torrey kernel: ieee1394: TLABEL: Checking for tlabel 40
Jul 25 10:32:28 torrey kernel: ieee1394: TLABEL: tlabel 40 in list
Jul 25 10:32:28 torrey kernel: ieee1394: TLABEL: Found tlabel
Jul 25 10:32:28 torrey kernel: ieee1394: send packet 400: ffc0a540 ffc1ffff f0000448
Jul 25 10:32:28 torrey kernel: ohci1394_0: Inserting packet for node 00:1023, tlabel=41, tcode=0x4, speed=2
Jul 25 10:32:28 torrey kernel: ohci1394_0: Waking transmit DMA ctx=0
Jul 25 10:32:28 torrey kernel: ohci1394_0: IntEvent: 00000001
Jul 25 10:32:28 torrey kernel: ohci1394_0: Got reqTxComplete interrupt status=0x00008012
Jul 25 10:32:29 torrey kernel: ohci1394_0: Packet sent to node 0 tcode=0x4 tLabel=0x29 ack=0x12 spd=0 data=0x00000000 ctx=0
Jul 25 10:32:29 torrey kernel: ieee1394: TLABEL: appending packet to pending list
Jul 25 10:32:29 torrey kernel: ohci1394_0: IntEvent: 00000020
Jul 25 10:32:29 torrey kernel: ohci1394_0: Got RSPkt interrupt status=0x00008451
Jul 25 10:32:29 torrey kernel: ohci1394_0: Single packet rcv'd
Jul 25 10:32:29 torrey kernel: ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x6 length=20 ctx=0 tlabel=21
Jul 25 10:32:29 torrey kernel: ieee1394: received packet: ffc1a560 ffc00000 00000000 9e600038
Jul 25 10:32:29 torrey kernel: ieee1394: TLABEL: Checking for tlabel 41
Jul 25 10:32:29 torrey kernel: ieee1394: TLABEL: tlabel 41 in list
Jul 25 10:32:29 torrey kernel: ieee1394: TLABEL: Found tlabel
Jul 25 10:32:29 torrey kernel: ieee1394: send packet 400: ffc0a940 ffc1ffff f000044c
Jul 25 10:32:29 torrey kernel: ohci1394_0: Inserting packet for node 00:1023, tlabel=42, tcode=0x4, speed=2
Jul 25 10:32:29 torrey kernel: ohci1394_0: Waking transmit DMA ctx=0
Jul 25 10:32:29 torrey kernel: ohci1394_0: IntEvent: 00000001
Jul 25 10:32:29 torrey kernel: ohci1394_0: Got reqTxComplete interrupt status=0x00008012
Jul 25 10:32:29 torrey kernel: ohci1394_0: Packet sent to node 0 tcode=0x4 tLabel=0x2A ack=0x12 spd=0 data=0x00000000 ctx=0
Jul 25 10:32:29 torrey kernel: ieee1394: TLABEL: appending packet to pending list

...  

This went on for about 30 seconds until I gave up and unplugged it.
Finally, some hardware information:

The machine is an ordinary "HP Vectra", single CPU, Pentium III 733, 
RDRAM, 640 MB of RAM.

[root@torrey root]# lspci
00:00.0 Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 03)
00:01.0 PCI bridge: Intel Corp. 82820 820 (Camino) Chipset AGP Bridge (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
02:01.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
02:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)


On Fri, 2003-07-25 at 09:18, Ben Collins wrote: 
> On Fri, Jul 25, 2003 at 09:07:06AM -0700, Chris Ruvolo wrote:
> > On Fri, Jul 25, 2003 at 11:40:09AM -0400, Ben Collins wrote:
> > > Ok, so revert everything and try this patch.
> > 
> > FYI, I got this compile warning (but I don't think its relevant).  Full
> > output from module load follows.
> 
> Ok, in ieee1394_core.c, when it does the "packet removed in
> abort_timedouts" could you make it print the value of jiffies, expire
> and packet->sendtime?
> 
> Thanks.
-- 
Torrey Hoffman
torrey.hoffman@myrio.com (work) / thoffman@arnor.net (home)		



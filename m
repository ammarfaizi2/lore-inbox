Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUBLFDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUBLFDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:03:23 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:8043 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266278AbUBLFDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:03:16 -0500
Message-ID: <402B094B.2030201@myrealbox.com>
Date: Wed, 11 Feb 2004 21:04:11 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: [2.6.3-rc2 bk]  ieee1394 oops on bootup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem started with the bk changesets from Linus yesterday (11Feb).

I get the oops below if Firewire is compiled into the kernel or if the
modules are loaded at bootime (I'm using hotplug+udev).  The strange
thing is that if I load the Firewire modules by hand after bootup then
everything is okay.  (Race condition?)  Sorry I don't have any firewire
devices to test with.

Asus A7V8X mobo:
#lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
00:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit Ethernet (rev 02)
00:0c.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)


......<6>ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:00:07.0 (0094 -> 0097)
ohci1394: fw-host0: Remapped memory spaces reg 0xe08fe000
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host0: 4 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host0: 8 iso transmit contexts available
ohci1394: fw-host0: GUID: 00e01800:000cc27d
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[f3000000-f30007ff]  Max Packet=[2048]
ohci1394: fw-host0: request csr_rom address: def72000
ieee1394: CSR: setting expire to 98, HZ=1000
ohci1394: fw-host0: IntEvent: 00030010
ohci1394: fw-host0: irq_handler: Bus reset requested
ohci1394: fw-host0: Cancel request received
ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host0: SelfID packet 0x807f8952 received
ieee1394: Including SelfID 0x52897f80
ohci1394: fw-host0: SelfID for this node is 0x807f8952
ohci1394: fw-host0: SelfID complete
ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ohci1394: fw-host0: Single packet rcv'd
ohci1394: fw-host0: Got phy packet ctx=0 ... discarded
.<7>ieee1394: Initiating ConfigROM request for node 0-00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 1f710404
ieee1394: received packet: ffc00160 ffc00000 00000000 1f710404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 02a200e0
ieee1394: received packet: ffc00960 ffc00000 00000000 02a200e0
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 0018e000
ieee1394: received packet: ffc00d60 ffc00000 00000000 0018e000
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 7dc20c00
ieee1394: received packet: ffc01160 ffc00000 00000000 7dc20c00
ieee1394: send packet local: ffc01540 ffc0ffff f0000400
ieee1394: received packet: ffc01540 ffc0ffff f0000400
ieee1394: send packet local: ffc01560 ffc00000 00000000 1f710404
ieee1394: received packet: ffc01560 ffc00000 00000000 1f710404
ieee1394: send packet local: ffc01940 ffc0ffff f0000414
ieee1394: received packet: ffc01940 ffc0ffff f0000414
ieee1394: send packet local: ffc01960 ffc00000 00000000 80840300
ieee1394: received packet: ffc01960 ffc00000 00000000 80840300
ieee1394: send packet local: ffc01d40 ffc0ffff f0000418
ieee1394: received packet: ffc01d40 ffc0ffff f0000418
ieee1394: send packet local: ffc01d60 ffc00000 00000000 63400003
ieee1394: received packet: ffc01d60 ffc00000 00000000 63400003
ieee1394: send packet local: ffc02140 ffc0ffff f000041c
ieee1394: received packet: ffc02140 ffc0ffff f000041c
ieee1394: send packet local: ffc02160 ffc00000 00000000 02000081
ieee1394: received packet: ffc02160 ffc00000 00000000 02000081
ieee1394: send packet local: ffc02540 ffc0ffff f0000424
ieee1394: received packet: ffc02540 ffc0ffff f0000424
ieee1394: send packet local: ffc02560 ffc00000 00000000 ab030600
ieee1394: received packet: ffc02560 ffc00000 00000000 ab030600
ieee1394: send packet local: ffc02940 ffc0ffff f0000420
ieee1394: received packet: ffc02940 ffc0ffff f0000420
ieee1394: send packet local: ffc02960 ffc00000 00000000 c083000c
ieee1394: received packet: ffc02960 ffc00000 00000000 c083000c
ieee1394: NodeMgr: raw=0xe000a202 irmc=1 cmc=1 isc=1 bmc=0 pmc=0 cyc_clk_acc=0 max_rec=2048 gen=0 lspd=2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800000cc27d]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394: fw-host0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394: fw-host0: Starting transmit DMA ctx=0
ohci1394: fw-host0: IntEvent: 00000001
ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
ieee1394: send packet local: ffc02d40 ffc0ffff f0000400
ieee1394: received packet: ffc02d40 ffc0ffff f0000400
ieee1394: send packet local: ffc02d60 ffc00000 00000000 1f710404
ieee1394: received packet: ffc02d40 ffc0ffff f0000400
ieee1394: send packet local: ffc02d60 ffc00000 00000000 1f710404
ieee1394: received packet: ffc02d60 ffc00000 00000000 1f710404
ieee1394: send packet local: ffc03140 ffc0ffff f0000414
ieee1394: received packet: ffc03140 ffc0ffff f0000414
ieee1394: send packet local: ffc03160 ffc00000 00000000 80840300
ieee1394: received packet: ffc03160 ffc00000 00000000 80840300
ieee1394: send packet local: ffc03540 ffc0ffff f0000418
ieee1394: received packet: ffc03540 ffc0ffff f0000418
ieee1394: send packet local: ffc03560 ffc00000 00000000 63400003
ieee1394: received packet: ffc03560 ffc00000 00000000 63400003
ieee1394: send packet local: ffc03940 ffc0ffff f000041c
ieee1394: received packet: ffc03940 ffc0ffff f000041c
ieee1394: send packet local: ffc03960 ffc00000 00000000 02000081
ieee1394: received packet: ffc03960 ffc00000 00000000 02000081
ieee1394: send packet local: ffc03d40 ffc0ffff f0000424
ieee1394: received packet: ffc03d40 ffc0ffff f0000424
ieee1394: send packet local: ffc03d60 ffc00000 00000000 ab030600
ieee1394: received packet: ffc03d60 ffc00000 00000000 ab030600
ieee1394: send packet local: ffc04140 ffc0ffff f0000428
ieee1394: received packet: ffc04140 ffc0ffff f0000428
ieee1394: send packet local: ffc04160 ffc00000 00000000 00000000
ieee1394: received packet: ffc04160 ffc00000 00000000 00000000
ieee1394: send packet local: ffc04540 ffc0ffff f000042c
ieee1394: received packet: ffc04540 ffc0ffff f000042c
ieee1394: send packet local: ffc04560 ffc00000 00000000 00000000
ieee1394: received packet: ffc04560 ffc00000 00000000 00000000
ieee1394: send packet local: ffc04940 ffc0ffff f0000430
ieee1394: received packet: ffc04940 ffc0ffff f0000430
ieee1394: send packet local: ffc04960 ffc00000 00000000 756e694c
ieee1394: received packet: ffc04960 ffc00000 00000000 756e694c
ieee1394: send packet local: ffc04d40 ffc0ffff f0000434
ieee1394: received packet: ffc04d40 ffc0ffff f0000434
ieee1394: send packet local: ffc04d60 ffc00000 00000000 484f2078
ieee1394: received packet: ffc04d60 ffc00000 00000000 484f2078
ieee1394: send packet local: ffc05140 ffc0ffff f0000438
ieee1394: received packet: ffc05140 ffc0ffff f0000438
ieee1394: send packet local: ffc05160 ffc00000 00000000 312d4943
ieee1394: received packet: ffc05160 ffc00000 00000000 312d4943
ieee1394: send packet local: ffc05540 ffc0ffff f000043c
ieee1394: send packet local: ffc05140 ffc0ffff f0000438
ieee1394: received packet: ffc05140 ffc0ffff f0000438
ieee1394: send packet local: ffc05160 ffc00000 00000000 312d4943
ieee1394: received packet: ffc05160 ffc00000 00000000 312d4943
ieee1394: send packet local: ffc05540 ffc0ffff f000043c
ieee1394: received packet: ffc05540 ffc0ffff f000043c
ieee1394: send packet local: ffc05560 ffc00000 00000000 00343933
ieee1394: received packet: ffc05560 ffc00000 00000000 00343933
ieee1394: send packet local: ffc05940 ffc0ffff f0000420
ieee1394: received packet: ffc05940 ffc0ffff f0000420
ieee1394: send packet local: ffc05960 ffc00000 00000000 c083000c
ieee1394: received packet: ffc05960 ffc00000 00000000 c083000c
Badness in kobject_get at lib/kobject.c:431
Call Trace:
  [<c01dd31c>] kobject_get+0x4c/0x50
  [<c021cb88>] get_device+0x18/0x30
  [<c021d7e3>] bus_for_each_dev+0x63/0xc0
  [<e095f8bd>] nodemgr_node_probe+0x4d/0x130 [ieee1394]
  [<e095f780>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<e095fd15>] nodemgr_host_thread+0x185/0x1b0 [ieee1394]
  [<e095fb90>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
  [<c0106e49>] kernel_thread_helper+0x5/0xc

Unable to handle kernel paging request at virtual address b828ec83
  printing eip:
b828ec83
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<b828ec83>]    Not tainted
EFLAGS: 00010282
EIP is at 0xb828ec83
eax: b828ec83   ebx: e0991ac4   ecx: df853f9c   edx: 00000000
esi: e095f140   edi: 00000000   ebp: e095dd90   esp: df853f40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 3391, threadinfo=df852000 task=dfb22720)
Stack: c01dd3b8 e0991ac4 e0991aa0 e0991aa8 e0991a00 dfca68c4 c021d800 e0991ac4
        df853f9c e0991a4c 00000000 dfca68bc df853f9c defced58 df853f9c e095f8bd
        e0991a00 dfca68bc df853f9c e095f780 def88000 defced58 def88000 defced58
Call Trace:
  [<c01dd3b8>] kobject_cleanup+0x98/0xa0
  [<c021d800>] bus_for_each_dev+0x80/0xc0
  [<e095f8bd>] nodemgr_node_probe+0x4d/0x130 [ieee1394]
  [<e095f780>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<e095fd15>] nodemgr_host_thread+0x185/0x1b0 [ieee1394]
  [<e095fb90>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
  [<c0106e49>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
  .ready
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)

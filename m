Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTHXA64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 20:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTHXA6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 20:58:55 -0400
Received: from defout.telus.net ([199.185.220.240]:21999 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S263667AbTHXA6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 20:58:41 -0400
Subject: 2.6.0-test4 Firewire still broken, but now more verbose!
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1061686814.3009.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Aug 2003 19:00:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  Firewire still appears to be broken in 'test4.  (And yes, when I
get tired of testing 2.6 I go back to 2.4 to access all of the data I
have on the firewire drives).  This time I compiled all of the debugging
information into FW so that it might be easier to see where it is
breaking.  I also have to mention that I build all FW modules as
modules, but when the system is booting it doesn't want to really load
sbp2 (it says that I built it into the kernel, even though I didn't).
lsmod shows:
[bob@localhost bob]$ lsmod
Module                  Size  Used by
emu10k1               114564  0
sound                  88532  1 emu10k1
ac97_codec             17024  1 emu10k1
soundcore               8256  2 emu10k1,sound
sis900                 18436  0
ipt_REJECT              5760  6
iptable_filter          2304  1
ip_tables              17808  2 ipt_REJECT,iptable_filter
sbp2                   26054  1
ide_scsi               14336  0
ohci1394               42880  0
ieee1394              215180  2 sbp2,ohci1394
reiserfs              218096  1
ext3                  100360  1
jbd                    80408  1 ext3
hid                    18176  0
usbcore               114388  2 hid

...but if I try to rmmod ohci1394, the terminal stalls, even lsmod
doesn't want to run (in another terminal), and 2.6 will then not shut
down properly.

  The following is from dmesg:

 reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x3F ack=0x12 spd=0
data=0x00000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6
length=20 ctx=0 tlabel=2
ieee1394: received packet: ffc2fd60 ffc10000 00000000 65442049
ieee1394: send packet 400: ffc10140 ffc2ffff f00004b8
ohci1394_0: Inserting packet for node 0-01:1023, tlabel=0, tcode=0x4,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x00 ack=0x12 spd=0
data=0x00000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6
length=20 ctx=0 tlabel=2
ieee1394: received packet: ffc20160 ffc10000 00000000 65636976
ieee1394: send packet 400: ffc10540 ffc2ffff f00004bc
ohci1394_0: Inserting packet for node 0-01:1023, tlabel=1, tcode=0x4,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x01 ack=0x12 spd=0
data=0x00000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6
length=20 ctx=0 tlabel=2
ieee1394: received packet: ffc20560 ffc10000 00000000 00000000
ieee1394: send packet 400: ffc10940 ffc2ffff f0000464
ohci1394_0: Inserting packet for node 0-01:1023, tlabel=2, tcode=0x4,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x02 ack=0x12 spd=0
data=0x00000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6
length=20 ctx=0 tlabel=2
ieee1394: received packet: ffc20960 ffc10000 00000000 00000000
ieee1394: send packet 400: ffc10d40 ffc2ffff f0000468
ohci1394_0: Inserting packet for node 0-01:1023, tlabel=3, tcode=0x4,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x03 ack=0x12 spd=0
data=0x00000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6
length=20 ctx=0 tlabel=2
ieee1394: received packet: ffc20d60 ffc10000 00000000 00000000
ieee1394: send packet 400: ffc11140 ffc2ffff f000046c
ohci1394_0: Inserting packet for node 0-01:1023, tlabel=4, tcode=0x4,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x04 ack=0x12 spd=0
data=0x00000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6
length=20 ctx=0 tlabel=2
ieee1394: received packet: ffc21160 ffc10000 00000000 00000000
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e000e0000ae3]
ieee1394: Initiating ConfigROM request for node 0-02:1023
ieee1394: send packet local: ffc20140 ffc2ffff f0000400
ieee1394: received packet: ffc20140 ffc2ffff f0000400
ieee1394: send packet local: ffc20160 ffc20000 00000000 42820404
ieee1394: received packet: ffc20160 ffc20000 00000000 42820404
ieee1394: send packet local: ffc20540 ffc2ffff f0000404
ieee1394: received packet: ffc20540 ffc2ffff f0000404
ieee1394: send packet local: ffc20560 ffc20000 00000000 34393331
ieee1394: received packet: ffc20560 ffc20000 00000000 34393331
ieee1394: send packet local: ffc20940 ffc2ffff f0000408
ieee1394: received packet: ffc20940 ffc2ffff f0000408
ieee1394: send packet local: ffc20960 ffc20000 00000000 02a200e0
ieee1394: received packet: ffc20960 ffc20000 00000000 02a200e0
ieee1394: send packet local: ffc20d40 ffc2ffff f000040c
ieee1394: received packet: ffc20d40 ffc2ffff f000040c
ieee1394: send packet local: ffc20d60 ffc20000 00000000 00061100
ieee1394: received packet: ffc20d60 ffc20000 00000000 00061100
ieee1394: send packet local: ffc21140 ffc2ffff f0000410
ieee1394: received packet: ffc21140 ffc2ffff f0000410
ieee1394: send packet local: ffc21160 ffc20000 00000000 5100251a
ieee1394: received packet: ffc21160 ffc20000 00000000 5100251a
ieee1394: send packet local: ffc21540 ffc2ffff f0000400
ieee1394: received packet: ffc21540 ffc2ffff f0000400
ieee1394: send packet local: ffc21560 ffc20000 00000000 42820404
ieee1394: received packet: ffc21560 ffc20000 00000000 42820404
ieee1394: send packet local: ffc21940 ffc2ffff f0000414
ieee1394: received packet: ffc21940 ffc2ffff f0000414
ieee1394: send packet local: ffc21960 ffc20000 00000000 80840300
ieee1394: received packet: ffc21960 ffc20000 00000000 80840300
ieee1394: send packet local: ffc21d40 ffc2ffff f0000418
ieee1394: received packet: ffc21d40 ffc2ffff f0000418
ieee1394: send packet local: ffc21d60 ffc20000 00000000 63400003
ieee1394: received packet: ffc21d60 ffc20000 00000000 63400003
ieee1394: send packet local: ffc22140 ffc2ffff f000041c
ieee1394: received packet: ffc22140 ffc2ffff f000041c
ieee1394: send packet local: ffc22160 ffc20000 00000000 02000081
ieee1394: received packet: ffc22160 ffc20000 00000000 02000081
ieee1394: send packet local: ffc22540 ffc2ffff f0000424
ieee1394: received packet: ffc22540 ffc2ffff f0000424
ieee1394: send packet local: ffc22560 ffc20000 00000000 ab030600
ieee1394: received packet: ffc22560 ffc20000 00000000 ab030600
ieee1394: send packet local: ffc22940 ffc2ffff f0000420
ieee1394: received packet: ffc22940 ffc2ffff f0000420
ieee1394: send packet local: ffc22960 ffc20000 00000000 c083000c
ieee1394: received packet: ffc22960 ffc20000 00000000 c083000c
ieee1394: NodeMgr: raw=0xe000a202 irmc=1 cmc=1 isc=1 bmc=0 pmc=0
cyc_clk_acc=0 max_rec=2048 gen=0 lspd=2
ieee1394: send packet local: ffc22d40 ffc2ffff f0000400
ieee1394: received packet: ffc22d40 ffc2ffff f0000400
ieee1394: send packet local: ffc22d60 ffc20000 00000000 42820404
ieee1394: received packet: ffc22d60 ffc20000 00000000 42820404
ieee1394: send packet local: ffc23140 ffc2ffff f0000414
ieee1394: received packet: ffc23140 ffc2ffff f0000414
ieee1394: send packet local: ffc23160 ffc20000 00000000 80840300
ieee1394: received packet: ffc23160 ffc20000 00000000 80840300
ieee1394: send packet local: ffc23540 ffc2ffff f0000418
ieee1394: received packet: ffc23540 ffc2ffff f0000418
ieee1394: send packet local: ffc23560 ffc20000 00000000 63400003
ieee1394: received packet: ffc23560 ffc20000 00000000 63400003
ieee1394: send packet local: ffc23940 ffc2ffff f000041c
ieee1394: received packet: ffc23940 ffc2ffff f000041c
ieee1394: send packet local: ffc23960 ffc20000 00000000 02000081
ieee1394: received packet: ffc23960 ffc20000 00000000 02000081
ieee1394: send packet local: ffc23d40 ffc2ffff f0000424
ieee1394: received packet: ffc23d40 ffc2ffff f0000424
ieee1394: send packet local: ffc23d60 ffc20000 00000000 ab030600
ieee1394: received packet: ffc23d60 ffc20000 00000000 ab030600
ieee1394: send packet local: ffc24140 ffc2ffff f0000428
ieee1394: received packet: ffc24140 ffc2ffff f0000428
ieee1394: send packet local: ffc24160 ffc20000 00000000 00000000
ieee1394: received packet: ffc24160 ffc20000 00000000 00000000
ieee1394: send packet local: ffc24540 ffc2ffff f000042c
ieee1394: received packet: ffc24540 ffc2ffff f000042c
ieee1394: send packet local: ffc24560 ffc20000 00000000 00000000
ieee1394: received packet: ffc24560 ffc20000 00000000 00000000
ieee1394: send packet local: ffc24940 ffc2ffff f0000430
ieee1394: received packet: ffc24940 ffc2ffff f0000430
ieee1394: send packet local: ffc24960 ffc20000 00000000 756e694c
ieee1394: received packet: ffc24960 ffc20000 00000000 756e694c
ieee1394: send packet local: ffc24d40 ffc2ffff f0000434
ieee1394: received packet: ffc24d40 ffc2ffff f0000434
ieee1394: send packet local: ffc24d60 ffc20000 00000000 484f2078
ieee1394: received packet: ffc24d60 ffc20000 00000000 484f2078
ieee1394: send packet local: ffc25140 ffc2ffff f0000438
ieee1394: received packet: ffc25140 ffc2ffff f0000438
ieee1394: send packet local: ffc25160 ffc20000 00000000 312d4943
ieee1394: received packet: ffc25160 ffc20000 00000000 312d4943
ieee1394: send packet local: ffc25540 ffc2ffff f000043c
ieee1394: received packet: ffc25540 ffc2ffff f000043c
ieee1394: send packet local: ffc25560 ffc20000 00000000 00343933
ieee1394: received packet: ffc25560 ffc20000 00000000 00343933
ieee1394: send packet local: ffc25940 ffc2ffff f0000420
ieee1394: received packet: ffc25940 ffc2ffff f0000420
ieee1394: send packet local: ffc25960 ffc20000 00000000 c083000c
ieee1394: received packet: ffc25960 ffc20000 00000000 c083000c
ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001106001a250051]
ieee1394: send packet 100: ffff0100 ffc2ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0,
speed=0
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0
data=0x1F0000C0 ctx=0
ieee1394: send packet 100: 02800000 fd7fffff
ohci1394_0: Inserting packet for node 0-00:0000, tlabel=0, tcode=0x0,
speed=0
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 0 tcode=0xE tLabel=0x00 ack=0x11 spd=0
data=0x00000000 ctx=0
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
sbp2: $Rev: 1018 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
  Vendor: MITSUMI   Model: CR-4804TE         Rev: 2.4C
  Type:   CD-ROM                             ANSI SCSI revision: 02
ieee1394: send packet 400: ffc01510 ffc2ffff f0030000 00080000
ohci1394_0: Inserting packet for node 0-00:1023, tlabel=5, tcode=0x1,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 0 tcode=0x1 tLabel=0x05 ack=0x12 spd=0
dataLength=8 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x2
length=16 ctx=0 tlabel=18
ieee1394: received packet: ffc21520 ffc00000 00000000
ohci1394_0: IntEvent: 00000010
ohci1394_0: Got RQPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x1
length=28 ctx=0
 tlabel=18
ieee1394: received packet: ffc23910 ffc0fffe 00000000 00080000
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: send packet 400: ffc01900 ffc2ffff f0000210 0f000000
ohci1394_0: Inserting packet for node 0-00:1023, tlabel=6, tcode=0x0,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 0 tcode=0x0 tLabel=0x06 ack=0x12 spd=0
data=0x0F000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x2
length=16 ctx=0 tlabel=19
ieee1394: received packet: ffc21920 ffc00000 00000000
ieee1394: send packet 400: ffc01d00 ffc2ffff f0010004 0f000000
ohci1394_0: Inserting packet for node 0-00:1023, tlabel=7, tcode=0x0,
speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008012
ohci1394_0: Packet sent to node 0 tcode=0x0 tLabel=0x07 ack=0x12 spd=0
data=0x0F000000 ctx=0
ohci1394_0: IntEvent: 00000020
ohci1394_0: Got RSPkt interrupt status=0x00008451
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 0 ack=0x11 spd=2 tcode=0x2
length=16 ctx=0 tlabel=19
ieee1394: received packet: ffc21d20 ffc00000 00000000
arch/i386/kernel/semaphore.c:84: spin_is_locked on uninitialized
spinlock d136f8f8.
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c01bfa9a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01bfa9a>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x2de/0x44d
eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffe
esi: c03aac6b   edi: 00000000   ebp: d16f1d78   esp: d16f1d40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 776, threadinfo=d16f0000 task=d17f4e80)
Stack: c03aac5d c03ab03f 00000054 00000000 0000000a ffffffff 00000001
00000002
       ffffffff ffffffff c03ab03f c03aac40 00000046 d136f8f8 d16f1dc8
c011f8da
       c03aac40 00000400 c02d0252 d16f1de0 00000086 d132ab3c d132ab70
d16f1dc8
Call Trace:
 [<c011f8da>] printk+0x16f/0x3b7
 [<c0119774>] __wake_up_locked+0x22/0x26
 [<c01080c2>] __down+0x1b1/0x2e2
 [<c0119594>] default_wake_function+0x0/0x2e
 [<c0108677>] __down_failed+0xb/0x14
 [<f8a1abf4>] .text.lock.sbp2+0xf/0x2f [sbp2]
 [<f8a18546>] sbp2_start_device+0x205/0x3e6 [sbp2]
 [<f8a18303>] sbp2_start_ud+0x106/0x144 [sbp2]
 [<c01a7575>] sysfs_create_dir+0x34/0x6a
 [<f8a17e34>] sbp2_probe+0x4b/0x4f [sbp2]
 [<c01efbdb>] bus_match+0x3d/0x65
 [<c01efcf4>] driver_attach+0x59/0x83
 [<c01eff70>] bus_add_driver+0x91/0xa3
 [<c01f03b6>] driver_register+0x88/0x8c
 [<f8901c6e>] hpsb_register_protocol+0x17/0x28 [ieee1394]
 [<f8a1abbb>] sbp2_module_init+0xb5/0xdf [sbp2]
 [<c013d91f>] sys_init_module+0x1bb/0x318
 [<c0109db1>] sysenter_past_esp+0x52/0x71
                                                                                
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>kudzu: numerical sysctl 1 23 is obsolete.
ip_tables: (C) 2000-2002 Netfilter core team
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe000, IRQ 11, 00:50:2c:02:96:89.
eth0: Media Link On 10mbps half-duplex
Slab corruption: start=d136f8c0, expend=d136f937, problemat=d136f900
Last user: [<f88fa1fd>](free_hpsb_packet+0x2c/0x33 [ieee1394])
Data: ****************************************************************6A
******************************************************A5
Next: 71 F0 2C .FD A1 8F F8 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was
modified after freeing
Call Trace:
 [<c01470a4>] check_poison_obj+0x16c/0x1ac
 [<c0147270>] slab_destroy+0x18c/0x194
 [<c014ae50>] cache_reap+0x293/0x408
 [<c0128c47>] update_process_times+0x46/0x50
 [<c0149f9e>] reap_timer_fnc+0x0/0x29
 [<c0149fa9>] reap_timer_fnc+0xb/0x29
 [<c0120495>] profile_hook+0x21/0x25
 [<c0128dc8>] run_timer_softirq+0x15d/0x3d0
 [<c01112f5>] timer_interrupt+0x8b/0x23e
 [<c01241a1>] do_softirq+0xa1/0xa3
 [<c010be4b>] do_IRQ+0x20e/0x348
 [<c0107039>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x2a
 [<c0109f70>] common_interrupt+0x18/0x20
 [<c0107039>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x2a
 [<c0107060>] default_idle+0x27/0x2c
 [<c01070d1>] cpu_idle+0x31/0x3a
 [<c0370663>] start_kernel+0x13d/0x13f
 [<c0370401>] unknown_bootoption+0x0/0xfa
                                                                                
(END)
                                                                                
[bob@localhost bob]$ uname -r
2.6.0-test4
[bob@localhost bob]$


Hopefully some of this helps,
Bob
-- 
Bob Gill <gillb4@telusplanet.net>


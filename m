Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTDDVKd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTDDVKd (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:10:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50587 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261294AbTDDVKb (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:10:31 -0500
Date: Fri, 04 Apr 2003 13:11:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 541] New: 3c59x.c: 3c556B Laptop Hurricane not correctly detected/run 
Message-ID: <9700000.1049490718@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=541

           Summary: 3c59x.c: 3c556B Laptop Hurricane not correctly
                    detected/run
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: brassmold@yahoo.com


Distribution: Redhat 9 with module-init-tools 2.4.21-18
Hardware Environment: IBM Thinkpad T21 type 2647-5BU
Software Environment: kernel 2.5.66 (stock)
Problem Description: The laptop's integrated ethernet chipset, a 
3Com PCI 3c556B Laptop Hurricane (according to a 2.4.20 Redhat 9 kernel) does
not correctly detect under kernel 2.5.66 and as a result does not work
correctly. A DHCP fails with event errors.

Steps to reproduce:
Attempt to modprobe the card. In a successful 2.4.20 modprobe (debug=2), you see:
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 08:02.0
PCI: Sharing IRQ 11 with 08:02.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1800. Vers LK1.1.18-ac
00:01:03:86:19:b8, IRQ 11
product code 0000 rev aa.8 date 03-01-00
00:03.0: CardBus functions mapped e8101000->e097c000
Internal config register is 80600040, transceivers 0x40.
8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
MII transceiver found at address 0, status 786d.
/etc/hotplug/net.agent: invoke ifup eth0
Enabling bus-master transmits and whole-frame receives.
00:03.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
kernel: eth0: using default media MII
kernel: eth0: Initial media type MII.
kernel: eth0: MII #0 status 786d, link partner capability 41e1, info1 0010,
setting full-duplex.
kernel: eth0: vortex_up() InternalConfig 80600040.
eth0: vortex_up() irq 11 media status 8800.

In a failure, on 2.5.66 (debug=7), you see:
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1800. Vers LK1.1.19
ff:ff:ff:ff:ff:ff, IRQ 11
product code ffff rev ffff.15 date 15-31-127
00:03.0: CardBus functions mapped e8101000->e0859000
Full duplex capable
Internal config register is ffffffff, transceivers 0xffff.
1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interface.
***WARNING*** No MII transceivers found!
Enabling bus-master transmits and early receives.
00:03.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0

lspci -vx:
00:03.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus (rev 20)
        Subsystem: 3Com Corporation: Unknown device 6356
        Flags: bus master, medium devsel, latency 80, IRQ 11
        I/O ports at 1800 [size=256]
        Memory at e8101400 (32-bit, non-prefetchable) [size=128]
        Memory at e8101000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
00: b7 10 56 60 17 00 10 02 20 00 00 02 08 50 80 00
10: 01 18 00 00 00 14 10 e8 00 10 10 e8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 56 63
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 0a 0a

If other testing/info is needed, that can be done...



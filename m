Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265126AbUEVBsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbUEVBsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUEVBqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:46:35 -0400
Received: from mail.broadpark.no ([217.13.4.2]:1712 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265200AbUEVBnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:43:33 -0400
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: qla2300 at only 1 GBit on kernel 2.6.5
References: <B179AE41C1147041AA1121F44614F0B0DD0114@AVEXCH02.qlogic.org>
	<20040505174649.GA21863@ii.uib.no>
From: hklygre@online.no (=?iso-8859-1?q?H=E5vard_Lygre?=)
Date: Sat, 22 May 2004 03:43:28 +0200
In-Reply-To: <20040505174649.GA21863@ii.uib.no> (Jan-Frode Myklebust's
 message of "Wed, 5 May 2004 19:46:49 +0200")
Message-ID: <87vfiptewv.fsf@frode.valhall.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Frode Myklebust <janfrode@parallab.uib.no> writes:

> During boot it says it has no 'ROM BIOS'. Is this something I can
> install?

It probably says something about the BIOS not being enabled - you only
need the BIOS if you're going to boot from the FC-device.


> BTW: here's the log I get with 2.6.6-rc3 when loading the qla2300 with
> speed=2GHz set on the infortrend:
>
> QLogic Fibre Channel HBA Driver (f8aec000)
> qla2300 0000:01:05.0: Found an ISP2300, irq 145, iobase 0xf89b4000
> qla2300 0000:01:05.0: Configuring PCI space...
> qla2300 0000:01:05.0: Configure NVRAM parameters...
> qla2300 0000:01:05.0: Verifying loaded RISC code...
> qla2300 0000:01:05.0: Waiting for LIP to complete...
> qla2300 0000:01:05.0: Cable is unplugged...
> scsi2 : qla2xxx
> qla2300 0000:01:05.0:
>  QLogic Fibre Channel HBA Driver: 8.00.00b11-k
>   QLogic QLA2300 -
>   ISP2300: PCI (33 MHz) @ 0000:01:05.0 hdma-, host#=2, fw=3.02.26 IPX


Just as a datapoint: Vanilla Linux 2.6.6 gives me 2 Gbps with both
sides set to auto.  This is with a QLogic 2312 (as sold by IBM). I
haven't tried an earlier 2.6-series kernel on this computer.

On a side note: Your driver reports 33 MHz PCI - if this is in a
32-bit slot, isn't 2Gbps more than the bus can handle?





Also notice the discrepancy in the sizes reported for the same device:


2.6.6:
SCSI device sdc: 4294434816 512-byte hdwr sectors (1099239 MB)

and 2.4.26: 
SCSI device sdc: 4294434816 512-byte hdwr sectors (2198751 MB)

- Obviously just a simple miscalculation in sd.c



--- 2.6.6 ---

QLogic Fibre Channel HBA Driver (f895c000)
qla2300 0000:02:06.0: Found an ISP2312, irq 24, iobase 0xf8918000
qla2300 0000:02:06.0: Configuring PCI space...
qla2300 0000:02:06.0: Configure NVRAM parameters...
qla2300 0000:02:06.0: Verifying loaded RISC code...
qla2300 0000:02:06.0: LIP reset occured (f7f7).
qla2300 0000:02:06.0: Waiting for LIP to complete...
qla2300 0000:02:06.0: LIP occured (f7f7).
qla2300 0000:02:06.0: LOOP UP detected (2 Gbps).
qla2300 0000:02:06.0: Topology - (Loop), Host Loop address 0x7d
scsi2 : qla2xxx
qla2300 0000:02:06.0:
 QLogic Fibre Channel HBA Driver: 8.00.00b11-k
  QLogic QLA2340 - 133MHz PCI-X to 2Gb FC, Single Channel
  ISP2312: PCI-X (133 MHz) @ 0000:02:06.0 hdma-, host#=2, fw=3.02.26 IPX
  Vendor: nStor     Model: NexStorWahooSATA  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:02:06.0: scsi(2:0:0:0): Enabled tagged queuing, queue depth 32.
SCSI device sdc: 4294434816 512-byte hdwr sectors (1099239 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
  Vendor: nStor     Model: NexStorWahooSATA  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:02:06.0: scsi(2:0:0:1): Enabled tagged queuing, queue depth 32.
SCSI device sdd: 605675520 512-byte hdwr sectors (310106 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi2, channel 0, id 0, lun 1
  Vendor: nStor     Model: NexStorWahooSATA  Rev:
  Type:   Processor                          ANSI SCSI revision: 03
qla2300 0000:02:06.0: scsi(2:0:0:2): Enabled tagged queuing, queue depth



For reference, here's from 2.4.26 with the qlogic-driver (6.06.10, as
released in debian's qla2x00-source package)

This is when I've just created the sdd LUN, so it hasn't been
partitioned yet.


qla2x00_set_info starts at address = f8973060
qla2x00: Found  VID=1077 DID=2312 SSVID=1077 SSDID=100
scsi(2): Found a QLA2312  @ bus 2, device 0x6, irq 24, iobase 0x0000dc00
scsi(2): Allocated 4096 SRB(s).
scsi(2): Configure NVRAM parameters...
scsi(2): 32 Bit PCI Addressing Enabled.
scsi(2): Scatter/Gather entries= 32
scsi(2): Verifying loaded RISC code...
scsi(2): Verifying chip...
scsi(2): Waiting for LIP to complete...
scsi(2): LIP reset occurred.
scsi(2): LIP occurred.
scsi(2): LOOP UP detected.
scsi(2): Port database changed.
scsi(2): Topology - (Loop), Host Loop address 0x7d
scsi-qla0-adapter-node=200000e08b12bcb6\;
scsi-qla0-adapter-port=210000e08b12bcb6\;
scsi-qla0-tgt-0-di-0-port=2100000bb52088eb\;
scsi2 : QLogic QLA2312 PCI to Fibre Channel Host Adapter: bus 2 device 6 irq 24
        Firmware version:  3.02.16, Driver version 6.06.10
May 13 17:30:46 guinness kernel:
  Vendor: nStor     Model: NexStorWahooSATA  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: nStor     Model: NexStorWahooSATA  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: nStor     Model: NexStorWahooSATA  Rev:
  Type:   Processor                          ANSI SCSI revision: 03
scsi(2:0:0:0): Enabled tagged queuing, queue depth 32.
scsi(2:0:0:1): Enabled tagged queuing, queue depth 32.
scsi(2:0:0:2): Enabled tagged queuing, queue depth 32.
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi2, channel 0, id 0, lun 1
Attached scsi generic sg5 at scsi2, channel 0, id 0, lun 2,  type 3
SCSI device sdc: 4294434816 512-byte hdwr sectors (2198751 MB)
 sdc: sdc1
SCSI device sdd: 605675520 512-byte hdwr sectors (310106 MB)
 sdd: unknown partition table




-- 
Håvard Lygre, hklygre@online.no
BLUG: http://blug.linux.no/   RFC1149: http://blug.linux.no/rfc1149/

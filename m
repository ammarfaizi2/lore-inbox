Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTFBTVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTFBTVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:21:24 -0400
Received: from gw.netgem.com ([195.68.2.34]:65033 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S261823AbTFBTVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:21:22 -0400
Subject: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
From: Jocelyn Mayer <jma@netgem.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054582582.4967.48.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Jun 2003 21:36:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... at least for PPC targets.
There was a set of patches applied for the 2.4.21-rc2 kernel
(some seem _very_ strange, maybe endianness issues...)
that makes sbp2 fail to recognize my external firewire drives.
The only way I have for now to make things work is to come back
to the 2.4.21-rc1 version, which work correctly for my Mac
and my PC (VIA Chipset & Firewire chip).
On the Mac (Ibook), I can see my disks in /proc/bus/ieee1394/devices:

Node[01:1023]  GUID[000393fffeab0e76]:
  Vendor ID: `Linux OHCI-1394' [0x000000]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(8)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [01:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : yes
Node[00:1023]  GUID[00d04b0ce0900195]:
  Vendor ID: `Oxford  ' [0x00d04b]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Oxford   [00d04b] / 911G [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8

but not in /proc/scsi/scsi
Here's the output of /proc/scsi/sbp2/1 (with the working driver):
IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 878 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S400
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 64
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: yes

I may do more tests to localize the bug, if I only knew which ones I
should do...


/proc/cpuinfo:
cpu             : 750FX
temperature     : 2 C (uncalibrated)
clock           : 700MHz
revision        : 1.18 (pvr 7000 0112)
bogomips        : 1389.36
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld

/proc/pci:
PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Computer Inc. UniNorth/Pangea AGP (rev 0).
      Master Capable.  Latency=16.  
  Bus 16, device  11, function  0:
    Host bridge: Apple Computer Inc. UniNorth/Pangea PCI (rev 0).
      Master Capable.  Latency=16.  
  Bus 16, device  23, function  0:
    Class ff00: Apple Computer Inc. KeyLargo/Pangea Mac I/O (rev 0).
      Master Capable.  Latency=16.  
      Non-prefetchable 32 bit memory at 0x80000000 [0x8007ffff].


-- 
Jocelyn Mayer <jma@netgem.com>


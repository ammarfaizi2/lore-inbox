Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUFCEmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUFCEmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUFCEmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:42:19 -0400
Received: from dialpool1-3.dial.tijd.com ([62.112.10.3]:10880 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S265500AbUFCEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:42:16 -0400
From: Jan De Luyck <lkml@kcore.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [2.6.6] ICH5 SATA problems
Date: Thu, 3 Jun 2004 06:42:16 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030642.16890.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

A friend of mine is trying to get both SATA and PATA working together on his Siemens box. The bios has a bunch of settings
concering sata/pata, being:
- SATA Standard (which is bootable by the bios). When this is selected, another setting is available
	* Sata 1/2 only
	* sata 1/2 + pata 3/4
	* pata 1/2 + sata 1/2

Unfortunately, linux doesn't seem to see this controller then. lspci output:

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 200] (rev a3)
0000:03:07.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev 0b)
0000:03:08.0 Ethernet controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) integrated LAN Controller (rev 02)
0000:03:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:03:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

Another option is 'OS Only' for SATA, after which Linux is able to see the controller:

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
==> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) <==
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 200] (rev a3)
0000:03:07.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev 0b)
0000:03:08.0 Ethernet controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) integrated LAN Controller (rev 02)
0000:03:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:03:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

Is there a way to get both to work? Or will the box boot with the 'OS Only' selection? and only SATA disks in it?
The standard IDE controller is needed for some ATAPI devices.

Thanks.

-- 
"Speed is subsittute fo accurancy."

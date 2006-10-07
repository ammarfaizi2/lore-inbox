Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbWJGH1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWJGH1L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 03:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbWJGH1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 03:27:11 -0400
Received: from www.tammen.de ([62.206.99.154]:59311 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S932759AbWJGH1K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 03:27:10 -0400
From: Heinz Ulrich Stille <hus@design-d.de>
To: linux-kernel@vger.kernel.org
Subject: it821x eats CPU?
Date: Sat, 7 Oct 2006 09:27:13 +0200
User-Agent: KMail/1.9.4
X-Face: 4mP]9aFSZN&|I]TOVXU]ip[QEBP^RNKxLkj?@0A{KRjs9>QuA{bW
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610070927.13713.hus@design-d.de>
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Sat Oct  7 09:27:08 2006
X-DSPAM-Confidence: 0.8517
X-DSPAM-Improbability: 1 in 575 chance of being spam
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 452756cc46252227431997
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

All I wanted was a cheap IDE controller to attach a spool disk for
my backups. What I got was a RAID controller with the it8212 chip.
Ok, I thought, just ignore that. The module was loaded and the disk
mounted without a hitch.

But as soon as the backup started writing to the disk, CPU usage
went up to about 100%, a lot (rough estimage 50%) of that "system".
Strange enough in itself, but it did not only affect the one process
actually accessing that disk, but apparently all processes doing I/O
(or perhaps doing I/O to any IDE device?). Most notably one ogg123
(feeding on hold music to our pbx), which usually uses about 5% CPU,
went up to 25%...
Even if the driver is strange, what takes up the "user" CPU cycles?

Looking through the logs I notices that it821x was in "smart" mode,
so I restarted the system with "noraid=1" to get into "pass through".
Now everything is back to normal. A large dd did about 40MB/s without
disturbing other processes.

Wasn't smart mode the one supposed to be the one reducing CPU load?

BTW, my hardware setup (lspci):
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio Processing Unit (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8129 (rev 10)
01:07.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
01:08.0 Multimedia controller: Philips Semiconductors TriMedia TM-1300 (rev 82)
01:09.0 RAID bus controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
01:0a.0 RAID bus controller: <pci_lookup_name: buffer too small> (rev 13)
01:0b.0 Mass storage controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
02:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

The one with a name to long for the buffer is the it8212.
Root partition is on a raid 1 spanning hda and hdc, the spool disk is hde.

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400473 / Fax: +49-541-9400450
design_d gmbh / Wilhelmstr. 16 / 49076 Osnabrück / www.design-d.de


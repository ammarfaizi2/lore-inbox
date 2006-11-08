Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423750AbWKHVGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423750AbWKHVGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423784AbWKHVGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:06:44 -0500
Received: from dexter.tse.gov.br ([200.252.157.99]:38537 "EHLO
	dexter.tse.gov.br") by vger.kernel.org with ESMTP id S1423750AbWKHVGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:06:43 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	for Linux Server. For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Message-ID: <455254B8.4000704@tse.gov.br>
Date: Wed, 08 Nov 2006 19:05:44 -0300
From: Saulo <slima@tse.gov.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE cs5530 hda: lost interrupt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

any help is wellcome...

--------------------
CPU: NSC Geode(TM) Integrated Processor by National Semi stepping 02
...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CS5530: ide CONTROLLER AT pci SLOT 0000:00:12.2
CS5530: chipset revision 0
CS5530: not 100% native mode: will probe irqs later
PCI: Enabling bus mastering for device 0000:00:12.2
PCI: Setting latency timer of device 0000:00:12.2 to 64
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: CF 32MB, CFA DISK drive
hda: IRQ probe failed (0xfeba)    >>> I think my problem may start here, 
but when I fix to IRQ 14 in try_to_identify() to hda the problem persist
ide0 at 0x1f0-0x1f7,0x3f6 on irq14
hdc: Hitachi CV 5.1.1, CFA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15 (serialized with ide0)
hda: max request size: 128KiB
hda: 62976 sectors (32MB) w/1KiB Cache, CHS=492/4/32
 hda:<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
...
 hd1
hdc: max request size: 128KiB
hdc: 31488 sectors (16 MB) w/1KiB Cache, CHS=246/4/32
 hdc: hdc1
USB Universal Host Controller Interface driver v3.0
...
INIT: ...
---------------
when I look in my /proc/interrupts I see something strange

0:      929785    XT-PIC  timer
1:         128    XT-PIC  I8042
2:           0    XT-PIC  cascade
6:           3    XT-PIC  floppy
8:           0    XT-PIC  rtc
14:          2    XT-PIC  ide0    >>> just 2 interrupts
15:       2964    XT-PIC  ide1
NMI:         0
ERR:         0
  
pci devices (lspci)

00:00.0 Class 0600: 1078:0001 - Host bridge: Cyrix Corporation:PCI Master
00:12.0 Class 0601: 1078:0100 - ISA bridge: Cyrix Corporation:5530 
Legacy [Kahlua] (rev 30)
00:12.1 Class 0680: 1078:0101 - POWER interface: Cyrix Corporation:5530 
SMI [Kahlua]
00:12.2 Class 0101: 1078:0102 - IDE interface: Cyrix Corporation:5530 
IDE [Kahlua]
00:12.3 Class 0401: 1078:0103 - Multimedia audio controller: Cyrix 
Corporation:5530 Audio [Kahlua]
00:12.4 Class 0300: 1078:0104 - VGA compatible controller: Cyrix 
Corporation:5530 Video [Kahlua]
00:13.0 Class 0c03: 0e11:a0f8 - USB open host controller: Compaq 
Computer Corporation: ZFMicro Chipset USB (rev 06)

this is my machine configuration:
- GEODE GX1 BGA 200MHZ
- 64MB
- CS5530 with 2 controllers IDE master primary CompactFlash and master 
secondary, without slave connectors.

I tried all of present configurations from ide.txt and all that I found 
in the internet about this, and ever I get lots of <hda: lost interrupt>.
The incredible is that hdc work fine, and I undertand why.

Yes I tried all
    - ide=nodma
    - hda=noprobe
    - set default values to ide0
    - ide0=serialize ide1=serialize
    - disabling acpi and apic
    - chage CompactFlash
    - checking

thank´s

-- 
[]´s Saulo Alessandre



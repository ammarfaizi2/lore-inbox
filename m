Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTFGIlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTFGIlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 04:41:42 -0400
Received: from pusa.informat.uv.es ([147.156.10.98]:45532 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S262805AbTFGIlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 04:41:35 -0400
Date: Sat, 7 Jun 2003 10:55:08 +0200
To: linux-kernel@vger.kernel.org
Subject: Lookups caused by sis5513?
Message-ID: <20030607085508.GA31632@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I'm using 2.4.20 and 2.5.70 with a SIS735 chipset (an ECS K7S5A board). 
I don't have  problems with 2.4.20 but with 2.5.70 the system freezes
many times. I tested enabling/disabling acpi and apic, but I found 
no differences.

I suspect it's caused by driver sis5513. Just one note on it:

the IDE activy led is mostly "on" with a 2.5.x kernel from the boot, 
while in 2.4 the kernel just lights the led when there is activity. 

This happens from every 2.5.x version I tried, I think from 2.5.58.

In 2.5.x it may "sometimes" turn off the light after IDE activity, but it 
sets on again when there is new activity.


hdparm -i and /proc/ide/sis have no differencies between 2.4.20 and 2.5.70

agapito:~# diff hdparm.hda.2.*
agapito:~# diff hdparm.hdc.2.*
agapito:~# diff sis.2.*

I attached this info at the end of this mail

what can I do to make sure it's a fault in this driver?
what can I do in order to help debugging it?

Thanks in advance

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---


agapito:~# hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD800JB-00CRA1, FwRev=17.07W17, SerialNo=WD-WMA8E4519860
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5

agapito:~# hdparm -i /dev/hdc

/dev/hdc:

 Model=Polaroid BurnMAX48, FwRev=VER 482E, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

agapito:~# cat /proc/ide/sis

SiS 5513 Ultra 100 chipset
--------------- Primary Channel ---------------- Secondary Channel -------------
Channel Status: On                               On
Operation Mode: Compatible                       Compatible
Cable Type:     80 pins                          40 pins
Prefetch Count: 512                              512
Drive 0:        Postwrite Enabled                Postwrite Disabled
                Prefetch  Enabled                Prefetch  Disabled
                UDMA Enabled                     UDMA Enabled
                UDMA Cycle Time    2 CLK         UDMA Cycle Time    6 CLK
                Data Active Time   3 PCICLK      Data Active Time   3 PCICLK
                Data Recovery Time 1 PCICLK      Data Recovery Time 1 PCICLK
Drive 1:        Postwrite Disabled               Postwrite Disabled
                Prefetch  Disabled               Prefetch  Disabled
                UDMA Disabled                    UDMA Disabled
                UDMA Cycle Time    Reserved      UDMA Cycle Time    Reserved
                Data Active Time   8 PCICLK      Data Active Time   8 PCICLK
                Data Recovery Time 12 PCICLK     Data Recovery Time 12 PCICLK

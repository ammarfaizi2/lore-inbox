Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVDBQfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVDBQfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDBQfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 11:35:09 -0500
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:5866
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S261640AbVDBQe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 11:34:29 -0500
Subject: Problem mounting dvd if the drive spin down
From: Nate Grey <nate@paranoici.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 02 Apr 2005 18:33:56 +0200
Message-Id: <1112459636.15372.18.camel@maggot.MetalZone.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys, this is my first post in this list, I'm not a subscriner so
please CC me for reply and comments. Thank you.


I've got an Acer Aspire 1601LC laptop and I get strange issue when
mounting dvd (I cannot say the time 'cause firstly I thought to bad
dvd).
If I close the try and then mount the dvd everything is ok, but if the
drive stops, for example if I insert the dvd and go on with reading my
mail and try to access again the dvd this hangs up.

The drive is a Matshita as dmesg say:

hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

Example:
I put the dvd into the drive, wait some time... the drive spin down
$ mount /mnt/cdrom

I got this in /var/log/messages
Apr  2 18:11:58 maggot kernel: hdc: DMA disabled

and dmesg:
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x40 { LastFailedSense=0x04 }
ide: failed opcode was: unknown

I'm using 2.6.11 kernel, but 2.6.10 wasn't better.
I notice that if I run

$ hdparm -Y /dec/hdc

output:/dev/hdc:
 issuing sleep command
 HDIO_DRIVE_CMD(sleep) failed: Input/output error

the drive seems to wake up and I can run mount without problems.

This is the output from hdparm -i:/dev/hdc:

 Model=UJDA740 DVD/CDRW, FwRev=1.00, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 3: 

 * signifies the current active mode


Is there any solution to this problem?

Thank in advance, and go on this way.




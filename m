Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVAYWzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVAYWzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVAYWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:55:28 -0500
Received: from morgana.xs4all.nl ([213.84.43.3]:37384 "EHLO Waltz.Morgana.NET")
	by vger.kernel.org with ESMTP id S262223AbVAYWwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:52:18 -0500
Subject: Drive missing only with LVM kernel
From: Jasper Koolhaas <jasper@Morgana.NET>
Reply-To: jasper@Morgana.NET
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Morgana
Date: Tue, 25 Jan 2005 21:30:09 +0100
Message-Id: <1106685009.8968.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

I run a Linux 2.6.9 kernel with RAID and LVM on a combined total of six
ATA and SATA harddisks. While booting /dev/hdg is recognised and even
used by RAID:

# dmesg |grep hdg
    ide3: BM-DMA at 0xdf98-0xdf9f, BIOS settings: hdg:pio, hdh:pio
hdg: WDC WD2000JB-00EVA0, ATA DISK drive
hdg: max request size: 1024KiB
hdg: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
hdg: cache flushes supported
md:  adding hdg1 ...
md: bind<hdg1>
md: running: <sdb1><sda1><hdg1><hdc1><hda1>
raid5: device hdg1 operational as raid disk 2
 disk 2, o:1, dev:hdg1

As soon as the system had booted hdg has completely vanished, even in
single user mode:

# ls /dev/hd* /dev/sd*
/dev/hda   /dev/hda3  /dev/hdc1  /dev/hde   /dev/hde3  /dev/sda2  /dev/sdb1
/dev/hda1  /dev/hda4  /dev/hdc2  /dev/hde1  /dev/sda   /dev/sda3  /dev/sdb2
/dev/hda2  /dev/hdc   /dev/hdc3  /dev/hde2  /dev/sda1  /dev/sdb   /dev/sdb3

But the RAID is working just fine:

# cat /proc/mdstat
Personalities : [raid5]
md0 : active raid5 sdb1[4] sda1[3] hdg1[2] hdc1[1] hda1[0]
      97674240 blocks level 5, 256k chunk, algorithm 2 [5/5] [UUUUU]

When I boot this same system with the same kernel without LVM appears
just fine. As soon as I compile LVM in (even as not-yet-activated
module) hdg is gone after booting.

This beheavure also happens if I add this particular or a different
drive to a different controller like /dev/hdb

My full kernel config can be found at:
http://www.morgana.net/~jasper/config-2.6.9

Any ideas how I can use LVM and this 6th drive?

hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63,
UDMA(100)
hdc: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63,
UDMA(100)
hde: 398297088 sectors (203928 MB) w/8192KiB Cache, CHS=24792/255/63,
UDMA(100)
hdg: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata2: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48

Kind regards, Jasper.






Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWG1UCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWG1UCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWG1UCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:02:54 -0400
Received: from zakalwe.fi ([80.83.5.154]:15780 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1161258AbWG1UCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:02:53 -0400
Date: Fri, 28 Jul 2006 23:02:50 +0300
From: Heikki Orsila <shd@zakalwe.fi>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with irqbalance
Message-ID: <20060728200250.GA12840@zakalwe.fi>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <20060728121210.GA8375@tentacle.sectorb.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060728121210.GA8375@tentacle.sectorb.msk.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 04:12:15PM +0400, Vladimir B. Savkin wrote:
> Hello! 
> Here goes my first report on the issue.
> 
> On Wed, Feb 01, 2006 at 07:28:00PM +0300, Vladimir B. Savkin wrote:
> > My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
> > but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
> > gaves error messages some minutes after boot.
> > 
> > The messages are as following:
> >   ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
> > where XX gets different values from time to time, 0x25 mostly.
> > I/O to this controller halts after that.
> > 
> > Attached are boot dmesg log and lspci output.
> > 
> 
> I just checked - the problem persists with 2.6.17.7

This is ASUS K8V SE Deluxe on amd64 with SiI 3114 SATA controller. I 
upgraded from Ubuntu 6.06 kernel 2.6.15-23 to vanilla 2.6.17.4 and got 
following errors shortly after the boot:

Jul 26 00:35:39 cheradenine kernel: ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul 26 00:35:39 cheradenine kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Jul 26 00:35:39 cheradenine kernel: ata1: error=0x04 { DriveStatusError }

Linux cheradenine 2.6.17.4 #2 SMP Wed Jul 19 16:33:24 EEST 2006 x86_64 GNU/Linux
 
Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   079
Modules Loaded         

> libata version 1.20 loaded.
> sata_via 0000:00:0f.0: version 1.1
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
> sata_via 0000:00:0f.0: routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 16
> ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 16
> ata1: SATA link down (SStatus 0)
> scsi0 : sata_via

Mine is "sata_sil 0000:00:0d.0: version 0.9".

0000:00:0d.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)

If these are symptoms of the same bug, it is not sata_via specific.

Heikki Orsila
heikki.orsila@iki.fi

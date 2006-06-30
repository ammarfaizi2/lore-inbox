Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWF3HJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWF3HJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWF3HJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:09:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:47020 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932083AbWF3HJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:09:46 -0400
Message-ID: <44A4CE21.30009@tw.ibm.com>
Date: Fri, 30 Jun 2006 15:09:21 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr>
In-Reply-To: <449E5445.60008@free.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Jeff Garzik wrote:
> 
>> Data point #3 (or #0...):
>>
>> This appears to be a _device_ that sends its interrupt early.

Hi,

I've tested the 4KUS CDR-6S48 drive + Promise pdc20275 controller
with current libata upstream (to be 2.6.18. I guess current upstream doesn't
have the via-pata-controller-xfer-fixes.patch). However, cannot reproduce
the early interrupt problem on my machine.

>>
>> If that is the case, the device may appear on any controller, not just
>> VIA, and we would have to handle it globally via a device special-case
>> in libata-core.
>>
> 
> For the record, the cdrom writer that need this quirk on pata via, works
> on pata sil680.
> But 3 microsecond is very short, and the problem could be hidden by the
> controller, or other stuffs.
> 
> 

If it is the problem of the specific ATAPI device, all controllers
should be affected, not only VIA. So, strange not seeing the problem on
Promise.

Could you please test the current libata-upstream tree and
turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.

If possible, could you also submit the libata log related to the
early/lost irq.

(Heard about the ATAPI early interrupt problem, but never had chance to see
how libata behaves with such device. Really curious about this problem.)

Thanks,

Albert
---
boot dmesg of the CDR-6S48 on my box.
xfer mode set to UDMA/33 without problem.

pata_pdc2027x 0000:02:05.0: version 0.74-ac3
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
pata_pdc2027x 0000:02:05.0: PLL input clock 16740 kHz
ata3: PATA max UDMA/133 cmd 0xE09E17C0 ctl 0xE09E1FDA bmdma 0xE09E1000 irq 10
ata4: PATA max UDMA/133 cmd 0xE09E15C0 ctl 0xE09E1DDA bmdma 0xE09E1008 irq 10
scsi2 : pata_pdc2027x
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/33
scsi3 : pata_pdc2027x
ata4.00: configured for UDMA/33
  Vendor: LITE-ON   Model: CD-RW SOHR-5238S  Rev: 4S07
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4163B  Rev: A101
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: CD-RW     Model: CDR-6S48          Rev: 2SG1
  Type:   CD-ROM                             ANSI SCSI revision: 05
sr0: scsi3-mmc drive: 93x/52x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
sr 2:0:1:0: Attached scsi CD-ROM sr1
sr2: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
sr 3:0:0:0: Attached scsi CD-ROM sr2





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTJRPln (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTJRPln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:41:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26834 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261680AbTJRPll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:41:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Date: Sat, 18 Oct 2003 17:45:41 +0200
User-Agent: KMail/1.5.4
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031018130234.GA28095@louise.pinerecords.com>
In-Reply-To: <20031018130234.GA28095@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181745.41768.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We depend on BIOS hints for ServerWorks and BIOS is not enabling DMA.
AFAIR we can't force DMA in this case because there are broken hardware
designs, so current behavior is safe.  However more research is needed...

thanks,
--bartlomiej

On Saturday 18 of October 2003 15:02, Tomas Szepe wrote:
> On Oct-16 2003, Thu, 23:44 +0200
>
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > I wonder if this patch fixes problems (reported back in 2.4.21 days)
> > with CSB5 IDE and Compaq Proliant machines.  Please test it if you can.
>
> Still, there's one prevailing problem:
>
> Compaq Proliant ML350 G3
> ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
> WDC WD1200JB-00CRA1 as hdb
>
> No autodma on boot, even w/ 2.4.23-pre7 + the pio autotuning fix:
>
> Linux version 2.4.23-pre7 (kala@ns) (gcc version 2.95.3 20010315 (release))
> #1 SMP Sat Oct 18 14:40:16 CEST 2003 Kernel command line: root=/dev/md0
> vga=normal
> ...
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SvrWks CSB5: IDE controller at PCI slot 00:0f.1
> SvrWks CSB5: chipset revision 147
> SvrWks CSB5: not 100% native mode: will probe irqs later
> SvrWks CSB5: simplex device: DMA forced
>     ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
> SvrWks CSB5: simplex device: DMA forced
>     ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
> hda: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive
> hdb: WDC WD1200JB-00CRA1, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdb: attached ide-disk driver.
> hdb: host protected area => 1
> hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63
> hda: attached ide-cdrom driver.
> hda: ATAPI 48X CD-ROM drive, 128kB Cache
> ...
>
> devel:~# hdparm -Iv /dev/hdb|grep -a dma
>  using_dma    =  0 (off)
>         DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
>
> After issuing "/usr/sbin/hdparm -d1 -Xudma5 /dev/hdb" all's running nicely,
> no errors whatsoever.
>
> devel:/etc/rc.d# hdparm -Iv /dev/hdb|grep -a dma
>  using_dma    =  1 (on)
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5


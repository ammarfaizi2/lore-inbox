Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTIZOKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTIZOKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:10:10 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:49933 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262240AbTIZOKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:10:04 -0400
From: Michael Frank <mhf@linuxmail.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Fri, 26 Sep 2003 22:08:30 +0800
User-Agent: KMail/1.5.2
References: <yw1x7k3vlokf.fsf@users.sourceforge.net>
In-Reply-To: <yw1x7k3vlokf.fsf@users.sourceforge.net>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309262208.30582.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SIS5513: IDE controller at PCI slot 0000:00:02.5
> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
>     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
> hda: IC25N040ATMR04-0, ATA DISK drive

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
PCI: Found IRQ 10 for device 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L090AVV207-0, ATA DISK drive


Jul 27 04:22:26 mhfl4 kernel: hda: lost interrupt
Jul 27 04:23:15 mhfl4 kernel: hda: dma_timer_expiry: dma status == 0x24
Jul 27 04:23:25 mhfl4 kernel: hda: DMA interrupt recovery

Running mostly 2.4 on this board, not using ACPI, Got similar problems 
with 2.4 and when running occasionally 2.6, but not as bad except with 
2.4.22-pre7. 

Suspect chipset related issue which should be looked into.

You could try setting udma mode with hdparm -Xudma[12345] and see
if it helps.  

I use from a script on startup 

sync
hdparm -S 255 -K1 -c3 -Xudma5 /dev/hda.

Note: IME, hdparm should not be used when there is substantial 
disk activity.

Regards
Michael



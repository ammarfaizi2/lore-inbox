Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266920AbUBFV3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUBFV3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:29:19 -0500
Received: from libra.i-cable.com ([203.83.111.73]:63739 "HELO
	libra.i-cable.com") by vger.kernel.org with SMTP id S266936AbUBFV2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:28:44 -0500
Message-ID: <001101c3ecf8$b0f50cc0$b8560a3d@kyle>
From: "Kyle" <kyle@southa.com>
To: "Bas Mevissen" <ml@basmevissen.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Sat, 7 Feb 2004 05:32:15 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I tried to boot with redhat kernel 2.4.20-24.9smp, much better result:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.14 seconds =914.29 MB/sec
 Timing buffered disk reads:  64 MB in  1.67 seconds = 38.32 MB/sec

Really strange that /dev/hdc is even faster!
/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.13 seconds =984.62 MB/sec
 Timing buffered disk reads:  64 MB in  1.17 seconds = 54.70 MB/sec

I ran hdparm 5 times at both harddisk and take the fastest result.
/dev/hda and /dev/hdc are both WD 250GB / 8M, same model.

at kernel 2.6, I got same performance for  /dev/hda and /dev/hdc, around
~28MB/sec. 50%-100% slower then kernel 2.4

/proc/interrupt:

           CPU0       CPU1
  0:    8014632          0    IO-APIC-edge  timer
  1:       2273          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:     167888          0    IO-APIC-edge  ide0
 15:     199399          0    IO-APIC-edge  ide1
 20:    2186070          0   IO-APIC-level  eth1
NMI:          0          0
LOC:    8014888    8014887
ERR:          0
MIS:          0

I tried to update my mobo BIOS (Intel D865GLC), remove one of the NIC (I
have two), disable serial, parallel, USB etc just leave IDE and built-in
display, no help. I have NO IDE cdrom and floppy, only 2 harddisk, 1 CPU, 4
x 512M DDR and a mobo at my machine.

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

Kyle



----- Original Message ----- 
From: "Bas Mevissen" <ml@basmevissen.nl>
To: "Kyle" <kyle@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, February 06, 2004 6:10 PM
Subject: Re: ICH5 with 2.6.1 very slow


> Kyle wrote:
>
> > hdparm /dev/hda
> > /dev/hda:
> > multcount = 16 (on)
> > IO_support = 1 (32-bit)
> > unmaskirq = 1 (on)
> > using_dma = 1 (on)
> > keepsettings = 0 (off)
> > readonly = 0 (off)
> > readahead = 256 (on)
> > geometry = 30401/255/63, sectors = 488397168, start = 0
> >
> > tried with hdparm -a8192 /dev/hda, not much different
> > /dev/hdc same as /dev/hda
> >
>
> Looks fine. That's strange. Maybe reboot the system and check
> /proc/interrupts to see if none of them is excessive.
>
> What's your .config? Try with as less as possible IDE stuff enabled.
>
> Bas.
>
>
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSHHJBY>; Thu, 8 Aug 2002 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSHHJBX>; Thu, 8 Aug 2002 05:01:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53950 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317398AbSHHJBW>;
	Thu, 8 Aug 2002 05:01:22 -0400
Date: Thu, 8 Aug 2002 11:03:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: Andries.Brouwer@cwi.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, (not IDE)] partition table (not) corruption?
In-Reply-To: <3D522F0E.8040404@evision.ag>
Message-ID: <Pine.LNX.4.44.0208081057150.2542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Marcin Dalecki wrote:

> If you look at the boot messages from a kernel:
> 
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>   hda: 78140160 sectors, CHS=77520/16/63, UDMA(33)
>   hda: hda1 hda4
> 
> You can actually see the CHS info field.

okay, here are the 2.4.18(-ish) and 2.5.30 CHS fields:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8418816 sectors (4310 MB) w/80KiB Cache, CHS=524/255/63, UDMA(33)
hdc: 40132503 sectors (20548 MB) w/1900KiB Cache, CHS=39813/16/63, UDMA(33)
hdb: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache

hda: QUANTUM FIREBALL SE4.3A, DISK drive
hdb: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
hdc: QUANTUM FIREBALLP LM20.5, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 8418816 sectors w/80KiB Cache, CHS=14848/9/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 >
 hdc: 40132503 sectors w/1900KiB Cache, CHS=39813/16/63, UDMA(33)
 hdc: hdc1
hdb: Disabling (U)DMA for RICOH CD-R/RW MP7083A
hdb: DMA disabled
hdb: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache

i have the bootlogs of this system back to 2.5.25 only, which also shows
the wrong(?) CHS:

Linux version 2.5.25 (mingo@mars) (gcc version 2.96 20000731 (Red Hat Linux 7.2
2.96-101.9)) #3 SMP Tue Jul 9 21:12:18 CEST 2002

hda: QUANTUM FIREBALL SE4.3A, DISK drive
hdb: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
hdc: QUANTUM FIREBALLP LM20.5, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 8418816 sectors w/80KiB Cache, CHS=14848/9/63
 hda: [PTBL] [524/255/63] hda1 hda2 < hda5 hda6 >
 hdc: 40132503 sectors w/1900KiB Cache, CHS=39813/16/63
 hdc: hdc1

	Ingo


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBQA2x>; Fri, 16 Feb 2001 19:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130274AbRBQA2n>; Fri, 16 Feb 2001 19:28:43 -0500
Received: from msgrouter1.onetel.net.uk ([212.67.96.140]:55659 "EHLO
	msgrouter1.onetel.net.uk") by vger.kernel.org with ESMTP
	id <S129193AbRBQA2g>; Fri, 16 Feb 2001 19:28:36 -0500
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramieleavitt@onetel.net.uk>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1-ac14 won't boot
Date: Sat, 17 Feb 2001 00:34:15 -0000
Message-ID: <JKEGJJAJPOLNIFPAEDHLEEJJCHAA.laramieleavitt@onetel.net.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <3A8D5F93.F4E78DBE@cypress.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> 2.4.1-ac8 worked great, 2.4.1-ac13 and ac14 oops
> in IDE initialisation. All 3 have ide.2.4.1-p8.all.01172001.patch
> applied too.  I'll try it without the ide patch today.
>
>
> 	-Thomas
>
> ---kernel messages-----------
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> AMD7409: IDE controller on PCI bus 00 dev 39
>        : chipset revision 3
>        : not 100% native mode: will probe irqs later
> AMD7409: disabling single-word DMA support (revision < C4)
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IBM-DTTA-351010, ATA DISK drive
> hdb: IBM-DTTA-351010, ATA DISK drive
> hdc: WDC AC24300L,  ATA DISK drive
> hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: status error: status=0x50 { DriveReady SeekComplete }
> hda: no DRQ after issuing WRITE
> hda:19807200 sectors (10141 MB) w/466KiB Cache, CHS=19650/16/63,
> UDMA(33)
> hda:ide_intr: hwgroup->busy was 0 ??
> Inable to handle kernel NULL pointer dereference at virtual address
> 00000040
>  printing eip:
> c0192e86
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0192e86>]
> EFLAGS: 00010046
> eax: 00000000   ebx: c02cf820   ecx: c1461098   edx: 000001f7
> esi: c02cf820   edi: 00000282   ebp: c02cf7e0   esp: c145fe28
> ds: 0018   es: 0018   ss: 0018
> Process swaper (pid:1, stackpage=c145f000)
> stack: c02cf820 c1461080 c018fce0 c02cf820 c0192e70 c1449440 04000001
> 0000000e
>        c145fe90 c010a349 0000000e c1461080 c145fe90 c145fe90 0000000e
> c029fc80
>        c1449440 c010a4b8 0000000e c145fe90 c1449440 00000380 00000212
> c029fc80
> Call Trace: [<c018fce0>] [<c0192e70>] [<c010a349>] [<c010a4b8>]
> [<c0109120>] [<c010a444>] [<c0192ba6>]
>        [<c01949b3>] [<c0194c3a>] [<c0194ce4>] [<c0192353>] [<c019e56d>]
> [<c0105000>] [<c01070e9>] [<c0105000>]
>        [<c01075e6>] [<c01070e0>]
>
> Code: 8b 58 40 ec e6 80 0f b6 c8 fb 89 c8 24 c9 3c 40 74 18 0f b6
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> spurious 8259A interrupt: IRQ7.

I have had a similar oops on my MSI-694D, but not always.  I think that mine
happens in the Promise FastTrack Lite driver (pdc...).  But since I have a
dual processor, the oops is interlaced with the other processor's boot
messages.  About the only thing that I can get from it is the following.

(painstakingly copied by hand.  I know, not run through ksymoops...)

E Flags 00010246
esp: c123ffb0
Call Trace: [<c010724e>][<c01e5d5>][<c018405a>]

I think that the change that caused mine is changing the Promise
driver to do a mdelay where it was doing that odd stuff.

But it boots more often than not, so I have ignored it.
Laramie


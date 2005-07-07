Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVGGO2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVGGO2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGGNtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:49:02 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:50276 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261550AbVGGNsO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:48:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kQMnJGz0djMRY0e4O+p4Qbnv5U0aKGhGkUi6GSOc0KyDEj+eEJW18Fb4HquA2p2EcxB82aTEf6wZHgIYnDeqBGzOGGZU2CbBLeb/BgeVp0ZRDWO6TOaNcKrT83GXX88g5pCS8HVHOxpW5/FAYW8fmiBSXvj7K9RNE5+hsSTXk84=
Message-ID: <58cb370e05070706485276333@mail.gmail.com>
Date: Thu, 7 Jul 2005 15:48:13 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [git patches] IDE update
Cc: Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <42CC4589.8060509@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200507042033.XAA19724@raad.intranet> <42C9C56D.7040701@tomt.net>
	 <42CA5A84.1060005@rainbow-software.org>
	 <20050705101414.GB18504@suse.de>
	 <42CA5EAD.7070005@rainbow-software.org> <42CC4589.8060509@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Ondrej Zary wrote:
> > Jens Axboe wrote:
> >
> >> On Tue, Jul 05 2005, Ondrej Zary wrote:
> >>
> >>> André Tomt wrote:
> >>>
> >>>> Al Boldi wrote:
> >>>>
> >>>>
> >>>>> Bartlomiej Zolnierkiewicz wrote: {
> >>>>>
> >>>>>
> >>>>>>>> On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> >>>>>>>> Hdparm -tT gives 38mb/s in 2.4.31
> >>>>>>>> Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> >>>>>>>>
> >>>>>>>> Hdparm -tT gives 28mb/s in 2.6.12
> >>>>>>>> Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> >>>>
> >>>>
> >>>>
> >>>> The "hdparm doesn't get as high scores as in 2.4" is a old discussed
> >>>> to death "problem" on LKML. So far nobody has been able to show it
> >>>> affects anything  but that pretty useless quasi-benchmark.
> >>>>
> >>>
> >>> No, it's not a problem with hdparm. hdparm only shows that there is
> >>> _really_ a problem:
> >>>
> >>> 2.6.12
> >>> root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
> >>> count=1048576
> >>> 1048576+0 records in
> >>> 1048576+0 records out
> >>>
> >>> real    0m32.339s
> >>> user    0m1.500s
> >>> sys     0m14.560s
> >>>
> >>> 2.4.26
> >>> root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
> >>> count=1048576
> >>> 1048576+0 records in
> >>> 1048576+0 records out
> >>>
> >>> real    0m23.858s
> >>> user    0m1.750s
> >>> sys     0m15.180s
> >>
> >>
> >>
> >> Perhaps some read-ahead bug. What happens if you use bs=128k for
> >> instance?
> >>
> > Nothing - it's still the same.
> >
> > root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=128k
> > count=4096
> > 4096+0 records in
> > 4096+0 records out
> >
> > real    0m32.832s
> > user    0m0.040s
> > sys     0m15.670s
> >
> Why is the system time so high? I tried that test here, and got:
> 
> oddball:root> time dd if=/dev/hda of=/dev/null bs=128k count=4096
> 4096+0 records in
> 4096+0 records out
> 
> real    0m37.927s
> user    0m0.025s
> sys     0m6.547s
> oddball:root> uname -rn
> oddball.prodigy.com 2.6.11ac7
> 
> Now this is one of the slowest CPUs still in use (which I why I test
> responsiveness on it), and it uses far less CPU time.
> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 5
> model name      : Pentium II (Deschutes)
> stepping        : 1
> cpu MHz         : 348.507
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr
> bogomips        : 686.08
> 
> 
> The first post said it felt like running PIO, it certainly is using CPU
> like it as well.
> 
> Now here's some dmesg from this system...
> 
> PIIX4: IDE controller at PCI slot 0000:00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: Maxtor 90845D4, ATA DISK drive
> hdb: WDC AC31600H, ATA DISK drive
> hdb: Disabling (U)DMA for WDC AC31600H (blacklisted)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: NEC CD-ROM DRIVE:28C, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
> hda: cache flushes not supported
>   hda: hda1 hda2 hda3 hda4 < hda5 >
> hdb: max request size: 128KiB
> hdb: 3173184 sectors (1624 MB) w/128KiB Cache, CHS=3148/16/63
> hdb: cache flushes not supported
>   hdb: hdb1 hdb2 hdb3
> hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> 
> 
> And indeed it does show hda as dma, and hdb as pio (older versions of
> the kernel let me set hdb to dma and it worked fine...). But in the
> posted demsg the BIOS settings show pio for hda. Is this in any way
> relevant, given that UDA(33) appears later?

BIOS setting is irrelevant and ~14MB/s for UDMA33 is OK.
CPU cycles are wasted somewhere else...

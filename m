Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVHLVhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVHLVhx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVHLVhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:37:52 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:25206 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751295AbVHLVhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:37:52 -0400
Subject: Re: bttv oopses, is this a valid v4l test?
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508121721.j7CHL84P026703@cichlid.com>
References: <200508121721.j7CHL84P026703@cichlid.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 12 Aug 2005 18:37:44 -0300
Message-Id: <1123882664.23070.57.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	We can't discard anything, but, IMHO, it looks a hardware problem,
since we have lots of bttv systems without the problems you are
noticing. 

Em Sex, 2005-08-12 às 10:21 -0700, Andrew Burgess escreveu:

> I have overlay mode disabled. Also, I don't view the video directly, its a
> security camera setup so it just creates avi files from the cameras, constantly
> in the background. So it's the PCI to memory to disk that I have trouble
> with...
	Ok, so it is not the same problem as Bodo noticed. On his
configuration, with overlay disabled, no pbm for him.
> 
> >	Your problems may be caused by:
> >	1) Some latency delay below the minimum limit;
> 
> I have the latency set to max (64) on the bttv argument (from the logs it looks
> like it defaulted to 32). I am going to look at the BIOS settings now to see if
> something looks promising to tweak. Any hints?
	You may try to use powertweak. It allows several tweaks. Maybe there
are some ones to disk also. You may try to increase disk latency with it
(in fact, also with some cmds at /etc/sysctl, but using GUI is easier).
> 
> I also have a kernel command line "pci=noacpi noapic acpi=ht" just to be
> conservative. Do you know if any of those could be a problem? It does make for
> many shared interrupts, see below.
	Yes, these could affect, as you have lots of cards inside. You may also
try to disable acpi using noacpi.
> 
> >	2) Some tweak at the MB to increase speed;
> 
> I overclocked in my youth but am too old for it now :-)
good :-)
> 
> >	3) some problem on PCI chipsets at both sides or at mainboard;
> 
> Could be. I'll run some disk tests in the background during normal use. That
> will test the disk controllers (and there are many of those, 4 ata drives disk
> on mb, 2 sata on mb, 16 drives on pci using three controllers (2 promise and 1
> 3-ware)
	You may also try to run memtest. I've seen problems like that with some
memory chips. As memory chips temperature increase, they produce
unexpected results.
	One test you may try is to keep the machine cooler than usual. Maybe
you can decrease CPU speed or use additional ventilators.
> 
> One the thing about a "cat /dev/video > /dev/null" test is that it eliminates all
> the disk pci controllers as a problem source. Or I could change my test to write to
> a ramfs.
> 
> >	4) bad contact;
> 
> I'll try reseating them.
Ok.
> 
> >	5) Some proprietary driver (like Nvidia ones);
> 
> No, I am happy with the supplied X11 nvidia driver so I am running untainted.
good!
> 
> >if you just cat /dev/video > some place, you are transfering from TV
> >card to memory then transfering from memory to disk. It is not the same
> >and should work w/o troubles.
> 
> Sadly it does not. The cat test never failed but recording from the cameras
> seems to cause trouble, the system is pretty rock solid if I don't touch the
> capture card (which is an el-cheapo GranTec with one bt878 and 4 inputs).
	We need to isolate the stuff to check if it is hw or sw related.
> Using vanilla 13rc6 now.
	Ok.
	Maybe you can try to use this card on another machine or tring another
bttv card on this one. It maybe something defect at the card or at the
MB.

	Please post any results.
> 
> Thanks for the response!
> Andrew
> 
> cc lkml
> 
> --------------------------------------------------------------------------
> 
> I get these several times a minute when things are running:
> 
> Aug 11 06:16:39 cichlid kernel: bttv0: OCERR @ 37254000,bits: HSYNC OFLOW OCERR*
> 
> and less of these:
> 
> Aug 11 06:16:36 cichlid kernel: bttv0: OCERR @ 37254000,bits: HSYNC OFLOW FDSR OCERR*
> Aug 11 06:18:48 cichlid kernel: bttv0: OCERR @ 37254000,bits: HSYNC OFLOW FBUS FDSR OCERR*
> Aug 11 06:22:06 cichlid kernel: bttv0: OCERR @ 37254000,bits: VSYNC* HSYNC OFLOW FBUS FDSR OCERR*

>From bttv-driver:
        "VSYNC",   // vertical sync (new field)
        "HSYNC",   // horizontal sync
        "OFLOW",   // chroma/luma AGC overflow
        "HLOCK",   // horizontal lock changed
        "FBUS",    // pixel data fifo dropped data (high pci bus
latencies)
        "FDSR",    // fifo data stream resyncronisation
        "OCERR",   // risc instruction error

Please, notice that OCERR means that the card tried to execute on its
internal RISC processor, an invalid instruction. It means that the
memory were corrupted somehow. Maybe by high temperatures. You may try
to rearrange your controlers inside, giving more space left to video
card, if your motherboard memories are ok. It may also caused by bad
contacts.
> 
> --------------------------------------------------------------------------
> 
>            CPU0       
>   0:    9577663          XT-PIC  timer
>   1:      22385          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:     898581          XT-PIC  ide4, ide5, Intel ICH5, ICE1712
>   8:     730989          XT-PIC  rtc
>   9:      34717          XT-PIC  ide2, ide3, uhci_hcd:usb3
>  10:    3337177          XT-PIC  3w-xxxx, bttv0, bt878, ehci_hcd:usb1
>  11:    8403411          XT-PIC  libata, ohci1394, uhci_hcd:usb2, uhci_hcd:usb4, uhci_hcd:usb5
>  12:      66278          XT-PIC  i8042
>  14:     120258          XT-PIC  ide0
>  15:       3048          XT-PIC  ide1
> NMI:          0 
> ERR:          1
> 
> --------------------------------------------------------------------------
> 
> 00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
> 00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
> 00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
> 00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
> 00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
> 00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
> 00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
> 00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
> 00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
> 00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 02)
> 00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> 01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5500] (rev a1)
> 02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
> 02:04.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
> 02:05.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
> 02:06.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
> 02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> 02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> 02:09.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
> 
> --------------------------------------------------------------------------
> 
> Aug 12 07:49:34 cichlid kernel: bttv0: Bt878 (rev 17) at 0000:02:07.0, irq: 10, latency: 32, mmio: 0xec000000
> Aug 12 07:49:34 cichlid kernel: bttv0: using: GrandTec Multi Capture Card (Bt878) [card=77,insmod option]
> Aug 12 07:49:34 cichlid kernel: bttv0: setting pci timer to 64
> Aug 12 07:49:34 cichlid kernel: bttv0: using tuner=-1
> Aug 12 07:49:34 cichlid kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> Aug 12 07:49:36 cichlid kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> Aug 12 07:49:37 cichlid kernel: bttv0: i2c: checking for TDA9887 @ 0x86... not found
> Aug 12 07:49:37 cichlid kernel: bttv: Overlay support disabled.
> Aug 12 07:49:37 cichlid kernel: bttv0: registered device video0
> Aug 12 07:49:37 cichlid kernel: bttv0: registered device vbi0
> Aug 12 07:49:37 cichlid kernel: bttv0: PLL: 28636363 => 35468950 .. ok
> Aug 12 07:49:37 cichlid kernel: bt878: AUDIO driver version 0.0.0 loaded
> 
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
> 
Cheers, 
Mauro.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbSK2BJH>; Thu, 28 Nov 2002 20:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSK2BJH>; Thu, 28 Nov 2002 20:09:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41926 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S266903AbSK2BJG>; Thu, 28 Nov 2002 20:09:06 -0500
Date: Thu, 28 Nov 2002 20:17:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alain Tesio <alain@onesite.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus P4B533 and resource conflict on IDE
In-Reply-To: <20021129014416.54940079.alain@onesite.org>
Message-ID: <Pine.LNX.4.50L.0211282016490.21207-100000@freak.distro.conectiva>
References: <20021129014416.54940079.alain@onesite.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alain,

I really have to sleep now but I'll look into this tomorrow morning.


On Fri, 29 Nov 2002, Alain Tesio wrote:

> Replying to an old thread:
>
> On Thu Jul 18 2002 - 06:12:02 Alan Cox wrote :
>
> > On Thu, 2002-07-18 at 13:45, Andrew Halliwell wrote:
> > > The P4B533 has the intel 801DB IDE controller (stated as supported in rc1)
> > > but in every 2.4 kernel I've seen so far, this appears in the bootup.
> > >
> > > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > > PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb
> > > PCI: Device 00:1f.1 not available because of resource collisions
> > > PCI_IDE: (ide_setup_pci_device:) Could not enable device
> >
> > Blame your BIOS vendor
> > The -ac tree has workarounds for the BIOS forgetting to set up the chip.
> > Let me know if rc1-ac7 works for you
>
> Hi, I have this motherboard and the same problem, I've naively looked for the string
> in the kernel sources and commented the line, and it works fine (hdparm can make
> the driver use DMA again, no corruption after applying this patch on successive
> kernels for months)
>
> The test must be here for a reason, I'm just saying it works in my case if some
> people need a workaround.
>
> Alain
>
>
>
> --- linux-2.4.20-rc3/arch/i386/kernel/pci-i386.c.orig   2002-11-28 20:42:57.000000000 +0100
> +++ linux-2.4.20-rc3/arch/i386/kernel/pci-i386.c        2002-11-28 20:44:05.000000000 +0100
> @@ -315,7 +315,8 @@
>                 r = &dev->resource[idx];
>                 if (!r->start && r->end) {
>                         printk(KERN_ERR "PCI: Device %s not available because of resource collisions
> \n", dev->slot_name);
> -                       return -EINVAL;
> +                       printk(KERN_ERR "  MY FIX : IGNORE PREVIOUS ERROR\n");
> +                       //                      return -EINVAL;
>                 }
>                 if (r->flags & IORESOURCE_IO)
>                         cmd |= PCI_COMMAND_IO;
>
>
> The exact warning is :
>
> kernel: PCI: Device 00:1f.1 not available because of resource collisions
>
> And the lspci output in case you're interested :
>
> :00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11)
> 00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
> 00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
> 00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
> 00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
> 00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)         <----------------------------
> 01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti500] (rev a3)
> 02:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
> 02:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c810 (rev 11)
> 02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

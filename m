Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSF2T5j>; Sat, 29 Jun 2002 15:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSF2T5i>; Sat, 29 Jun 2002 15:57:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34309
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314149AbSF2T5h>; Sat, 29 Jun 2002 15:57:37 -0400
Date: Sat, 29 Jun 2002 12:59:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Evgeniev <nick@octet.spb.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-rc1 i845e workaround udma fix
In-Reply-To: <3D1DF223.C56731EF@gmx.net>
Message-ID: <Pine.LNX.4.10.10206291252270.5348-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gunther,

That is a nice start to enable the HBA; however, the issue needs to add
full loading of the BARS.  Regardless of the old kludge to only load the
buffered resource values in the kernel, they were never committed to the
hardware.  This is one of the classic cases where Linux diverges from the
direction MicroSoft has pushed hardware to go under the rules of WHQL, and
ends up sucking wind.

The real need is to add in clean Native/Compatablity mode and not leave it
in voodoo land as we (me also) in the past have done.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Sat, 29 Jun 2002, Gunther Mayer wrote:

> Alan Cox wrote:
> 
> > Complain to your BIOS vendor
> >
> > A workaround for this BIOS flaw will be in the -ac tree in a week or so
> 
> Or try this patch today:
> 
> --- linux-2.4.19-rc1/arch/i386/kernel/pci-i386.c        Sat Jun 29 20:39:05
> 2002
> +++ linux/arch/i386/kernel/pci-i386.c   Sat Jun 29 20:37:25 2002
> @@ -314,8 +314,8 @@
>         for(idx=0; idx<6; idx++) {
>                 r = &dev->resource[idx];
>                 if (!r->start && r->end) {
> -                       printk(KERN_ERR "PCI: Device %s not available because
> of resource collisions\n", dev->slot_name);
> -                       return -EINVAL;
> +                       printk(KERN_ERR "PCI: Device %s not available because
> of resource collisions on idx=%d %x %x\n",
> dev->slot_name,idx,r->start,r->end);
> +                       printk("Temporary Workaround for 845E/845G:
> ignoring.\n");
>                 }
>                 if (r->flags & IORESOURCE_IO)
>                         cmd |= PCI_COMMAND_IO;
> 
> This increases hdparm -t from 3MB/sec to 41MB/sec.
> -
> Gunther
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


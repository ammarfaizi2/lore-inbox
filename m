Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262842AbRE0Rn7>; Sun, 27 May 2001 13:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbRE0Rnj>; Sun, 27 May 2001 13:43:39 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:60290 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S262842AbRE0Rnd>;
	Sun, 27 May 2001 13:43:33 -0400
Date: Sun, 27 May 2001 19:42:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VIA IDE no go with 2.4.5-ac1
Message-ID: <20010527194258.B1644@suse.cz>
In-Reply-To: <20010527144337.A15235@linuxhacker.ru> <E1543FE-0001zX-00@the-village.bc.nu> <20010527202814.A23079@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010527202814.A23079@linuxhacker.ru>; from green@linuxhacker.ru on Sun, May 27, 2001 at 08:28:14PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 08:28:14PM +0400, Oleg Drokin wrote:

> On Sun, May 27, 2001 at 05:18:20PM +0100, Alan Cox wrote:
> > >   Vanilla 2.4.5 boots ok, but 2.4.5-ac1 finishes kernel initialisation and
> > >   starts to print "hda: lost interrupt", I guess this is related to VIA IDE
> > >   updates in AC kernels. Config for vanilla and AC kernel is the same.
> > >   Here are the kernel logs from 2.4.5 and 2.4.5-ac1 (collected with serial
> > > ACPI: Core Subsystem version [20010208]
> > > ACPI: Subsystem enabled
> > > ACPI: Not using ACPI idle
> > > ACPI: System firmware supports: S0 S1 S4 S5
> > > hda: lost interrupt
> > > hda: lost interrupt
> > Does this still happen if you build without ACPI support. Also does
> > 'noapic' have any impact ?
> I will try this and report.
> I received this patch from Carlos E Gorges <carlos@techlinux.com.br>,
> that allows my box to boot, but DMA is not enabled by default
> (and needs to be explicitly enabled by hdparm -d1 /dev/hda) regardless of
> what is written at boot time.
> 
> --- drivers/ide/via82cxxx.c.orig	Sun May 27 08:10:47 2001
> +++ drivers/ide/via82cxxx.c	Sun May 27 08:11:13 2001
> @@ -105,7 +105,7 @@
>  	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
>  	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_66 },
>  #endif
> -	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 | VIA_BAD_PIO },
> +	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 },
>  	{ "vt82c686a",	PCI_DEVICE_ID_VIA_82C686,   0x10, 0x2f, VIA_UDMA_66 },
>  	{ "vt82c686",	PCI_DEVICE_ID_VIA_82C686,   0x00, 0x0f, VIA_UDMA_33 | VIA_BAD_CLK66 },
>  	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, VIA_UDMA_66 },

Not sure what version you're using, but if it's 3.23 (I believe it is)
then this patch does completely nothing, because the VIA_BAD_PIO flag
isn't used.

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSEIUOQ>; Thu, 9 May 2002 16:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSEIUOP>; Thu, 9 May 2002 16:14:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314290AbSEIUOM>; Thu, 9 May 2002 16:14:12 -0400
Subject: Re: PATCH & call for help: Marking ISA only drivers
To: ak@muc.de (Andi Kleen)
Date: Thu, 9 May 2002 21:33:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020509203719.A3746@averell> from "Andi Kleen" at May 09, 2002 08:37:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175ubJ-0004T4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW I think CONFIG_ISA would be an useful configuration option for 
> i386 too - at least most modern PCs do not come with ISA slots anymore.

ISA slots != ISA devices

And ISA stuff hanging off things like chipset glue busses is everywhere

> +if [ "$CONFIG_ISA" = "y" ]; then
> +   dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI

2825 is not ISA bus

> +# does not use pci dma and seems to be isa/onboard only for old machines
> +if [ "$CONFIG_X86_64" != "y" ]; then
> +  dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
> +fi

Thats PCI.

> +if [ "$CONFIG_ISA" = "y" ]; then
> +  dep_tristate 'Generic NCR5380/53c400 SCSI support' CONFIG_SCSI_GENERIC_NCR5380 $CONFIG_SCSI
> +  if [ "$CONFIG_SCSI_GENERIC_NCR5380" != "n" ]; then

This is used in multiple non ISA situations.

> +if [ "$CONFIG_X86" = "y" -a "$CONFIG_ISA" = "y" ]; then
>     dep_tristate 'UltraStor SCSI support' CONFIG_SCSI_ULTRASTOR $CONFIG_SCSI
>  fi

It makes an ugly mess of Config.in - I guess 2.5 is the time to do what
Russell and Keith wanted and make undefined imply "N" in dep_*

Alan

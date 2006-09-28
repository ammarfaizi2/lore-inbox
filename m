Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030903AbWI1AB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030903AbWI1AB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031266AbWI1AB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:01:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030903AbWI1AB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:01:58 -0400
Date: Wed, 27 Sep 2006 17:01:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Chipset addition for the VIA Southbridge workaround /
 quirk
Message-Id: <20060927170149.3bc04845.akpm@osdl.org>
In-Reply-To: <451AE795.6030804@rebelhomicide.demon.nl>
References: <451AE795.6030804@rebelhomicide.demon.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 23:05:25 +0200
Michiel de Boer <x@rebelhomicide.demon.nl> wrote:

> Hi, i'm (maybe unfortunately ;) the owner of a socket 370 motherboard
> by DFI. It's type number is CA63-EC REV A+. According to the manual
> this is the exact chipset naming:
> VIA 82C693A/82C686B AGPset
> 
> Also built in is an Creative Labs SB Live! audio device. When i was
> still using windows 98, i experienced corruptions when burning DVD's,
> and after lengthy investigation i discovered i had a buggy southbridge.[1]
> Apparently the presence of the SB Live! audio device might even accelerate
> the problem, although it does not actually disappear when this PCI card
> is removed. When i moved to Linux, i decided that writing a kernel patch
> based on the fixup programs i found for windows 98 would be appropriate.
> 
> However, i was pleased to discover that fixup code was already present in
> drivers/pci/quirks.c . The only thing i had to do then was add my mother-
> board identifier to the bottom of the code. The patch has been tried and
> tested since 2.6.8, and since then it has evolved since it turned out it
> contained unneccessary code patches. It has also been tested without
> problems on the user base of the distro Kanotix[2], of which i'm a
> co-developer. It activates as it should when it should, fixes the corrup-
> tions i had when burning DVD's, and improves system behavior.
> It's a very small and simple patch, but it would spare me from having
> to patch the kernel source myself it it were to be included.
> 
> Regards, Michiel de Boer
> 
> [1] 
> http://www.theregister.co.uk/2001/04/12/datacorruption_bug_hits_via_chipsets/
>      http://www.realworldtech.com/page.cfm?ArticleID=RWT051401003409
>      http://www.tecchannel.de/ueberblick/archiv/401770/
> [2] http://www.kanotix.com
> 
> Credit: Stefan Lippers-Hollmann <s.l-h@gmx.de>, for showing me the way
> around in the kernel sources.
> Signed-off-by: Michiel Lieuwe de Boer <x@rebelhomicide.demon.nl>
> 
> diff -Nru linux-2.6.18.orig/drivers/pci/quirks.c 
> linux-2.6.18/drivers/pci/quirks.c
> --- linux-2.6.18.orig/drivers/pci/quirks.c      2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18/drivers/pci/quirks.c   2006-09-27 22:43:30.000000000 +0200
> @@ -172,6 +172,7 @@
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,     
> PCI_DEVICE_ID_VIA_8363_0,       quirk_vialatency );
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,     
> PCI_DEVICE_ID_VIA_8371_1,       quirk_vialatency );
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,     
> PCI_DEVICE_ID_VIA_8361,         quirk_vialatency );
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,     
> PCI_DEVICE_ID_VIA_82C691_0,     quirk_vialatency );
> 

Could you please test 2.6.18-mm1, or simply
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/via-irq-quirk-behaviour-change.patch

Thanks.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTLXUEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTLXUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 15:04:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:47805 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263810AbTLXUEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 15:04:43 -0500
Date: Wed, 24 Dec 2003 12:04:33 -0800
From: Greg KH <greg@kroah.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] fix pci_update_resource() / IORESOURCE_UNSET on PPC
Message-ID: <20031224200433.GC6577@kroah.com>
References: <20031224111054.GB941@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031224111054.GB941@obroa-skai.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 12:10:55PM +0100, Harald Welte wrote:
> Hi!
> 
> [disclaimer:  This was posted on the linuxppc list before, BenH asked me 
>  to re-post it to lkml]
> 
> The prism54 (http://prism54.org) driver for my cardbus adapter works
> with 2.4.x, but not 2.6.x on a Titanium G4 Powerbook IV.
> 
> On 2.6.x the error message was
> PCI:0001:02:00.0 Resource 0 [00000000-00001fff] is unassigned
> 
> After investigating differences in the PCI code of 2.4.x and 2.6.x, i
> noticed that 2.4.x/arc/ppc/kernel/pci.c:pcibios_update_resource()
> contained a couple of lines that unset the IORESOURCE_UNSET bitflag.
> 
> In 2.6.x, this is handled by the generic PCI core in
> drivers/pci/setup-res.c:pci_update_resource() code.  However, the code
> is missing the 'res->flags &= ~IORESOURCE_UNSET' part.
> 
> The below fix re-adds that section from 2.4.x. 
> 
> I'm not sure wether this belongs into the arch-independent PCI api.
> Anyway, on PPC it seems to be needed for certain cardbus devices.

Is there any way you can add this to the ppc arch specific code, as
that's the only platform that seems to want this, right?

thanks,

greg k-h

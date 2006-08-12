Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWHLAg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWHLAg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWHLAg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 20:36:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964803AbWHLAg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 20:36:56 -0400
Date: Fri, 11 Aug 2006 17:36:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Greg KH <greg@kroah.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
Message-Id: <20060811173624.b60d8c47.akpm@osdl.org>
In-Reply-To: <1155341835.7574.76.camel@localhost.localdomain>
References: <1155334308.7574.50.camel@localhost.localdomain>
	<1155335237.3552.48.camel@mulgrave.il.steeleye.com>
	<1155335506.7574.54.camel@localhost.localdomain>
	<1155336653.3552.54.camel@mulgrave.il.steeleye.com>
	<1155337603.7574.61.camel@localhost.localdomain>
	<20060811162124.66895682.akpm@osdl.org>
	<1155341835.7574.76.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 17:17:15 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> Well, I have a new culprit of the hour:
> 
> 	gregkh-pci-pci-use-pci_bios-as-last-fallback

Thanks, I'll drop it.

> There was a previous patch that messed up a few of my machines and this
> same driver a few months ago, which accounts for my sense of deja vu:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/broken-out/gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch
> 
> There was an off-list thread called 
> 
> 	"PCI device issue in 2.6.16-rc3-mm1 through 2.6.16-rc6-mm1"
> 
> Anyway, here's the information from the syslog at boot in a working
> system (without the patch applied):
> 
> PCI: PCI BIOS revision 2.10 entry at 0xfd32c, last bus=8
> Setting up standard PCI resources
> SCSI subsystem initialized
> PCI: Probing PCI hardware
> PCI: Discovered peer bus 02
> PCI: Firmware left 0000:02:05.0 e100 interrupts enabled, disabling
> PCI: Discovered peer bus 05
> PCI->APIC IRQ transform: 0000:00:05.0[A] -> IRQ 16
> PCI->APIC IRQ transform: 0000:00:0f.2[A] -> IRQ 19
> PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 17
> PCI->APIC IRQ transform: 0000:02:01.1[B] -> IRQ 18
> PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 24
> PCI->APIC IRQ transform: 0000:05:02.0[A] -> IRQ 21
> PCI->APIC IRQ transform: 0000:05:02.1[B] -> IRQ 26
> PCI->APIC IRQ transform: 0000:06:04.0[A] -> IRQ 22
> PCI->APIC IRQ transform: 0000:06:05.0[A] -> IRQ 27
> PCI->APIC IRQ transform: 0000:06:06.0[A] -> IRQ 28
> PCI->APIC IRQ transform: 0000:06:07.0[A] -> IRQ 29
> PCI: Bridge: 0000:05:03.0
>   IO window: 7000-7fff
>   MEM window: eb000000-ec1fffff
>   PREFETCH window: ea300000-ea3fffff
> 
> And the same thing in a system where it can't find my SCSI card (with
> the patch applied):
> 
> PCI: Using configuration type 1
> Setting up standard PCI resources
> SCSI subsystem initialized
> PCI: Probing PCI hardware
> PCI->APIC IRQ transform: 0000:00:05.0[A] -> IRQ 16
> PCI->APIC IRQ transform: 0000:00:0f.2[A] -> IRQ 19
> 

Cc: culprits ;)

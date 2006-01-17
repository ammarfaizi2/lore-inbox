Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWAQTjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWAQTjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWAQTjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:39:53 -0500
Received: from mail.dvmed.net ([216.237.124.58]:57262 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932416AbWAQTjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:39:52 -0500
Message-ID: <43CD4800.20604@pobox.com>
Date: Tue, 17 Jan 2006 14:39:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Dillow <dave@thedillows.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Adaptec 1420SA issues with MSI
References: <1136667984.2799.0.camel@obelisk.thedillows.org> <20060109221323.65f6987d.akpm@osdl.org>
In-Reply-To: <20060109221323.65f6987d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Morton wrote: > Andi says "It's more likely a
	hardware bug that needs to be handled by the > driver maintainer.
	sata_mv has an pci_enable_msi(). Hardware that reports > MSI capability
	but breaks when it's actually used is not unheard of." > > -sata_mv
	0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via MSI > -ata1: SATA
	max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 177 > -ata2: SATA max
	UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 177 > -ata3: SATA max
	UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 177 > -ata4: SATA max
	UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 177 > +sata_mv
	0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via INTx > +ata1: SATA
	max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 18 > +ata2: SATA max
	UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 18 > +ata3: SATA max
	UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 18 > +ata4: SATA max
	UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 18 > > It seems strange
	that pci_enable_msi() succeeded if the device is not > MSI-capable?
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andi says "It's more likely a hardware bug that needs to be handled by the
> driver maintainer.  sata_mv has an pci_enable_msi().  Hardware that reports
> MSI capability but breaks when it's actually used is not unheard of."
> 
> -sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via MSI
> -ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 177
> -ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 177
> -ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 177
> -ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 177
> +sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via INTx
> +ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 18
> +ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 18
> +ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 18
> +ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 18
> 
> It seems strange that pci_enable_msi() succeeded if the device is not
> MSI-capable?

See http://lkml.org/lkml/2006/1/17/145

pci_enable_msi() has a problem where it succeeds when it should not, but 
also, sata_mv is still missing some errata workarounds that could be 
affecting MSI platforms.

	Jeff



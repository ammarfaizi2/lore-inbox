Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTDHQiv (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbTDHQiv (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:38:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261485AbTDHQit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:38:49 -0400
Date: Tue, 8 Apr 2003 17:50:26 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030408165026.GA23430@parcelfarce.linux.theplanet.co.uk>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408203824.A27019@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 08:38:24PM +0400, Ivan Kokshaysky wrote:
> On Tue, Apr 08, 2003 at 12:44:11AM +0100, Matthew Wilcox wrote:
> >  - Add segment to pci_bus.
> >  - Change the sysfs name of each device to include a 16-bit segment ID.
> 
> First of all, the "segment" name is extremely misleading. PCI spec
> assumes everywhere that "segment" is a group of devices sitting
> on the same wires (ie primary and secondary buses of the PCI-to-PCI
> bridge are *different* segments).

I don't mind changing it to `domain', I prefer the term myself.
ACPI calls it `_SEG' so I went with segment.

> Second, why not
> 
> -	strcpy(dev->dev.bus_id,dev->slot_name);
> +	sprintf(dev->dev.bus_id, "%04x:%s", pci_controller_num(dev),
> +		dev->slot_name);
> 
> ?

Because it's possible to have multiple pci root bridges in the same
pci domain.  This is true on at least HP's ia64 & parisc boxes.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

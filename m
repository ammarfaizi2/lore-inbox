Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbTFQQLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbTFQQLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:11:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9098 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264833AbTFQQLx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:11:53 -0400
Date: Tue, 17 Jun 2003 17:25:46 +0100
From: Matthew Wilcox <willy@debian.org>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617162546.GS30843@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617044948.GA1172@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 02:49:48PM +1000, Anton Blanchard wrote:
> I chose to add the domain into dev->slot_name since its needed for matching
> kernel messages to drivers. Im wondering if we should make this conditional
> on pci domain support since it does add some noise for those who couldnt
> care less about domains.

It's also exposed to userspace in some ways I don't think I like.
Here's some of the fun ones:

./sound/oss/emu10k1/main.c:             sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
./drivers/scsi/scsi_ioctl.c: * pci_dev::slot_name (8 characters) for the PCI device (if any).
(oops, that one already changed to use the device->bus_id, so that broke ...)

And some potential buffer overruns:
./drivers/input/gameport/cs461x.c:      sprintf(phys, "pci%s/gameport0", pdev->slot_name);
./drivers/net/3c59x.c:                  strcpy(info.bus_info, VORTEX_PCI(vp)->slot_name);

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVKQTHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVKQTHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVKQTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:07:49 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:9394 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S932499AbVKQTHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:07:48 -0500
Message-ID: <437CD4EE.4060807@qualcomm.com>
Date: Thu, 17 Nov 2005 11:07:26 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, tom.l.nguyen@intel.com,
       Greg KH <gregkh@suse.de>
Subject: Re: PCI MSI: the new interrupt routing headache
References: <437C18AF.7050508@pobox.com>
In-Reply-To: <437C18AF.7050508@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,
> 
> I just got SATA working on Marvell.  After fixing a bunch of issues in 
> the driver, the final issue was lack of interrupts.  Disabling 
> CONFIG_PCI_MSI solved that, and suddenly the driver was working quite 
> nicely.
> 
> The general problem is that pci_enable_msi() is not failing, on systems 
> that do not support MSI.  This leads to Infiniband, tg3, and other 
> drivers working around this problem by including an MSI-interrupts-work 
> test during probe.
> 
> Perhaps its because I like leading edge stuff, and am playing with 
> drivers for PCI MSI hardware, but it seems like I am running into this 
> pci_enable_msi()-doesnt-fail problem more and more frequently.  First 
> tg3, then AHCI, now sata_mv.
> 
> What needs to be done, to detect working PCI message signalled 
> interrupts such that pci_enable_msi() fails properly?
It fails correctly when MSI quirk is enabled. I had the same problems
on AMD 8131 based machine with 2.6.11 kernel. E1000 was enabling MSI and
not getting any interrupts. Later (.13 I think) MSI quirk was introduced for
8131 chipset and everything started working (without having to hack E1000
that is).
May be you should just add your platform to the PCI quirks list ?

Max

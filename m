Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbVKQFo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbVKQFo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 00:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbVKQFoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 00:44:25 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64186 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161150AbVKQFoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 00:44:25 -0500
Message-ID: <437C18AF.7050508@pobox.com>
Date: Thu, 17 Nov 2005 00:44:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: tom.l.nguyen@intel.com, Greg KH <gregkh@suse.de>
Subject: PCI MSI: the new interrupt routing headache
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got SATA working on Marvell.  After fixing a bunch of issues in 
the driver, the final issue was lack of interrupts.  Disabling 
CONFIG_PCI_MSI solved that, and suddenly the driver was working quite 
nicely.

The general problem is that pci_enable_msi() is not failing, on systems 
that do not support MSI.  This leads to Infiniband, tg3, and other 
drivers working around this problem by including an MSI-interrupts-work 
test during probe.

Perhaps its because I like leading edge stuff, and am playing with 
drivers for PCI MSI hardware, but it seems like I am running into this 
pci_enable_msi()-doesnt-fail problem more and more frequently.  First 
tg3, then AHCI, now sata_mv.

What needs to be done, to detect working PCI message signalled 
interrupts such that pci_enable_msi() fails properly?

Thanks,

	Jeff




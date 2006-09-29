Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWI2CHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWI2CHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWI2CHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:07:18 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:64483 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751298AbWI2CHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:07:16 -0400
Date: Fri, 29 Sep 2006 03:07:07 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.intel.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 1/2] libata: _GTF support
Message-ID: <20060929020707.GA22082@srcf.ucam.org>
References: <20060928182211.076258000@localhost.localdomain> <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 11:29:01AM -0700, Kristen Carlson Accardi wrote:

I mentioned this to Randy a while back, but I can't remember what sort 
of resolution we came to. In any case:

> + * sata_get_dev_handle - finds acpi_handle and PCI device.function

I'm a bit uncomfortable that we seem to have two quite different ways of 
accomplishing much the same thing. On the PCI bus, we have a callback 
that gets triggered whenever a new PCI device is attached. At that 
point, we look for the associated ACPI object and put a pointer to that 
in the device structure. Then, whenever we want to make an ACPI call, we 
can simply refer to that.

This implementation seems to reimplement much of the same lookup code, 
but makes it libata specific. Wouldn't it be cleaner to implement it in 
a similar way to PCI? The only real downside is that you need to add a 
callback in the ata bus code. drivers/pci/pci-acpi.c/pci_acpi_init is 
the sort of thing required.

(Thinking ahead, would that make it easier to maintain links in sysfs 
between devices and acpi objects?)

-- 
Matthew Garrett | mjg59@srcf.ucam.org

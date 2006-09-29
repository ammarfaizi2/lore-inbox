Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161752AbWI2RDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161752AbWI2RDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161751AbWI2RDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:03:44 -0400
Received: from mga03.intel.com ([143.182.124.21]:42250 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1161747AbWI2RDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:03:41 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,238,1157353200"; 
   d="scan'208"; a="124879341:sNHT18934818"
Date: Fri, 29 Sep 2006 10:03:00 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 1/2] libata: _GTF support
Message-Id: <20060929100300.ff76a22d.kristen.c.accardi@intel.com>
In-Reply-To: <20060929020707.GA22082@srcf.ucam.org>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112901.62ee8eba.kristen.c.accardi@intel.com>
	<20060929020707.GA22082@srcf.ucam.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 03:07:07 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, Sep 28, 2006 at 11:29:01AM -0700, Kristen Carlson Accardi wrote:
> 
> I mentioned this to Randy a while back, but I can't remember what sort 
> of resolution we came to. In any case:
> 
> > + * sata_get_dev_handle - finds acpi_handle and PCI device.function
> 
> I'm a bit uncomfortable that we seem to have two quite different ways of 
> accomplishing much the same thing. On the PCI bus, we have a callback 
> that gets triggered whenever a new PCI device is attached. At that 
> point, we look for the associated ACPI object and put a pointer to that 
> in the device structure. Then, whenever we want to make an ACPI call, we 
> can simply refer to that.
> 
> This implementation seems to reimplement much of the same lookup code, 
> but makes it libata specific. Wouldn't it be cleaner to implement it in 
> a similar way to PCI? The only real downside is that you need to add a 
> callback in the ata bus code. drivers/pci/pci-acpi.c/pci_acpi_init is 
> the sort of thing required.
> 
> (Thinking ahead, would that make it easier to maintain links in sysfs 
> between devices and acpi objects?)
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

This makes sense to me.  I'm happy to put together some patches for 
commenting on if people think this is a good way to go.  It would be
much cleaner in my opinion and we could get rid of a good chunk of code.

Kristen

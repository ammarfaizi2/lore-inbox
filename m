Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbTIISl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTIISlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:41:25 -0400
Received: from havoc.gtf.org ([63.247.75.124]:5101 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264349AbTIISlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:41:23 -0400
Date: Tue, 9 Sep 2003 14:41:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, jun.nakajima@intel.com,
       tom.l.nguyen@intel.com, zwane@linuxpower.ca
Subject: Re: MSI fix for buggy PCI/PCI-X hardware
Message-ID: <20030909184122.GA3635@gtf.org>
References: <200309091539.h89FdbfK023026@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309091539.h89FdbfK023026@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 08:39:37AM -0700, long wrote:
> The proposed solution is to provide a new API, named "int 
> disable_msi(struct pci_dev *dev)", to allow IHV's who have 
> shipped PCI/PCI-X hardware that does not work in MSI mode to update 
> their software drivers to request the kernel to switch the 
> interrupt mode from MSI mode back to IRQ pin-assertion mode. 

No need for a new API.  We have drivers/pci/quirk.c where we add PCI
devices with known bugs.  If there is commonality of the bugs across
hardware, we can easily add a common "quirk" which fixes the situation.

Individual drivers shouldn't need to bother with this, really.

As an aside, if you need to blacklist certain _systems_ rather than
certain PCI devices, you should either modify drivers/pci/quirks.c or
arch/i386/kernel/dmi_scan.c.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVARSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVARSYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVARSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:24:44 -0500
Received: from fmr19.intel.com ([134.134.136.18]:7588 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261366AbVARSYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:24:41 -0500
Date: Tue, 18 Jan 2005 11:28:57 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200501181928.j0IJSvVv023915@snoqualmie.dp.intel.com>
To: greg@kroah.com
Subject: Re:[PATCH] PCI: add PCI Express Port Bus Driver subsystem
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005 15:49:08 -0800 Greg KH wrote:
> > +int pcie_port_device_register(struct pci_dev *dev)
> > +{
> > +	struct pcie_device *parent;
> > +	int status, type, capabilities, irq_mode, i;
> > +	int vectors[PCIE_PORT_DEVICE_MAXSERVICES];
> > +	u16 reg16;
> > +
> > +	/* Get port type */
> > +	pci_read_config_word(dev, 
> > +		pci_find_capability(dev, PCI_CAP_ID_EXP) + 
> > +		PCIE_CAPABILITIES_REG, &reg16);
> > +	type = (reg16 >> 4) & PORT_TYPE_MASK;
> > +
> > +	/* Now get port services */
> > +	capabilities = get_port_device_capability(dev);
> > +	irq_mode = assign_interrupt_mode(dev, vectors, capabilities);
> > +
> > +	/* Allocate parent */
> > +	parent = alloc_pcie_device(NULL, dev, type, 0, dev->irq, irq_mode);
> > +	if (!parent) 
> > +		return -ENOMEM;
> > +	
> > +	status = device_register(&parent->device);
> > +	if (status) {
> > +		kfree(parent);
> > +		return status;
> > +	}
>
>
> This puts all of the pcie "port" structures in /sys/devices/  Shouldn't
> you make the parent of the device you create point to the pci_dev
> structure that's passed into this function?  That would make the sysfs
> tree a lot saner I think.

The patch makes the parent of the device point to the pci_dev structure
that is passed into this function. If you think it is cleaner that the
patch should not, I will update the patch to reflect your input.

Thanks,
Long 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSKMA1u>; Tue, 12 Nov 2002 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267058AbSKMA1u>; Tue, 12 Nov 2002 19:27:50 -0500
Received: from holomorphy.com ([66.224.33.161]:55741 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267061AbSKMA1t>;
	Tue, 12 Nov 2002 19:27:49 -0500
Date: Tue, 12 Nov 2002 16:28:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg KH <greg@kroah.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021113002855.GD23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com, mochel@osdl.org
References: <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com> <20021112235824.GG22031@holomorphy.com> <20021113000435.GE32274@kroah.com> <20021113001246.GC23425@holomorphy.com> <20021113002032.GF32274@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113002032.GF32274@kroah.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:20:32PM -0800, Greg KH wrote:
> Ok, then also please fix up drivers/pci/probe.c::pci_setup_device() to
> set a unique slot_name up for the pci_dev, if you have multiple
> domains/segments.
> thanks,
> greg k-h

Okay, tihs just needs the introduction of something that can produce
a number out of ->sysdata (or whatever):

        sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));


This wants to be something like:
        sprintf(dev->slot_name, "%02x:%02x:%02x.%d", dev->bus->segment, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));


On the way in 5 minutes or thereabouts. I'm restarting from just before
the NUMA changes.

Bill

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbTAOLUN>; Wed, 15 Jan 2003 06:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTAOLUM>; Wed, 15 Jan 2003 06:20:12 -0500
Received: from dp.samba.org ([66.70.73.150]:43476 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265643AbTAOLUM>;
	Wed, 15 Jan 2003 06:20:12 -0500
Date: Wed, 15 Jan 2003 22:24:12 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030115112412.GA5062@krispykreme>
References: <20030115105802.GQ940@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115105802.GQ940@holomorphy.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	-- I've already tried and failed on PCI segments.
> 	-- I would be much obliged for advice on this one, especially
> 	-- since the workaround cripples the machine.

I was wondering if we could use pci_scan_bus_parented as a start.
Assuming we fixed pci_bus_exists, this should allow us to create
overlapping busses.

What else needs fixing? To start with:

* pci config read/writes
	Should be arch specific, can hide things in struct pci_bus
	which is passed in. (eg on ppc64 we have to pass an identifier
	into the low level config read or write)

* pci IO/memory reads/writes
	No problems on ppc64, it should just work. Are there problems
	on x86? 

* /proc/bus/pci/
	As davem pointed out we have a backwards compatibility bit
	where all devices on domain 0 appear as they always have.
	Additionally we create another level of directories to represent
	the domain.

* /proc/pci
	Need to print the domain

* device printing
	We need a macro that drivers can use to print their PCI location
	Then we make that print the domain.

* sysfs
	I havent looked into this yet

Does anything else spring to mind?

Anton

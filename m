Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSKMATA>; Tue, 12 Nov 2002 19:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267054AbSKMATA>; Tue, 12 Nov 2002 19:19:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:43536 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267052AbSKMAS7>;
	Tue, 12 Nov 2002 19:18:59 -0500
Date: Tue, 12 Nov 2002 16:20:32 -0800
From: Greg KH <greg@kroah.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021113002032.GF32274@kroah.com>
References: <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com> <20021112235824.GG22031@holomorphy.com> <20021113000435.GE32274@kroah.com> <20021113001246.GC23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113001246.GC23425@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:12:46PM -0800, William Lee Irwin III wrote:
> On Tue, Nov 12, 2002 at 03:58:24PM -0800, William Lee Irwin III wrote:
> >> Okay, an attempt to remedy this world-breaking braindamage with the
> >> fewest lines of code:
> >> This alters PCI bus number "clash" detection to compare ->sysdata in
> >> addition to the numbers. The bus number is not a unique identifier.
> 
> On Tue, Nov 12, 2002 at 04:04:35PM -0800, Greg KH wrote:
> > Um, why not?
> > And what would /sys/bus/pci/devices look like if you allow the same
> > identifiers for different devices?  :)
> > thanks,
> > greg k-h
> 
> (1) incorrect semantics:
> 	multiple domains/segments exist, and the bus number is not
> 	qualified with such
> (2) insufficient cardinality:
> 	even in the presence of remapping schemes the bus space is limited
> 	to less than the number of buses requiring unique identifiers

Ok, then also please fix up drivers/pci/probe.c::pci_setup_device() to
set a unique slot_name up for the pci_dev, if you have multiple
domains/segments.

thanks,

greg k-h

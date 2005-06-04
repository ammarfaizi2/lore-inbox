Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFDGqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFDGqo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFDGqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:46:44 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:7804 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261263AbVFDGqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:46:40 -0400
Date: Fri, 3 Jun 2005 23:46:27 -0700
From: Greg KH <gregkh@suse.de>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604064627.GB13238@suse.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 01:28:28AM +0200, Andreas Koch wrote:
> [Greg K-H suggested I distribute this more widely]
> 
> Hello all,
> 
> there appear to be difficulties correctly mapping addresses behind a
> PCI Express-to-PCI bridge in kernel 2.6.12-rc5. 
> 
> Specifically, this occurs on my Acer Travelmate 8100 notebook (Pentium
> M, Intel 915M chipset) when it is connected via PCI Express to the
> ezDock docking station.

Are you connecting it at boot time, or after the box is up and running?

> While all of the USB and FireWire devices are visible using config
> space reads, they cannot be accessed correctly (all normal reads
> appear to return 0xff).  After checking the dmesg logs, I find
> 
> 	PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
> 	PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
> 
> This would confirm my hypothesis, since reads go the route of
> 
>   Processor
>   Intel 82801xx ICH6 southbridge 
>   PCI Express port 3             0000:00:1c.2
>   Intel 6702PXH PCIE-PCI bridge  0000:02:00.0
>   ezDock-internal PCI bus        0000:03:xx.x
>     USB
>     Firewire
>     ...
> 
> Since the PCIE-PCI bridge cannot be memory-mapped, the devices behind it
> cannot be accessed correctly.
> 
> I am no expert on debugging this part of the kernel, but I will gladly
> provide additional info to resolve this problem.

Hm, another idea, can you load the pci express and standard pci hotplug
drivers?  You might have to "enable" those slots in order for the pci
core to scan the devices and set everything up properly.  

To do this, after loading the modules (pciehp and shpchp), look in
/sys/bus/pci/slots/

If there are any "slots" listed there, go into those directories and
"power them on" by simply writing a "1" to the file 'power' by using
echo.

Let us know if that helps out any or not.

Oh, and this isn't "PCI ExpressCard" type hardware is it (next
generation pcmcia/cardbus evolution.)

thanks,

greg k-h

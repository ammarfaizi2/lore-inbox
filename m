Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278136AbRJLVDx>; Fri, 12 Oct 2001 17:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278137AbRJLVDo>; Fri, 12 Oct 2001 17:03:44 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:18951 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278136AbRJLVDY>;
	Fri, 12 Oct 2001 17:03:24 -0400
Date: Fri, 12 Oct 2001 13:55:56 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI device search.
Message-ID: <20011012135556.A21296@kroah.com>
In-Reply-To: <20011012170411.A21169@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012170411.A21169@come.alcove-fr>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 05:04:11PM +0200, Stelian Pop wrote:
> 
> 	1. Create a PCI driver (pci_device_id, struct pci_driver etc)
> 	and in init_module call pci_module_init. If it fails,
> 	assume the driver deals with newer hardware and 
> 	call 'by hand' the 'probe' routine from pci_driver struct.
> 
> 	2. Not use the PCI driver infrastructure, and in
> 	init_module just call pci_find_device manually searching
> 	for older hardware, if it is present go further, if
> 	it fails assume newer hardware and go further.
> 
> What is considered to be the best way to do it ?
> (this is _not_ a hotplug device if it matters).

I'd say 1.  If a device is hotpluggable or not does not matter.  For
2.5, the boot process will be able to load modules for all PCI
devices seen in the system.  In order for that to happen, they need to
use the MODULE_DEVICE structure and the 2.4 pci driver subsystem.

(which it looks like almost none of the current SCSI driver do...)

thanks,

greg k-h

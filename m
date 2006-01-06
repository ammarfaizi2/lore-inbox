Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752484AbWAFRPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbWAFRPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWAFRPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:15:48 -0500
Received: from linux.us.dell.com ([143.166.224.162]:21396 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S1752274AbWAFRPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:15:48 -0500
Date: Fri, 6 Jan 2006 11:15:08 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alex Williamson <alex.williamson@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org,
       ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
Message-ID: <20060106171508.GA19605@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <20060105173740.GA20650@lists.us.dell.com> <200601051054.18867.bjorn.helgaas@hp.com> <200601051702.00150.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601051702.00150.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:02:00PM -0700, Bjorn Helgaas wrote:
> On Thursday 05 January 2006 10:54, Bjorn Helgaas wrote:
> > On Thursday 05 January 2006 10:37, Matt Domsch wrote:
> > > This system (Dell PowerEdge 7250, very very similar to an Intel
> > > 4-way Itanium2 server) doesn't have an SPMI table, but it does have
> > > the IPMI information in the SMBIOS table.
> > 
> > But the IPMI device *should* be described in the ACPI namespace, so
> > using acpi_bus_register_driver() should be sufficient.
> 
> You mentioned on IRC that /sys/firmware/acpi/namespace didn't
> contain anything that looked like an IPMI device.  Try dumping the
> actual DSDT and looking there -- I'm not sure everything makes it
> into /sys/firmware/acpi/...
> 
> Use the latest "pmtools" from here:
>     http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils
> 
> and "iasl" to disassemble it.
> 
> I did this on an Intel Tiger, and didn't see any "IPI" devices in the
> namespace either.  I think it's a firmware bug if the hardware
> is there but not described in the namespace.
> 
> So maybe you'd have to grub through SMBIOS to workaround
> the firmware defect.

Indeed.  I updated the BIOS to the latest available, and it doesn't
list the IPMI controller in the ACPI namespace.  FWIW, this is
effectively an Intel S870BN4 "Tiger4" system.  FWIW2, the Dell
PowerEdge x8xx line (current shipping EM64T servers) doesn't have the
IPMI controller in the ACPI namespace either.

I reworked the patch, such that on EFI-capable systems, it uses
efi.smbios to find the _DMI_ table header, and on all non-EFI systems,
continues the brute force search from 0xF0000 as before.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

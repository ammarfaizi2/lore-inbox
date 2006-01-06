Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWAFACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWAFACH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWAFACG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:02:06 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:36299 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932291AbWAFACD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:02:03 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
Date: Thu, 5 Jan 2006 17:02:00 -0700
User-Agent: KMail/1.8.3
Cc: Alex Williamson <alex.williamson@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org,
       ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060105173740.GA20650@lists.us.dell.com> <200601051054.18867.bjorn.helgaas@hp.com>
In-Reply-To: <200601051054.18867.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051702.00150.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 10:54, Bjorn Helgaas wrote:
> On Thursday 05 January 2006 10:37, Matt Domsch wrote:
> > This system (Dell PowerEdge 7250, very very similar to an Intel
> > 4-way Itanium2 server) doesn't have an SPMI table, but it does have
> > the IPMI information in the SMBIOS table.
> 
> But the IPMI device *should* be described in the ACPI namespace, so
> using acpi_bus_register_driver() should be sufficient.

You mentioned on IRC that /sys/firmware/acpi/namespace didn't
contain anything that looked like an IPMI device.  Try dumping the
actual DSDT and looking there -- I'm not sure everything makes it
into /sys/firmware/acpi/...

Use the latest "pmtools" from here:
    http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils

and "iasl" to disassemble it.

I did this on an Intel Tiger, and didn't see any "IPI" devices in the
namespace either.  I think it's a firmware bug if the hardware
is there but not described in the namespace.

So maybe you'd have to grub through SMBIOS to workaround
the firmware defect.

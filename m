Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUJTG0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUJTG0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUJTGTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:19:50 -0400
Received: from [192.55.52.67] ([192.55.52.67]:7780 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S270149AbUJTGQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 02:16:21 -0400
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
From: Len Brown <len.brown@intel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <200410182041.02192.david-b@pacbell.net>
References: <200410051309.02105.david-b@pacbell.net>
	 <1097906636.14156.41.camel@d845pe> <200410182041.02192.david-b@pacbell.net>
Content-Type: text/plain
Organization: 
Message-Id: <1098252967.26601.4273.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 02:16:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 23:41, David Brownell wrote:
> On Friday 15 October 2004 11:03 pm, Len Brown wrote:
> > > - ACPI (this should probably replace the new /proc/acpi/wakeup)
> >
> > Agreed.  That file is a temporary solution.
> > The right solution is for the devices to appear in the right
> > place in the device tree and to hang the wakeup capabilities
> > off of them there.
> 
> So what would that patch need before ACPI could convert to use it?
> 
> I didn't notice any obvious associations between the strings in
> the acpi/wakeup file and anything in sysfs.  Which of USB1..USB4
> was which of the three controllers shown by "lspci" (and which
> one was "extra"!), as one head-scratcher.

The strings "USB1" etc. are completely arbitrary, which is one
reason that /proc/acpi/wakeup is only marginally useful.

> For PCI, I'd kind of expect pci_enable_wake() to trigger the
> additional ACPI-specific work to make sure the device can
> actually wake that system.   Seems like dev->platform_data
> might need to combine with some platform-specific API hook.

In the ACPI DSDT...
Devices are explicitly identified as PCI busses by their PNP-id.
These PCI busses are enumerated by their _BBN or _CRS.
The devices under the PCI busses all contain an _ADR which encodes the
PCI device/function number.

Ie. ACPI tells us the PCI bus/dev/func for each PCI device in the DSDT,
and with this information it needs to be able to find devices in the
Linux device tree and associate some ACPI capabilities with it.

-Len



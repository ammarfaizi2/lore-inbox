Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUHNCXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUHNCXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 22:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267941AbUHNCXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 22:23:39 -0400
Received: from fmr10.intel.com ([192.55.52.30]:42631 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S267918AbUHNCXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 22:23:34 -0400
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040813235515.GB28687@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com>
	 <200408121550.15892.bjorn.helgaas@hp.com>
	 <1092350580.7765.190.camel@dhcppc4>
	 <200408131515.56322.bjorn.helgaas@hp.com>
	 <20040813235515.GB28687@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1092450142.5028.232.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Aug 2004 22:22:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 19:55, Adrian Bunk wrote:
> On Fri, Aug 13, 2004 at 03:15:56PM -0600, Bjorn Helgaas wrote:
> > On Thursday 12 August 2004 4:43 pm, Len Brown wrote:
> > > I expect that the the bug is that floppy.c, like other motherboard
> > > devices, should take advantage of ACPI for device resource
> > > enumeration.
> > 
> > This patch only checks for
> > a floppy controller (PNP0700) in the ACPI namespace.  If ACPI has
> > been disabled, or we actually find a controller, we probe blindly
> > for the floppy controller as we did in the past.  If ACPI is enabled
> > and we DON'T find a controller, we just exit with -ENODEV.
> >...
> 
> It fixes my problem.

This shows that we can make floppy probe fail,
but we also need to show that it can succeed.
If you enable the floppy in the BIOS does this
prink in bjorn's patch fire?:

+	printk("%s: found a controller at ACPI %s\n", DEVICE_NAME,
+               device->pnp.bus_id);
+       acpi_floppies_found++;

Also, it would be helpful to see the lines with LNKD
in the dmesg for floppy enabled and floppy disabled cases --
a 2.6.7 vintage kernel should work fine:

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
        ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6

If you can also run acpidmp in both those scenarios
(any kernel version, ACPI enabled or disabled should do)
and send me the two output files, that would be great.

thanks,
-Len

ps. you can get acpidmp in /usr/sbin/ or from pmtools here
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/



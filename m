Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWAEQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWAEQlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWAEQlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:41:23 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:50908 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751582AbWAEQlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:41:22 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
Date: Thu, 5 Jan 2006 09:41:15 -0700
User-Agent: KMail/1.8.3
Cc: Alex Williamson <alex.williamson@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org,
       ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <1136414164.6198.36.camel@localhost.localdomain> <20060104232944.GA32250@lists.us.dell.com>
In-Reply-To: <20060104232944.GA32250@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601050941.15915.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 16:29, Matt Domsch wrote:
> On Wed, Jan 04, 2006 at 03:36:03PM -0700, Alex Williamson wrote:
> > On Wed, 2006-01-04 at 16:16 -0600, Matt Domsch wrote:
> > > Andi Kleen has a patch in his x86_64 tree which enables the use
> > > of i386 dmi_scan.c on x86_64.  dmi_scan.c functions are being
> > > used by the drivers/char/ipmi/ipmi_si_intf.c driver for
> > > autodetecting the ports or memory spaces where the IPMI
> > > controllers may be found.
> >
> >    Can't this be done via ACPI/EFI?  I'm really opposed to adding
> > anything to ia64 that blindly picks memory ranges and starts
> > scanning for magic legacy tables.  If nothing else, this can be
> > found via efi.smbios.  Thanks,
>
> I'll redo this to use efi.smbios.  Thanks for the tip.

The DMI scan looks like it's done in try_init_smbios().  But
try_init_acpi() is done first.  Since every ia64 machine has
ACPI, I would think try_init_acpi() should be sufficient.

Or do you have a machine that doesn't supply the SPMI
table used by try_init_acpi()?

Personally, I think try_init_acpi() should be re-done so it uses
the normal acpi_bus_register_driver() mechanism, which would
locate the IPMI device in the ACPI namespace.  I don't think
there's any need to rely on the SPMI, which is primarily there
to support OS's that want to do IPMI stuff early in boot, before
the ACPI machinery is ready.

Bjorn

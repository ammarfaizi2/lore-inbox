Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUJEQYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUJEQYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269945AbUJEQXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:23:32 -0400
Received: from palrel13.hp.com ([156.153.255.238]:63972 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S269210AbUJEQWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:22:32 -0400
Date: Tue, 5 Oct 2004 09:22:01 -0700
From: Grant Grundler <iod00d@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041005162201.GC18567@cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com> <200410050843.44265.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410050843.44265.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 08:43:44AM -0700, Jesse Barnes wrote:
... 
> >   arch/ia64/pci/pci.c
> 
> It looks like the only non-codingstyle change here is to make pci_root_ops 
> non-static (and btw, some of the CodingStyle fixups look wrong).  If it needs 
> to be non-static, it should be declared in a header file so we don't have to 
> extern it in sn_pci_fixup_bus.

pci_root_ops should be static. It's only intended for ACPI.
Maybe rename pci_root_ops to "acpi_pci_ops" would make that clearer.

If SN2 platform needs hacks, then define "sn2_acpi_pci_ops" someplace
in the SN2 specific source code. In this case, SN2 will also 
need to continue to NOT use pci_acpi_scan_root() and define it's
own discovery. When SN2 firmware can support pci_acpi_scan_root(),
then it would make sense to drop the SN2 specific PCI discovery and pci_ops.
And both can co-exist - SN2 code can check which version of firmware
is installed and invoke ia64 ACPI support if that is known to work.

If SN2 needs something defined in the ACPI spec but missing from ia64
ACPI support, add the missing bits to arch/ia64/pci/pci.c.
It just shouldn't interfere with current use.

hth,
grant

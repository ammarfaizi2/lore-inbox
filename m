Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWAERyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWAERyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWAERyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:54:22 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:15065 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750708AbWAERyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:54:21 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
Date: Thu, 5 Jan 2006 10:54:18 -0700
User-Agent: KMail/1.8.3
Cc: Alex Williamson <alex.williamson@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org,
       ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <200601050941.15915.bjorn.helgaas@hp.com> <20060105173740.GA20650@lists.us.dell.com>
In-Reply-To: <20060105173740.GA20650@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051054.18867.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 10:37, Matt Domsch wrote:
> On Thu, Jan 05, 2006 at 09:41:15AM -0700, Bjorn Helgaas wrote:
> > The DMI scan looks like it's done in try_init_smbios().  But
> > try_init_acpi() is done first.  Since every ia64 machine has
> > ACPI, I would think try_init_acpi() should be sufficient.
> >
> > Or do you have a machine that doesn't supply the SPMI
> > table used by try_init_acpi()?
>
> This system (Dell PowerEdge 7250, very very similar to an Intel
> 4-way Itanium2 server) doesn't have an SPMI table, but it does have
> the IPMI information in the SMBIOS table.

But the IPMI device *should* be described in the ACPI namespace, so
using acpi_bus_register_driver() should be sufficient.

I think that would be a better approach than using the SMBIOS table.
But it is certainly a lot more work :-(

Bjorn

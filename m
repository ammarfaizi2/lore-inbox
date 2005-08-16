Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbVHPUx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVHPUx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbVHPUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:53:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56033 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932709AbVHPUx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:53:57 -0400
Subject: Re: [PATCH 2.6.12.4] ACPI oops during ipmi_si driver init
From: Peter Martuccelli <peterm@redhat.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: len.brown@intel.com, akpm@osdl.com, linux-kernel@vger.kernel.org,
       minyard@mvista.com
In-Reply-To: <200508151613.10389.bjorn.helgaas@hp.com>
References: <200508121944.j7CJiifE005958@redrum.boston.redhat.com>
	 <200508151613.10389.bjorn.helgaas@hp.com>
Content-Type: text/plain
Message-Id: <1124225401.7130.797.camel@redrum.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 16 Aug 2005 16:50:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 18:13, Bjorn Helgaas wrote:
> On Friday 12 August 2005 1:44 pm, Peter Martuccelli wrote:
> > Stumbled into this problem working on the ipmi_si driver.  When the
> > ipmi_si driver initialization fails the acpi_tb_get_table 
> > call, after rsdt_info has been allocated, acpi_get_firmware_table()
> > will oops trying to reference off rsdt_info->pointer in the cleanup
> > code.
> 
> I don't know whether the ACPI patch is correct or desirable, but
> I think the ipmi_si ACPI discovery is bogus (it was probably
> written before the current ACPI and PNPACPI driver registration
> interfaces were stable).
> 
> Currently, ipmi_si uses the static SPMI table to locate the
> device.  But the static table should only be used if we need
> the device very early, before the ACPI namespace is available.
> 
> I don't think we use the device early, so we should use
> pnp_register_driver() to claim the appropriate PNP IDs.
> Or we might have to use acpi_bus_register_driver() since
> it looks like it uses ACPI-specific features like GPEs.
Adding in Corey to the discussion regarding ipmi_si initialization,
waiting on Len to decide on the ACPI fix.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUALQYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUALQYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:24:21 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:51905 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266509AbUALQYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:24:19 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jes Sorensen <jes@wildopensource.com>
Subject: Re: [ACPI] RFC: ACPI table overflow handling
Date: Mon, 12 Jan 2004 09:24:06 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       jbarnes@sgi.com, steiner@sgi.com
References: <16381.27904.580087.442358@gargle.gargle.HOWL> <200401080920.04906.bjorn.helgaas@hp.com> <yq0ad4uimm7.fsf@wildopensource.com>
In-Reply-To: <yq0ad4uimm7.fsf@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120924.06881.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 January 2004 7:30 am, Jes Sorensen wrote:
> +++ linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c	Sun Jan 11 05:15:22 2004
> -	if (acpi_table_parse_madt(ACPI_MADT_IOSAPIC, acpi_parse_iosapic) < 1)
> +	if (acpi_table_parse_madt(ACPI_MADT_IOSAPIC, acpi_parse_iosapic, 256) < 1)

The "256" looks like it's based on the "iosapic_lists[256]" definition.
We probably should introduce a #define for those cases (sorry, I should
have noticed this the first time).

> +++ linux-2.6.0-test11-ia64/arch/x86_64/kernel/acpi/boot.c	Sun Jan 11 05:31:58 2004
> +	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, NR_IRQ_VECTORS);
>...
> +	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src,
> +				       NO_IRQ_VECTORS);

Is NO_IRQ_VECTORS a typo for NR_IRQ_VECTORS?

> +++ linux-2.6.0-test11-ia64/drivers/acpi/numa.c	Thu Jan  8 02:49:24 2004
>  acpi_table_parse_srat (
>  	enum acpi_srat_entry_id	id,
> -	acpi_madt_entry_handler	handler)
> +	acpi_madt_entry_handler	handler,
> +	int max_entries)

Should "max_entries" be unsigned?  I notice you used unsigned types in the
implementation, i.e., "count".

Bjorn


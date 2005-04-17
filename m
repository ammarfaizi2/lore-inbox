Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVDQGtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVDQGtn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 02:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVDQGtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 02:49:43 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:18827 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261274AbVDQGtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 02:49:40 -0400
X-ORBL: [67.124.119.21]
Date: Sat, 16 Apr 2005 23:27:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jason@rightthere.net,
       ak@suse.de, jason.davis@unisys.com
Subject: Re: [patch 070/198] x86_64 genapic update
Message-ID: <20050417062726.GA8379@taniwha.stupidest.org>
References: <200504121031.j3CAVln9005407@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504121031.j3CAVln9005407@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 03:31:41AM -0700, akpm@osdl.org wrote:

> diff -puN arch/i386/kernel/acpi/boot.c~x86_64-genapic-update arch/i386/kernel/acpi/boot.c
> --- 25/arch/i386/kernel/acpi/boot.c~x86_64-genapic-update	2005-04-12 03:21:20.212064200 -0700
> +++ 25-akpm/arch/i386/kernel/acpi/boot.c	2005-04-12 03:21:20.217063440 -0700
> @@ -608,6 +608,10 @@ static int __init acpi_parse_fadt(unsign
>  	acpi_fadt.sci_int = fadt->sci_int;
>  #endif
>  
> +	/* initialize rev and apic_phys_dest_mode for x86_64 genapic */
> +	acpi_fadt.revision = fadt->revision;
> +	acpi_fadt.force_apic_physical_destination_mode = fadt->force_apic_physical_destination_mode;
> +

This breaks for me.  It seems acpi_fadt needs CONFIG_ACPI_BUS.  How
does this look?

Signed-off-By: Chris Wedgwood <cw@f00f.org>

Index: cw-current/arch/i386/kernel/acpi/boot.c
===================================================================
--- cw-current.orig/arch/i386/kernel/acpi/boot.c	2005-04-16 20:17:09.801272343 -0700
+++ cw-current/arch/i386/kernel/acpi/boot.c	2005-04-16 23:24:59.014298068 -0700
@@ -608,9 +608,11 @@
 	acpi_fadt.sci_int = fadt->sci_int;
 #endif
 
+#ifdef CONFIG_ACPI_BUS
 	/* initialize rev and apic_phys_dest_mode for x86_64 genapic */
 	acpi_fadt.revision = fadt->revision;
 	acpi_fadt.force_apic_physical_destination_mode = fadt->force_apic_physical_destination_mode;
+#endif
 
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */



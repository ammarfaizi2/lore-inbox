Return-Path: <linux-kernel-owner+w=401wt.eu-S1754318AbXACGE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbXACGE4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbXACGE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:04:56 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:59927 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbXACGEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:04:55 -0500
Date: Wed, 3 Jan 2007 11:34:52 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Len Brown <lenb@kernel.org>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: Section mismatch on current git head
Message-ID: <20070103060452.GC25433@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <458BEAA9.6010503@m3y3r.de> <200612230040.28898.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612230040.28898.lenb@kernel.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2006 at 12:40:27AM -0500, Len Brown wrote:
> 
> > WARNING: vmlinux - Section mismatch: reference to
> > .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at
> > offset 0xc010e020) and 'acpi_unmap_lsapic'
> > WARNING: vmlinux - Section mismatch: reference to
> > .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at
> > offset 0xc010e04a) and 'acpi_unmap_lsapic'
> > WARNING: vmlinux - Section mismatch: reference to
> > .init.text:mp_override_legacy_irq from .text between
> > 'acpi_sci_ioapic_setup' (at offset 0xc010e062) and 'acpi_unmap_lsapic'
> > WARNING: vmlinux - Section mismatch: reference to
> > .init.data:acpi_sci_override_gsi from .text between
> > 'acpi_sci_ioapic_setup' (at offset 0xc010e068) and 'acpi_unmap_lsapic'
> 
> The acpi_sci_ioapic_setup ones should go away with the patch below, but do no harm in the mean-time.
> cheers,
> -Len
> 
> commit 0351a612f7a46995c28d4ef6189229b5d1dfc6c3
> Author: Len Brown <len.brown@intel.com>
> Date:   Thu Dec 21 01:29:59 2006 -0500
> 
>     ACPI: fix section mis-match build warning
> 
>     Dunno why this pops out in only in the allmodconfig build.
>     Though the warning is accurate, all the callers of the flagged
>     non __init function are __init, this is not a functional change.
> 

Hi Len,

These warnings pop up on allmodconfig as CONFIG_RELOCATABLE is set.

This option retains relocation information in vmlinux file and MODPOST
goes through these relocations and generates warnings.

So till date MODPOST never cribbed about vmlinux section mismatches as
it could never detect those. But with CONFIG_RELOCATABLE=y, these mismatches
become visible to MODPOST.

Thanks
Vivek

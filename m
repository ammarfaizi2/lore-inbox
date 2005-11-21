Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVKUXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVKUXlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVKUXlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:41:23 -0500
Received: from havoc.gtf.org ([69.61.125.42]:43493 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964776AbVKUXlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:41:23 -0500
Date: Mon, 21 Nov 2005 18:41:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Josh Litherland <josh@emperorlinux.com>
Cc: linux-kernel@vger.kernel.org, research@emperorlinux.com
Subject: Re: SATA ICH6M problems on Sharp M4000
Message-ID: <20051121234119.GD24565@havoc.gtf.org>
References: <43824A6F.6070407@emperorlinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43824A6F.6070407@emperorlinux.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 05:30:07PM -0500, Josh Litherland wrote:
> Trying to get this laptop operational; it has SATA for the hard disc and
> PATA for the optical drive.  The hard drive is wired to the secondary
> IDE interface, the optical to the primary.  As it stands, driving the
> whole system with the PATA (piix) driver works, but performance for the
> hard disc is (predictably) extremely poor.

Expected behavior for combined mode, which only allows DMA for SATA.

Disabling legacy mode in BIOS should fix the performance problem, by
allowing IDE driver to fully drive PATA (including DMA), and libata to
fully drive SATA.


> With ata_piix driving the
> hard drive, performance is great, but the optical device is never
> enumerated.

Expected behavior, since the default for module option atapi_enabled
is zero (disabled).


> When the piix driver tries to load, the following occurs:
> 
> ide0: I/O resource 0x1F0-0x1F7 not free.
> ide0: ports already in use, skipping probe
> ide1: I/O resource 0x170-0x177 not free.
> ide1: ports already in use, skipping probe
> 
> We have tried to resolve this through a wide variety of kernel command
> line options.  Tried every combination we could think of of ide0=0x1f0,
> ide1=0x170, ide0=noprobe, ide1=noprobe, acpi=off, noapic, lapic,
> pci=routeirq.  Tried shaking up module load order and using ide-generic
> instead of piix.

So far everything seems to be expected behavior.


> ahci won't bind to the device; throws error -12.

Expected behavior, since your hardware doesn't seem to support AHCI.


> Some information about this system including dmesg and lspci:
> 
> http://downloads.emperorlinux.com/research/lkml/sharp_m4000/

In the future, 'lspci -n' and 'lspci -nvvv' is more useful.

	Jeff




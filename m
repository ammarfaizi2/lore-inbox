Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVHCK6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVHCK6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVHCK6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:58:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:30693 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262202AbVHCK6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:58:50 -0400
Date: Wed, 3 Aug 2005 12:58:47 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: pci cacheline size / latency oddness.
Message-ID: <20050803105847.GQ10895@wotan.suse.de>
References: <20050801233517.GA23172@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801233517.GA23172@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 07:35:17PM -0400, Dave Jones wrote:
> During boot of todays -git, I noticed this..
> 
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> 
> after boot, lspci shows..
> 
> 00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
> Subsystem: Dell: Unknown device 0169
> Flags: bus master, medium devsel, latency 0, IRQ 201
>                                           ^^						
> 
> It also complains about..
> 
> PCI: cache line size of 128 is not supported by device 0000:00:1d.7
> 
> x86-64 doesn't have an arch override for pci_cache_line_size, so
> it ends up at L1_CACHE_BYTES >> 2, which is 128 if you build
> x86-64 kernels with CONFIG_GENERIC_CPU or CONFIG_MPSC
> This means we will do the wrong thing on AMD machines which have
> 64 byte cachelines.   I saw this problem however on an em64t box.

We should be running arch/i386/pci/common.c:pcibios_init
As far as I can see that should do the right thing on x86-64 too.

> Would it make sense to shift >> once more if it fails, and retry
> with a smaller size perhaps ?

Not sure how much sense it makes to configure a PCI device
to a smaller cache line size than true. Best probably to leave
it alone in this case.

-Andi

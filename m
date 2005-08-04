Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVHDBgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVHDBgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVHDBgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:36:44 -0400
Received: from palrel10.hp.com ([156.153.255.245]:25831 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261740AbVHDBfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:35:48 -0400
Date: Wed, 3 Aug 2005 18:39:10 -0700
From: Grant Grundler <iod00d@hp.com>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
Message-ID: <20050804013910.GG16417@esmail.cup.hp.com>
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <20057281331.7vqhiAJ1Yc0um2je@cisco.com> <86802c44050803175873fb0569@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c44050803175873fb0569@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 05:58:11PM -0700, yhlu wrote:
> Roland,
> 
> In LinuxBIOS, If I enable the prefmem64 to use real 64 range. the IB
> driver in Kernel can not be loaded.

Can you provide a few more details about the configuration?
o kernel version
o architecture (i386 or x86-64)
o post the full console output from power up?

Recent email on linux-pci raised awareness that 32-bit kernel
can not support 64-bit PCI MMIO addresses. struct resource (defined in
include/linux/ioport.h) defines the start/end field as "unsigned long".
That's only 32-bit on i386 kernels.

> PCI: 04:00.0 18 <- [0xfcf0000000 - 0xfcf07fffff] prefmem64
> PCI: 04:00.0 20 <- [0xfce0000000 - 0xfcefffffff] prefmem64                      
I have to wonder if those BARs are truly prefetchable.
Does Mellanox assume CPU is the only one to write the 3rd BAR (RAM)
and the CPU implements a write-through cache (vs write back)?

I'm just guessing because I don't understand exactly how the
256MB of onboard RAM is accessed.

hth,
grant

> 
> ib_mthca: Mellanox InfiniBand HCA driver v0.06 (June 23, 2005)
> ib_mthca: Initializing Mellanox Technologies MT25208 InfiniHost III Ex (Tavor c)
> ib_mthca 0000:04:00.0: Failed to initialize queue pair table, aborting.
> ib_mthca: probe of 0000:04:00.0 failed with error -16
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general

And I have to wonder if those BARs truly are prefetchable.
It would imply only the CPU writes them and 

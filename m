Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVDFOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVDFOyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 10:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVDFOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 10:54:07 -0400
Received: from alog0161.analogic.com ([208.224.220.176]:24768 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262220AbVDFOyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 10:54:02 -0400
Date: Wed, 6 Apr 2005 10:53:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Catalin Marinas <catalin.marinas@gmail.com>
cc: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: NOMMU - How to reserve 1 MB in top of memory in a clean way
In-Reply-To: <tnxzmwc9gun.fsf@arm.com>
Message-ID: <Pine.LNX.4.61.0504061040420.22273@chaos.analogic.com>
References: <1112781027.2687.6.camel@laptop.blackstar.nl> <tnxzmwc9gun.fsf@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2005, Catalin Marinas wrote:

> Bas Vermeulen <bvermeul@blackstar.xs4all.nl> wrote:
>> I am currently working on the bfinnommu linux port for the BlackFin 533.
>> I need to grab the top 1 MB of memory so I can give it out to drivers
>> that need non-cached memory for DMA operations.
>
> I did this long time ago (on a 2.4 kernel), trying to avoid a hardware
> problem. I re-ordered the zones so that ZONE_DMA came after
> ZONE_NORMAL. Since the DMA memory was quite small (less than 1MB), I
> also put a "break" before "case ZONE_DMA" in the
> build_zonelists_node() functions to avoid the allocation fallback.
>
> -- 
> Catalin
>


1 Megabyte of DMA RAM should be available using conventional
means __get_dma_pages(GFP_KERNEL, 0x100) soon after boot.

Or just use mem= on the boot command line. This will tell
the kernel the extent of memory to use. Any RAM after that
is available. Your driver can access kernel variable, "num_physpages"
to find the last page it is supposed to use. Some kernel versions
actually touch the next page so, to be safe, your code can
use:
    mem = (num_physpages * PAGE_SIZE) + PAGE_SIZE;
... for the first available free RAM.

Note that there may be PCI BARS allocated in this address-space if
you have 4 Gb of RAM. You need to be carefull.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

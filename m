Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWCWShx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWCWShx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWCWShx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:37:53 -0500
Received: from cantor2.suse.de ([195.135.220.15]:18886 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932525AbWCWShx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:37:53 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the e820 table
Date: Thu, 23 Mar 2006 18:56:11 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1143138170.3147.43.camel@laptopd505.fenrus.org>
In-Reply-To: <1143138170.3147.43.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231856.12227.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 19:22, Arjan van de Ven wrote:
> Hi,
> 
> There have been several machines that don't have a working MMCONFIG,
> often because of a buggy MCFG table in the ACPI bios. This patch adds a
> simple sanity check that detects a whole bunch of these cases, and when
> it detects it, linux now boots rather than crash-and-burns. 

Yes, MCFG is a pain recently. Looks like we did the grave mistake
of using something in the BIOS before Windows again.

> +
> +/*
> + * Check if an address is reserved in the e820 map
> + */
> +int is_e820_reserved(u64 address)
> +{
> +	int	      i;
> +	i = e820.nr_map;
> +	while (--i >= 0) {
> +		unsigned long long start = e820.map[i].addr;
> +		unsigned long long end = start + e820.map[i].size;
> +
> +		if (address <=end && address >= start) {
> +			if (e820.map[i].type == E820_RESERVED)
> +				return 1;
> +			else
> +				return 0;
> +		}
> +	}
> +	return 0;
> +}

That is e820_mapped(address, address+size, E820_RESERVED)

And not having a size is definitely wrong on i386 too.

-Andi


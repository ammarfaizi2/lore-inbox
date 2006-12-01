Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936072AbWLAHz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936072AbWLAHz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936100AbWLAHz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:55:58 -0500
Received: from brick.kernel.dk ([62.242.22.158]:2672 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S936072AbWLAHyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:54:55 -0500
Date: Fri, 1 Dec 2006 08:55:20 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch]VMSPLIT_2G conflicts with PAE
Message-ID: <20061201075520.GD5400@kernel.dk>
References: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01 2006, Shaohua Li wrote:
> PAGE_OFFSET is 0x78000000 with VMSPLIT_2G, this address is in the middle
> of the second pgd entry with pae enabled. This breaks assumptions
> (address is aligned to pgd entry's address) in a lot of places like
> pagetable_init. Fixing the assumptions is hard (eg, low mapping). SO I
> just changed the address to 0x80000000.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> index 8ff1c6f..fddfb26 100644
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -532,7 +532,7 @@ endchoice
>  config PAGE_OFFSET
>  	hex
>  	default 0xB0000000 if VMSPLIT_3G_OPT
> -	default 0x78000000 if VMSPLIT_2G
> +	default 0x80000000 if VMSPLIT_2G
>  	default 0x40000000 if VMSPLIT_1G
>  	default 0xC0000000

0x78000000 was chosen since it gives you the full 2G as low memory, if
you mave it 0x80000000 then you still have a little highmem and need
that turned on.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424127AbWLBQih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424127AbWLBQih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 11:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424120AbWLBQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 11:38:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54545 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1163075AbWLBQiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 11:38:18 -0500
Date: Sat, 2 Dec 2006 13:05:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch]VMSPLIT_2G conflicts with PAE
Message-ID: <20061202130544.GC4773@ucw.cz>
References: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

Do we allow user entering arbitrary value here? In any case, it would
be nice to document alignment requirements of this one, because
otherwise someone *will* get it wrong.

-- 
Thanks for all the (sleeping) penguins.

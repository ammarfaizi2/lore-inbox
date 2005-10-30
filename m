Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVJ3TcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVJ3TcU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVJ3TcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:32:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43418 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932223AbVJ3TcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:32:16 -0500
Date: Sun, 30 Oct 2005 20:23:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 bitops fix for -Os
Message-ID: <20051030192323.GF657@openzaurus.ucw.cz>
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patches fixes a bug that comes up when compiling the kernel for
> x86_64 optimizing for size.  It affects 2.6.14 for sure, but I'm
> pretty sure many earlier kernels are affected as well.

Is the same problem in i386, too?

> --- arch/x86_64/lib/bitops.c~	2005-10-27 22:02:08.000000000 -0200
> +++ arch/x86_64/lib/bitops.c	2005-10-29 18:24:27.000000000 -0200
> @@ -1,5 +1,11 @@
>  #include <linux/bitops.h>
>  
> +#define BITOPS_CHECK_UNDERFLOW_RANGE 0
> +
> +#if BITOPS_CHECK_UNDERFLOW_RANGE
> +# include <linux/kernel.h>
> +#endif

Could you drop the ifdefs? Nice for debugging but we don't
want them in mainline.

Plus you want to add signed-off-by: header and send it to ak@suse.de.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


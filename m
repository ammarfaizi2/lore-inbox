Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271910AbRIYWJh>; Tue, 25 Sep 2001 18:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRIYWJ1>; Tue, 25 Sep 2001 18:09:27 -0400
Received: from [195.223.140.107] ([195.223.140.107]:23280 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S271844AbRIYWJQ>;
	Tue, 25 Sep 2001 18:09:16 -0400
Date: Wed, 26 Sep 2001 00:09:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        Jacek =?iso-8859-1?Q?=5Biso-8859-2=5D_Pop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926000922.I8350@athlon.random>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Sep 24, 2001 at 09:38:24AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 09:38:24AM -0300, Marcelo Tosatti wrote:
> --- linux.orig/mm/vmscan.c	Mon Sep 24 10:36:40 2001
> +++ linux/mm/vmscan.c	Mon Sep 24 10:54:01 2001
> @@ -567,6 +567,9 @@
>  		if (nr_pages <= 0)
>  			return 1;
>  
> +		if (nr_pages < SWAP_CLUSTER_MAX)
> +			ret |= 1;
> +

too much permissive (vm-tweaks-1 does something similar but not that
permissive)

>  		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
>  	} while (--priority);
>  
> --- linux.orig/mm/page_alloc.c	Mon Sep 24 10:36:40 2001
> +++ linux/mm/page_alloc.c	Mon Sep 24 10:44:12 2001
> @@ -400,7 +400,7 @@
>  			if (!z)
>  				break;
>  
> -			if (zone_free_pages(z, order) > z->pages_high) {
> +			if (zone_free_pages(z, order) > z->pages_min) {

that breaks oom detection.

Andrea

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUEWK4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUEWK4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEWK4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:56:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:25865 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262329AbUEWKyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:54:05 -0400
Date: Sun, 23 May 2004 20:53:51 +1000
To: Leonardo Macchia <leo@bononia.it>, 250477@bugs.debian.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#250477: kernel-source-2.4.26: Lots of debug in RAID5
Message-ID: <20040523105351.GB19402@gondor.apana.org.au>
References: <20040523085801.2878013C002@nomade.ciram.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523085801.2878013C002@nomade.ciram.unibo.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 10:58:00AM +0200, Leonardo Macchia wrote:
> Package: kernel-source-2.4.26
> Version: 2.4.26-2
> Severity: wishlist
> Tags: patch
> 
> If I use XFS on the top of RAID5 device, I get lots of:
> 
> raid5: switching cache buffer size, 0 --> 4096
> 
> and similar.
> Looking at the sources, I see a "printk" instead of "PRINTK" for this
> debug line. Maybe it is a mistake? However this is the simple patch to
> change it:
> 
> diff -Naru kernel-source-2.4.26/drivers/md/raid5.c kernel-source-2.4.26-nodebug/drivers/md/raid5.c
> --- kernel-source-2.4.26/drivers/md/raid5.c	2003-08-30 06:01:38.000000000 +0000
> +++ kernel-source-2.4.26-nodebug/drivers/md/raid5.c	2004-05-23 08:54:36.000000000 +0000
> @@ -282,7 +282,7 @@
>  				}
>  
>  				if (conf->buffer_size != size) {
> -					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> +					PRINTK("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
>  					shrink_stripe_cache(conf);
>  					if (size==0) BUG();
>  					conf->buffer_size = size;

Thanks for the patch.  This does indeed look like a typo.

Hi Neil, does this patch look OK to you?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

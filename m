Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWGSMxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWGSMxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGSMxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:53:23 -0400
Received: from ozlabs.org ([203.10.76.45]:19656 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964805AbWGSMxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:53:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17598.10992.445446.148411@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jul 2006 22:52:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
In-Reply-To: <20060719004659.GA30823@lumumba.uhasselt.be>
References: <20060719004659.GA30823@lumumba.uhasselt.be>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris writes:

> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index 1507d19..48c6f83 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -2995,12 +2995,11 @@ static int __devinit atyfb_setup_sparc(s
>  		/* nothing */ ;
>  	j = i + 4;
>  
> -	par->mmap_map = kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
> +	par->mmap_map = kcalloc(j, sizeof(*par->mmap_map), GFP_ATOMIC);
>  	if (!par->mmap_map) {
>  		PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
>  		return -ENOMEM;
>  	}
> -	memset(par->mmap_map, 0, j * sizeof(*par->mmap_map));

What exactly do we gain by using kcalloc rather than kzalloc here?
There is no potential overflow issue to worry about.

> @@ -464,7 +463,7 @@ #ifdef __sparc__
>  	 * one additional region with size == 0. 
>  	 */
>  
> -	par->mmap_map = kmalloc(4 * sizeof(*par->mmap_map), GFP_ATOMIC);
> +	par->mmap_map = kcalloc(4, sizeof(*par->mmap_map), GFP_ATOMIC);

Likewise.

Paul.

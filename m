Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVATUcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVATUcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVATUcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:32:24 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:16403 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261928AbVATUaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:30:19 -0500
Date: Fri, 21 Jan 2005 07:27:59 +1100
To: linux-kernel@vger.kernel.org, tv@lio96.de, jgarzik@pobox.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.29] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050120202759.GA32453@gondor.apana.org.au>
References: <20050120202258.GA7687@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120202258.GA7687@tuxdriver.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 03:22:59PM -0500, John W. Linville wrote:
>  
> +	/* if we are currently stopped, then our CIV is actually set to our
> +	 * *last* sg segment and we are ready to wrap to the next.  However,
> +	 * if we set our LVI to the last sg segment, then it won't wrap to
> +	 * the next sg segment, it won't even get a start.  So, instead, when
> +	 * we are stopped, we set both the LVI value and also we increment
> +	 * the CIV value to the next sg segment to be played so that when
> +	 * we call start, things will operate properly
> +	 */
>  	if (!dmabuf->enable && dmabuf->ready) {
>  		if (!(dmabuf->trigger & trigger))
>  			return;
>  
> +		CIV_TO_LVI(state->card, port, 1);
> +

BTW, I think you want to fix up the last sentence in the comment.
It doesn't seem to correspond to what the code is doing.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

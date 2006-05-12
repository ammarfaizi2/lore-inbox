Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWELPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWELPRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWELPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:17:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43963 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932125AbWELPRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:17:01 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [patch 9/9] Add bcm43xx HW RNG support
Date: Fri, 12 May 2006 18:16:54 +0300
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
References: <20060512103522.898597000@bu3sch.de> <20060512103649.060196000@bu3sch.de>
In-Reply-To: <20060512103649.060196000@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121816.55025.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 13:35, Michael Buesch wrote:
> +static int bcm43xx_rng_read(struct hwrng *rng, u32 *data)
> +{
> +	struct bcm43xx_private *bcm = (struct bcm43xx_private *)rng->priv;
> +	unsigned long flags;
> +
> +	bcm43xx_lock(bcm, flags);
> +	*data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG);

You are storing random 16-bit value _and_ 16 zero bits
into 32-bit memory location. Probably not a problem for
little-endian machine (you return 2, indicating that there
are only 2 bytes of randomness), but on big endian?

Didn't you mean

	*(u16*)data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG); ?

> +	bcm43xx_unlock(bcm, flags);
> +
> +	return (sizeof(u16));
> +}

--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWELUoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWELUoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWELUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:44:11 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:4042
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932233AbWELUoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:44:10 -0400
From: Michael Buesch <mb@bu3sch.de>
To: bcm43xx-dev@lists.berlios.de
Subject: Re: [patch 9/9] Add bcm43xx HW RNG support
Date: Fri, 12 May 2006 22:51:52 +0200
User-Agent: KMail/1.9.1
References: <20060512103522.898597000@bu3sch.de> <20060512103649.060196000@bu3sch.de> <200605121816.55025.vda@ilport.com.ua>
In-Reply-To: <200605121816.55025.vda@ilport.com.ua>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605122251.52561.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 17:16, Denis Vlasenko wrote:
> On Friday 12 May 2006 13:35, Michael Buesch wrote:
> > +static int bcm43xx_rng_read(struct hwrng *rng, u32 *data)
> > +{
> > +	struct bcm43xx_private *bcm = (struct bcm43xx_private *)rng->priv;
> > +	unsigned long flags;
> > +
> > +	bcm43xx_lock(bcm, flags);
> > +	*data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG);
> 
> You are storing random 16-bit value _and_ 16 zero bits
> into 32-bit memory location. Probably not a problem for
> little-endian machine (you return 2, indicating that there
> are only 2 bytes of randomness), but on big endian?
> 
> Didn't you mean
> 
> 	*(u16*)data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG); ?


Nope, the code is correct.

-- 
Greetings Michael.

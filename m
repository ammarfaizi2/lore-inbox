Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272567AbTHNRI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTHNRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:08:58 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:8973 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S272567AbTHNRIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:08:55 -0400
Date: Fri, 15 Aug 2003 03:08:12 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
In-Reply-To: <20030814071519.GJ325@waste.org>
Message-ID: <Mutt.LNX.4.44.0308150301500.25141-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, Matt Mackall wrote:

> It's basically trying to be friendly. Since we can't really detect
> when it's safe to do such yields, we should be explicitly flag the
> uses where its ok. Something like this:

I think this is the best approach.

>  #define CRYPTO_TFM_MODE_MASK		0x000000ff
>  #define CRYPTO_TFM_REQ_MASK		0x000fff00
> -#define CRYPTO_TFM_RES_MASK		0xfff00000
> +#define CRYPTO_TFM_RES_MASK		0x7ff00000
> +#define CRYPTO_TFM_API_MASK		0x80000000

This doesn't leave much room for API flags -- the CRYPTO_TFM_REQ_MASK 
could be made smaller.


- James
-- 
James Morris
<jmorris@intercode.com.au>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVA3ADD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVA3ADD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVA3ADD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:03:03 -0500
Received: from waste.org ([216.27.176.166]:47583 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261614AbVA3ACg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:02:36 -0500
Date: Sat, 29 Jan 2005 16:02:21 -0800
From: Matt Mackall <mpm@selenic.com>
To: Fruhwirth Clemens <clemens-dated-1107431870.41eb@endorphin.org>
Cc: akpm@osdl.org, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/04] Add LRW
Message-ID: <20050130000221.GA2955@waste.org>
References: <20050124115750.GA21883@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124115750.GA21883@ghanima.endorphin.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 12:57:50PM +0100, Fruhwirth Clemens wrote:
> This is the core of my LRW patch. Added test vectors.
> http://grouper.ieee.org/groups/1619/email/pdf00017.pdf

Please include a URL for the standard at the top of the LRW code and
next to the test vectors. I had to search around a fair bit for decent
background material, would be helpful to a couple other references as
well.

> +static inline void findAlignment(u128 callersN, int value, int *align) {
> +	int i;

Your gfmulseq code has lots of StudlyCaps and strange whitespace, eg
this '{' should be on the next line.

> +	/* Copy N, so lsr does not destroy caller's copy */
> +	u128_alloc(N);
> +	copy128(N,callersN);

The usage of your u128 type is really confusing, so 'u128' is an
especially bad name. I expect u128 to work like u64 and u32. I propose
gf128_t.

> +	int i;			// Outer control loop counter

C++ comments.

> +#define min(a,b) (a)<(b)?(a):(b)

Have a very nice one of those already.

> +#ifdef DEBUG
> +	printf("negative step at:");
> +	print128(currentN);
> +#endif

Better to use printk and put #define printk printf in your userspace
test harness.

> +typedef u64 *u128;
> +typedef u64 *u128_t;

Did I mention confusing?

> +#define u128_alloc(VAR) u64 _ ## VAR ## _[2]; u128 VAR = _ ## VAR ## _

Wrap this in a struct, please. That's disgusting.

> -obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \
> +obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o lrw.o gfmulseq.o \

LRW and the GF(2**128) code is not configurable?

-- 
Mathematics is the supreme nostalgia of our time.

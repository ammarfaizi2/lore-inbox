Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVLNO2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVLNO2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVLNO2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:28:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18699 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932536AbVLNO2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:28:11 -0500
Date: Wed, 14 Dec 2005 14:28:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <briglia.anderson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] [RFC] Add MMC password protection (lock/unlock) support
Message-ID: <20051214142804.GB7124@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <briglia.anderson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <e55525570512140531k110169fal9b8b6423b022aafc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55525570512140531k110169fal9b8b6423b022aafc@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:31:33AM -0400, Anderson Briglia wrote:
> +	data.blksz_bits = blksz_bits(data_size);
> +	data.blocks = 1;

See my comments in your first mail about this.

> --- linux-2.6.14-omap2.orig/include/linux/mmc/card.h	2005-12-13 11:41:08.000000000 -0400
> +++ linux-2.6.14-omap2/include/linux/mmc/card.h	2005-12-13 11:42:06.000000000 -0400
> @@ -10,6 +10,7 @@
>  #ifndef LINUX_MMC_CARD_H
>  #define LINUX_MMC_CARD_H
>  
> +#include <linux/key.h>
>  #include <linux/mmc/mmc.h>
>  
>  struct mmc_cid {
> @@ -109,4 +110,6 @@ static inline int mmc_card_claim_host(st
>  
>  #define mmc_card_release_host(c)	mmc_release_host((c)->host)
>  
> +extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
> +
>  #endif

Given that you're not using the contents of struct key, please don't
include <linux/key.h> here - it adds unnecessary include dependencies.

Instead, use a forward declaration:

struct key;

extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWJILzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWJILzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWJILzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:55:12 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:61943 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S932633AbWJILzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:55:11 -0400
Date: Mon, 9 Oct 2006 20:55:26 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] crypto: fix crypto_alloc_{tfm,base}() return value
Message-ID: <20061009115526.GA10857@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
References: <20061009085812.GA6020@localhost> <20061009111446.GA22020@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009111446.GA22020@gondor.apana.org.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:14:46PM +1000, Herbert Xu wrote:

> Actually, crypto_alloc_tfm is an obsolete function which is supposed
> to maintain its previous semantics of returning NULL or success.

I misunderstood about crypto_alloc_tfm().

BTW, ecryptfs and reiser4 are still using crypto_alloc_tfm().
Should we mark it as __deprecated?

> I don't quite see where the problem with crypto_alloc_base is.

- __crypto_alloc_tfm() should return -ENOMEM on kzalloc() failure.
  But it returns NULL.

- crypto_alloc_base() may not return -EINTR on signal_pending()

I'll fix the patch and resend with more clear description later.


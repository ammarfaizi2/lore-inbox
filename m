Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272066AbTHNAVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272067AbTHNAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:21:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29371 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272066AbTHNAVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:21:22 -0400
Message-ID: <3F3AD5F1.8000901@pobox.com>
Date: Wed, 13 Aug 2003 20:21:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
References: <20030813233957.GE325@waste.org>
In-Reply-To: <20030813233957.GE325@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> We need in_atomic() so that we can call from regions where preempt is
> disabled, for instance when using per_cpu crypto tfms.
> 
> diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
> --- orig/crypto/internal.h	2003-07-13 22:29:11.000000000 -0500
> +++ work/crypto/internal.h	2003-08-12 14:38:54.000000000 -0500
> @@ -37,7 +37,7 @@
>  
>  static inline void crypto_yield(struct crypto_tfm *tfm)
>  {
> -	if (!in_softirq())
> +	if (!in_atomic())
>  		cond_resched();


Do you really want to schedule inside preempt_disable() ?

As an aside, I think it would be nice if cond_resched could figure out 
for itself whether it is ok to schedule().  Completely eliminate the 
above test entirely, moving it into cond_resched().

	Jeff




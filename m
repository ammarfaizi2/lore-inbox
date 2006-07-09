Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWGIO7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWGIO7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWGIO7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:59:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:50988 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030280AbWGIO7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:59:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=glem+gM8+m241KAhnxOn0vd+n8F3RCRDHZmhaQADCrMzezKCz+v9M0EOztr2MAOdhimx0LYL7t7JlBm6Nbw8GyI2SWWTbxzOz2duAACB9zsQb9FvIYXV8TuTETnCy/kkVQ4VPBihI0HBDFmra14/8RoJjbne8WRNfYDelhUt1sE=
Message-ID: <84144f020607090759o176f35edg603a26cb9c752e6e@mail.gmail.com>
Date: Sun, 9 Jul 2006 17:59:42 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [RFC 1/4] kevent: core files.
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060709132446.GB29435@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060709132446.GB29435@2ka.mipt.ru>
X-Google-Sender-Auth: 4f18cd9a4fdff0b0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> +struct kevent *kevent_alloc(gfp_t mask)
> +{
> +       struct kevent *k;
> +
> +       if (kevent_cache)
> +               k = kmem_cache_alloc(kevent_cache, mask);
> +       else
> +               k = kzalloc(sizeof(struct kevent), mask);
> +
> +       return k;
> +}

What's this for? Why would kevent_cache be NULL? Note that you can use
kmem_cache_zalloc() for fixed size allocations that need to be zeroed.

On 7/9/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> +
> +void kevent_free(struct kevent *k)
> +{
> +       memset(k, 0xab, sizeof(struct kevent));

Why is slab poisoning not sufficient?

> +       if (kevent_cache)
> +               kmem_cache_free(kevent_cache, k);
> +       else
> +               kfree(k);
> +}

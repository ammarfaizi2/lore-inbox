Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVCHBpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVCHBpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVCHBl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:41:58 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:39093 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261888AbVCGWky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:40:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V2zKsEym9puquZviE/wtUzKDeT3zfSuOJrdYCrxEIW/rD/LbxCs48Cahoe4LbWp79VCQ2atnhfDruwz2yYgU/nR3znoiBspNqOzpMIAmwXE1b17iWdcO+GQFAHX4XxiwueTh+sl5ErwKkZC7eSxptcNZi0HoKLCCVXKIg3Gp8bE=
Message-ID: <29495f1d0503071440562f054@mail.gmail.com>
Date: Mon, 7 Mar 2005 14:40:52 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [8/many] acrypto: crypto_dev.c
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110227854480@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <11102278542733@2ka.mipt.ru> <1110227854480@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005 23:37:34 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> --- /tmp/empty/crypto_dev.c     1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/crypto_dev.c      2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,421 @@
> +/*
> + *     crypto_dev.c

<snip>

> +                       while (atomic_read(&__dev->refcnt)) {
> +
> +                               dprintk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
> +                                       __dev->name, atomic_read(&dev->refcnt));
> +
> +                               /*
> +                                * Hack zone: you need to write good ->data_ready()
> +                                * and crypto device driver itself.
> +                                *
> +                                * Driver shoud not buzz if it has pending sessions
> +                                * in it's queue and it was removed from global device list.
> +                                *
> +                                * Although I can workaround it here, for example by
> +                                * flushing the whole queue and drop all pending sessions.
> +                                */
> +
> +                               __dev->data_ready(__dev);
> +                               set_current_state(TASK_UNINTERRUPTIBLE);
> +                               schedule_timeout(HZ);

I don't see any wait-queues in the immediate area of this code. Can
this be an ssleep(1)?

Thanks,
Nish

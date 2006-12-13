Return-Path: <linux-kernel-owner+w=401wt.eu-S964989AbWLMPDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWLMPDN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWLMPDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:03:13 -0500
Received: from uhweb15152.united-hoster.com ([85.88.15.152]:60391 "EHLO
	uhweb15152.united-hoster.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964989AbWLMPDM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:03:12 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 10:03:12 EST
Message-ID: <20061213155531.1kpbmi3pk40kkoos@webmail.kernalert.de>
Date: Wed, 13 Dec 2006 15:55:31 +0100
From: Frank Seidel <frank@kernalert.de>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] Add MMC Password Protection (lock/unlock) support
	V8: mmc_key_retention.diff
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anderson Briglia <anderson.briglia@indt.org.br>:
> [...]
Hi,
thats really cool stuff you're providing with your patches. :)
I have some feedback or questions some parts here.
But as i just started trying to get into kernelhacking you probably
better don't take my notes to serious, please.

> Index: linux-linus-2.6/drivers/mmc/mmc_sysfs.c
> ===================================================================
> --- linux-linus-2.6.orig/drivers/mmc/mmc_sysfs.c        2006-12-04 [...]
> +static int mmc_key_instantiate(struct key *key, const void *data,   
> size_t datalen)
> +{
> +        struct mmc_key_payload *mpayload, *zap;
> +        int ret;
> +
> +        zap = NULL;
What is zap here for? future use?
And wouldn't it be good to also initialize mplayload here?

> +        ret = -EINVAL;
Is there a special reason why you already assign the errors to the
return value variable before its clear that the assignment is needed?


> +        if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data) {
Isn't the last "|| !data" redundant as you already tested if datalen ==0?

> +                pr_debug("Invalid data\n");
> +                goto error;
> +        }
> +
> +        ret = key_payload_reserve(key, datalen);
> +        if (ret < 0) {
> +                pr_debug("ret = %d\n", ret);
> +                goto error;
> +        }
> +
> +        ret = -ENOMEM;
Same as above: Why do you in any case want to assign it here?

> +        mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
I may be totally wrong, but is dereferencing a not initialized pointer
(even just for using sizeof) really ok? Wouldn't it be safer to use
a sizeof(struct mmc_key_payload) here?

Thanks,
Frank



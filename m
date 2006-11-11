Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947118AbWKKGrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947118AbWKKGrd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 01:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947117AbWKKGrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 01:47:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11785 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1947118AbWKKGrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 01:47:32 -0500
Date: Sat, 11 Nov 2006 05:50:50 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org, devel@openvz.org,
       oleg@tv-sign.ru, hch@infradead.org, matthltc@us.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 6/13] BC: kmemsize accounting (core)
Message-ID: <20061111055049.GA4063@ucw.cz>
References: <45535C18.4040000@sw.ru> <45535EA3.10300@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45535EA3.10300@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- /dev/null	2006-07-18 14:52:43.075228448 +0400
> +++ ./include/bc/kmem.h	2006-11-03 15:48:26.000000000 +0300
> @@ -0,0 +1,48 @@
> +/*
> + * include/bc/kmem.h
> + *
> + * Copyright (C) 2006 OpenVZ SWsoft Inc
> + *
> + */

GPL would be nice, as would be email address of someone who worked on
this file.


> --- /dev/null	2006-07-18 14:52:43.075228448 +0400
> +++ ./kernel/bc/kmem.c	2006-11-03 15:48:26.000000000 +0300
> @@ -0,0 +1,112 @@
> +/*
> + * kernel/bc/kmem.c
> + *
> + * Copyright (C) 2006 OpenVZ SWsoft Inc
> + *
> + */

Same here.

> +void bc_slab_uncharge(kmem_cache_t *cachep, void *objp)
> +{
> +	unsigned int size;
> +	struct beancounter *bc, **slab_bcp;
> +
> +	slab_bcp = kmem_cache_bcp(cachep, objp);
> +	if (*slab_bcp == NULL)
> +		return;
> +
> +	bc = *slab_bcp;

You can do this before if() and spare a dereference.

						Pavel
-- 
Thanks for all the (sleeping) penguins.

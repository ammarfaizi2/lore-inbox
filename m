Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVLMVkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVLMVkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVLMVkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:40:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030219AbVLMVkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:40:02 -0500
Date: Tue, 13 Dec 2005 13:39:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab gcc fix
Message-Id: <20051213133942.1f742685.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512131327140.23733@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512131327140.23733@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> Since we no longer support 2.95, we can get rid of this ugly thing.
> 
>  Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
>  Index: linux-2.6.15-rc5-mm2/mm/slab.c
>  ===================================================================
>  --- linux-2.6.15-rc5-mm2.orig/mm/slab.c	2005-12-13 13:18:48.000000000 -0800
>  +++ linux-2.6.15-rc5-mm2/mm/slab.c	2005-12-13 13:19:11.000000000 -0800
>  @@ -265,11 +265,10 @@ struct array_cache {
>   	unsigned int batchcount;
>   	unsigned int touched;
>   	spinlock_t lock;
>  -	void *entry[0];		/*
>  +	void *entry[];		/*

There are hundreds of instances of this under include/.  I think we just
live with it.

Plus the gcc-2.95 abandonment is tentative for now, so let's not go nuts. 
It's conceivable that someone has a good reason for needing it retained - we'll
see.

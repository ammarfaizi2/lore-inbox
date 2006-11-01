Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWKAUGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWKAUGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbWKAUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:06:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750936AbWKAUGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:06:54 -0500
Date: Wed, 1 Nov 2006 12:06:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: dri-devel@lists.sourceforge.net, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use printk_ratelimit() inside DRM_DEBUG
Message-Id: <20061101120616.3274bb37.akpm@osdl.org>
In-Reply-To: <20061101135051.GH17565@redhat.com>
References: <20061101135051.GH17565@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 10:50:51 -0300
Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> the DRM_DEBUG macro can be called within functions very oftenly
> triggered, thus generating lots of message load and potentially
> compromising system
> 
> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
> 
> -- 
> Glauber de Oliveira Costa
> Red Hat Inc.
> "Free as in Freedom"
> 
> 
> [drm_debug.patch  text/plain (444B)]
> --- linux-2.6.18.x86_64/drivers/char/drm/drmP.h.orig	2006-11-01 08:00:18.000000000 -0500
> +++ linux-2.6.18.x86_64/drivers/char/drm/drmP.h	2006-11-01 08:06:27.000000000 -0500
> @@ -185,7 +185,7 @@
>  #if DRM_DEBUG_CODE
>  #define DRM_DEBUG(fmt, arg...)						\
>  	do {								\
> -		if ( drm_debug )			\
> +		if ( drm_debug && printk_ratelimit() )			\
>  			printk(KERN_DEBUG				\
>  			       "[" DRM_NAME ":%s] " fmt ,	\
>  			       __FUNCTION__ , ##arg);			\


DRM_DEBUG() should be disabled in production code, and enabled only when
developers are developing stuff.  In the latter case, the developer wants
to see all the messages.

IOW, don't load the drm module with the `debug' parameter.

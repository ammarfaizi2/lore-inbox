Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWIMQQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWIMQQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWIMQQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:16:08 -0400
Received: from xenotime.net ([66.160.160.81]:11983 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750970AbWIMQQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:16:05 -0400
Date: Wed, 13 Sep 2006 09:17:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] kmemdup: introduce
Message-Id: <20060913091711.aa4021f0.rdunlap@xenotime.net>
In-Reply-To: <20060909013555.GC5192@martell.zuzino.mipt.ru>
References: <20060909013555.GC5192@martell.zuzino.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2006 05:35:55 +0400 Alexey Dobriyan wrote:

> Not tested yet, this is for semantics commentary.
> 
>  include/linux/string.h |    1 +
>  mm/util.c              |   18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -40,6 +40,24 @@ char *kstrdup(const char *s, gfp_t gfp)
>  }
>  EXPORT_SYMBOL(kstrdup);
>  
> +/**
> + * kmemdup - duplicate region of memory
> + *

No blank line here, please.  kernel-doc "language" doesn't allow
that.  Hopefully that will be fixed someday.

> + * @src: memory region to duplicate
> + * @len: memory region length
> + * @gfp: GFP mask to use
> + */
> +void *kmemdup(const void *src, size_t len, gfp_t gfp)
> +{
> +	void *p;
> +
> +	p = ____kmalloc(len, gfp);
> +	if (p)
> +		memcpy(p, src, len);
> +	return p;
> +}
> +EXPORT_SYMBOL(kmemdup);

---
~Randy

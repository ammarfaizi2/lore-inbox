Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTHYQZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTHYQZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:25:39 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:47539 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261957AbTHYQZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:25:36 -0400
Date: Mon, 25 Aug 2003 12:25:32 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Dan Aloni <da-x@gmx.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825122532.J10720@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030825161435.GB8961@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825161435.GB8961@callisto.yi.org>; from da-x@gmx.net on Mon, Aug 25, 2003 at 07:14:35PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 07:14:35PM +0300, Dan Aloni wrote:
> diff -Nru a/lib/string.c b/lib/string.c
> --- a/lib/string.c	Mon Aug 25 19:03:26 2003
> +++ b/lib/string.c	Mon Aug 25 19:03:26 2003
> @@ -582,3 +582,19 @@
>  }
>  
>  #endif
> +
> +/**
> + * strdup - Allocate a copy of a string.
> + * @s: The string to copy. Must not be NULL.
> + *
> + * returns the address of the allocation, or NULL on
> + * error. 
> + */
> +char *strdup(const char *s)
> +{
> +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> +	if (rv)
> +		strcpy(rv, s);
> +	return rv;
> +}
> +EXPORT_SYMBOL(strdup);

Better save strlen(s)+1 in a local size_t variable and use memcpy instead
of strcpy.

	Jakub

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbULEQFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbULEQFS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULEQFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:05:17 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:248 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261211AbULEQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:05:07 -0500
From: Kernel Stuff <kernel-stuff@comcast.net>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
Date: Sun, 5 Dec 2004 11:05:10 -0500
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de>
In-Reply-To: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412051105.10934.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   *	May not be called in interrupt context 
Does this need to change to 
      * Must not be called in interrupt context 
?
Is there a case where it is guaranteed that kfree will not sleep? "May" sounds 
to me like "You can call it in interrupt ctx, but it is not recommended", 
whereas calling it in interrupt ctx is definitely not recommended.

Parag

On Sunday 05 December 2004 10:33 am, Manfred Spraul wrote:
> Hi Andrew,
>
> I think it's worth to explicitely mention that kfree(NULL) is valid - too
> many users have/had their own (unnecessary) if(ptr) checks.
>
> Pekka wrote:
> > This patch adds comments for kfree() and vfree() stating that both
> > accept NULL pointers.
> >
> > Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>
> Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
>
> ---
>
>  slab.c    |    2 ++
>  vmalloc.c |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> Index: 2.6.10-rc2/mm/slab.c
> ===================================================================
> --- 2.6.10-rc2.orig/mm/slab.c	2004-11-27 14:33:14.000000000 +0200
> +++ 2.6.10-rc2/mm/slab.c	2004-11-27 16:12:54.573387384 +0200
> @@ -2535,6 +2535,8 @@
>   * kfree - free previously allocated memory
>   * @objp: pointer returned by kmalloc.
>   *
> + * If @objp is NULL, no operation is performed.
> + *
>   * Don't free memory not originally allocated by kmalloc()
>   * or you will run into trouble.
>   */
> Index: 2.6.10-rc2/mm/vmalloc.c
> ===================================================================
> --- 2.6.10-rc2.orig/mm/vmalloc.c	2004-11-27 16:13:48.026261312 +0200
> +++ 2.6.10-rc2/mm/vmalloc.c	2004-11-27 16:14:04.875699808 +0200
> @@ -389,7 +389,8 @@
>   *	@addr:		memory base address
>   *
>   *	Free the virtually contiguous memory area starting at @addr, as
> - *	obtained from vmalloc(), vmalloc_32() or __vmalloc().
> + *	obtained from vmalloc(), vmalloc_32() or __vmalloc(). If @addr is
> + *	NULL, no operation is performed.
>   *
>   *	May not be called in interrupt context.
>   */
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

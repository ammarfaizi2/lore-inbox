Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUKGXkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUKGXkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 18:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUKGXkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 18:40:21 -0500
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:36540 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261245AbUKGXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 18:40:12 -0500
Subject: Re: [patch] inotify: add FIONREAD support
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1099702814.6034.273.camel@localhost>
References: <1099696444.6034.266.camel@localhost>
	 <20041106004755.GA23981@kroah.com>  <1099702663.6034.270.camel@localhost>
	 <1099702814.6034.273.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 07 Nov 2004 18:41:24 -0500
Message-Id: <1099870884.5716.0.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2004.11.6.0
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

John

On Fri, 2004-11-05 at 20:00 -0500, Robert Love wrote:
> On Fri, 2004-11-05 at 19:57 -0500, Robert Love wrote:
> 
> > Why?  p is annotated __user.
> 
> Oh, but I typecast that away.  Doh.
> 
> 	Robert Love
> 
> 
> Add FIONREAD support to inotify, take two.  Strawberries.
> 
>  drivers/char/inotify.c |    6 ++++++
>  1 files changed, 6 insertions(+)
> 
> diff -urN linux-2.6.10-rc1-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
> --- linux-2.6.10-rc1-inotify/drivers/char/inotify.c	2004-11-05 17:26:52.182836608 -0500
> +++ linux/drivers/char/inotify.c	2004-11-05 18:01:54.755197024 -0500
> @@ -35,6 +35,8 @@
>  #include <linux/writeback.h>
>  #include <linux/inotify.h>
>  
> +#include <asm/ioctls.h>
> +
>  static atomic_t watch_count;
>  static atomic_t inotify_cookie;
>  static kmem_cache_t *watch_cachep;
> @@ -879,6 +881,7 @@
>  	struct inotify_device *dev;
>  	struct inotify_watch_request request;
>  	void __user *p;
> +	int bytes;
>  	s32 wd;
>  
>  	dev = fp->private_data;
> @@ -893,6 +896,9 @@
>  		if (copy_from_user(&wd, p, sizeof (wd)))
>  			return -EFAULT;
>  		return inotify_ignore(dev, wd);
> +	case FIONREAD:
> +		bytes = dev->event_count * sizeof (struct inotify_event);
> +		return put_user(bytes, (int __user *) p);
>  	default:
>  		return -ENOTTY;
>  	}
> 
> 
> 
-- 
John McCutchan <ttb@tentacle.dhs.org>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUBGBP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUBGBP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:15:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:57049 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265804AbUBGBPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:15:55 -0500
Date: Fri, 6 Feb 2004 17:15:44 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207011544.GC4492@kroah.com>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
> --- linus-2.6/drivers/video/fbmem.c	2004-01-27 19:48:11.000000000 -0800
> +++ fbdev-2.6/drivers/video/fbmem.c	2004-02-06 03:45:53.000000000 -0800
> @@ -1228,6 +1228,9 @@
>  			break;
>  	fb_info->node = i;
>  	
> +	if (fb_add_class_device(fb_info))
> +		return -EINVAL;
> +	

Woah, what about all of the fb drivers that statically allocate their
fb_info structure?  This will die a horrible death for them when they
try to unload themselves.

Are you going to fix up every fb driver to call framebuffer_alloc() to
fix this problem?  That's quite a task...

thanks,

greg k-h

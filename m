Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUBKW6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUBKW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:57:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:650 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266223AbUBKW50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:57:26 -0500
Date: Wed, 11 Feb 2004 22:57:24 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbdev driver and sysfs question.
Message-ID: <20040211225724.GN21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:26:45PM +0000, James Simmons wrote:
> +	info = framebuffer_alloc(0, &dev->dev); 
> +	if (!info)
> +		return -ENOMEM;
> +	dev_set_drvdata(&dev->dev, info);
> +	
> +        info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
> +	if (!info->screen_base) {
>  		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
>  		printk(KERN_ERR
>  		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",

	Who will free info?

> -	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
> +	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
>  
> -	if (register_framebuffer(&fb_info)<0)
> +	if (register_framebuffer(info) < 0)

	Who will undo allocations?  BTW, that applies to the old code too -
even if fb_alloc_cmap() doesn't require any actions on cleanup, ioremap()
definitely does.

>  		return -EINVAL;

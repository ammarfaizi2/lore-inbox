Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUE1V2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUE1V2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUE1V1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:27:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:20141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262060AbUE1V0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:44 -0400
Date: Fri, 28 May 2004 14:08:41 -0700
From: Greg KH <greg@kroah.com>
To: Nickolai Zeldovich <kolya@MIT.EDU>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] report which device failed to suspend
Message-ID: <20040528210841.GA10366@kroah.com>
References: <Pine.GSO.4.55L.0405271835210.24218@scrubbing-bubbles.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.55L.0405271835210.24218@scrubbing-bubbles.mit.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 06:36:16PM -0400, Nickolai Zeldovich wrote:
> When your machine stops suspending all of a sudden, a patch such as the
> one below is helpful to diagnose which device or driver is misbehaving and
> causing the suspend sequence to fail.
> 
> -- kolya
> 
> --- drivers/base/power/suspend.c	2004/05/27 22:09:47	1.1
> +++ drivers/base/power/suspend.c	2004/05/27 22:28:36
> @@ -42,6 +42,10 @@
>  	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
>  		error = dev->bus->suspend(dev,state);
> 
> +	if (error)
> +		printk(KERN_ERR "Could not suspend device %s: error %d\n",
> +			kobject_name(&dev->kobj), error);
> +

As pointed out when Andrew forwarded this to me, this is the incorrect
way to do this, as -EAGAIN is valid to return from suspend().

I've put this check in the proper place in my trees.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVDVAx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVDVAx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVDVAvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:51:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:40682 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261899AbVDVAvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:51:41 -0400
Date: Thu, 21 Apr 2005 17:39:20 -0700
From: Greg KH <gregkh@suse.de>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
Message-ID: <20050422003920.GD6829@kroah.com>
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com> <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 12:30:09AM +0900, Keiichiro Tokunaga wrote:
> +#ifdef CONFIG_HOTPLUG
> +void unregister_node(struct node *node)
> +{
> +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> +	sysdev_remove_file(&node->sysdev, &attr_distance);
> +
> +	sysdev_unregister(&node->sysdev);
> +}
> +EXPORT_SYMBOL_GPL(register_node);
> +EXPORT_SYMBOL_GPL(unregister_node);
> +#else /* !CONFIG_HOTPLUG */
> +void unregister_node(struct node *node)
> +{
> +}
> +#endif /* !CONFIG_HOTPLUG */

Oops, you only exported the symbols if CONFIG_HOTPLUG is enabled, not a
good idea.  Either make the null functions in a .h file if the option is
not enabled, or always export them.

And the comment for the #endif isn't really needed, as the whole #ifdef
fits on a single screen :)

And hey, what's the real big deal here, why not always have this
function no matter if CONFIG_HOTPLUG is enabled or not?  I really want
to just make that an option that is always enabled anyway, but changable
if you are using CONFIG_TINY or something...

thanks,

greg k-h

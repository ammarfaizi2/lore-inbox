Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVDVCcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVDVCcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 22:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVDVCcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 22:32:52 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:26038 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261921AbVDVCct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 22:32:49 -0400
Date: Fri, 22 Apr 2005 11:32:11 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <20050422003920.GD6829@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
 <20050420173235.GA17775@kroah.com>
 <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
 <20050422003920.GD6829@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005 17:39:20 -0700 Greg KH wrote:
> On Fri, Apr 22, 2005 at 12:30:09AM +0900, Keiichiro Tokunaga wrote:
> > +#ifdef CONFIG_HOTPLUG
> > +void unregister_node(struct node *node)
> > +{
> > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > +
> > +	sysdev_unregister(&node->sysdev);
> > +}
> > +EXPORT_SYMBOL_GPL(register_node);
> > +EXPORT_SYMBOL_GPL(unregister_node);
> > +#else /* !CONFIG_HOTPLUG */
> > +void unregister_node(struct node *node)
> > +{
> > +}
> > +#endif /* !CONFIG_HOTPLUG */
> 
> Oops, you only exported the symbols if CONFIG_HOTPLUG is enabled, not a
> good idea.  Either make the null functions in a .h file if the option is
> not enabled, or always export them.

  My bad...

> And the comment for the #endif isn't really needed, as the whole #ifdef
> fits on a single screen :)

  I see:)  That makes sense.

> And hey, what's the real big deal here, why not always have this
> function no matter if CONFIG_HOTPLUG is enabled or not?  I really want
> to just make that an option that is always enabled anyway, but changable
> if you are using CONFIG_TINY or something...

  I put the #ifdef there for users who don't need hotplug
stuffs, but I want to make the option always enabled, too.
Also a good side effect, the code would be cleaner:)  I
will be updating my patch without the #ifdef and sending
it here.

Thanks!
Keiichiro Tokunaga

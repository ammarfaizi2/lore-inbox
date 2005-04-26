Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVDZGyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDZGyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVDZGyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:54:49 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:566 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261356AbVDZGyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:54:46 -0400
Date: Mon, 25 Apr 2005 23:54:32 -0700
From: Greg KH <gregkh@suse.de>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
Message-ID: <20050426065431.GB5889@suse.de>
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com> <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com> <20050422003920.GD6829@kroah.com> <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com> <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:03:33PM +0900, Keiichiro Tokunaga wrote:
> On Fri, 22 Apr 2005 11:32:11 +0900 Keiichiro Tokunaga wrote:
> > On Thu, 21 Apr 2005 17:39:20 -0700 Greg KH wrote:
> > > On Fri, Apr 22, 2005 at 12:30:09AM +0900, Keiichiro Tokunaga wrote:
> > > > +#ifdef CONFIG_HOTPLUG
> > > > +void unregister_node(struct node *node)
> > > > +{
> > > > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > > > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > > > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > > > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > > > +
> > > > +	sysdev_unregister(&node->sysdev);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(register_node);
> > > > +EXPORT_SYMBOL_GPL(unregister_node);
> > > > +#else /* !CONFIG_HOTPLUG */
> > > > +void unregister_node(struct node *node)
> > > > +{
> > > > +}
> > > > +#endif /* !CONFIG_HOTPLUG */
> <snip>
> > > And hey, what's the real big deal here, why not always have this
> > > function no matter if CONFIG_HOTPLUG is enabled or not?  I really want
> > > to just make that an option that is always enabled anyway, but changable
> > > if you are using CONFIG_TINY or something...
> > 
> >   I put the #ifdef there for users who don't need hotplug
> > stuffs, but I want to make the option always enabled, too.
> > Also a good side effect, the code would be cleaner:)  I
> > will be updating my patch without the #ifdef and sending
> > it here.
> 
>   Here is the patch.  Please apply.

Care to resend it with a proper change log description that I can use?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVD1ASn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVD1ASn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVD1ASn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 20:18:43 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59016 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262122AbVD1ASY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 20:18:24 -0400
Date: Thu, 28 Apr 2005 09:17:45 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <20050426065431.GB5889@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <20050428091745.58ab86a9.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
 <20050420173235.GA17775@kroah.com>
 <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
 <20050422003920.GD6829@kroah.com>
 <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com>
 <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com>
 <20050426065431.GB5889@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 23:54:32 -0700 Greg KH wrote:
> On Mon, Apr 25, 2005 at 11:03:33PM +0900, Keiichiro Tokunaga wrote:
> > On Fri, 22 Apr 2005 11:32:11 +0900 Keiichiro Tokunaga wrote:
> > > On Thu, 21 Apr 2005 17:39:20 -0700 Greg KH wrote:
> > > > On Fri, Apr 22, 2005 at 12:30:09AM +0900, Keiichiro Tokunaga wrote:
> > > > > +#ifdef CONFIG_HOTPLUG
> > > > > +void unregister_node(struct node *node)
> > > > > +{
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > > > > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > > > > +
> > > > > +	sysdev_unregister(&node->sysdev);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(register_node);
> > > > > +EXPORT_SYMBOL_GPL(unregister_node);
> > > > > +#else /* !CONFIG_HOTPLUG */
> > > > > +void unregister_node(struct node *node)
> > > > > +{
> > > > > +}
> > > > > +#endif /* !CONFIG_HOTPLUG */
> > <snip>
> > > > And hey, what's the real big deal here, why not always have this
> > > > function no matter if CONFIG_HOTPLUG is enabled or not?  I really want
> > > > to just make that an option that is always enabled anyway, but changable
> > > > if you are using CONFIG_TINY or something...
> > > 
> > >   I put the #ifdef there for users who don't need hotplug
> > > stuffs, but I want to make the option always enabled, too.
> > > Also a good side effect, the code would be cleaner:)  I
> > > will be updating my patch without the #ifdef and sending
> > > it here.
> > 
> >   Here is the patch.  Please apply.
> 
> Care to resend it with a proper change log description that I can use?

  Sure.  But, please let me ask you something before I
post the update patch.  I think register_node() also
should be always there if unregister_node() is always
there.  So, the '__devinit' attribute for register_node()
does not seem to be necessary.  (Actually, the attribute
'__init' of register_node() was replaced with '__devinit'
in my previous patch.)  What do you think of this?

Thanks,
Keiichiro Tokunaga

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUJWUgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUJWUgY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUJWUgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:36:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:34243 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261291AbUJWUfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:35:05 -0400
Date: Sat, 23 Oct 2004 13:34:04 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.9
Message-ID: <20041023203404.GA24993@kroah.com>
References: <10982037783139@kroah.com> <20041023202037.GA12345@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023202037.GA12345@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:20:37PM +0200, Kronos wrote:
> Greg KH <greg@kroah.com> ha scritto:
> > ChangeSet 1.1867.3.4, 2004/09/15 11:36:09-07:00, greg@kroah.com
> > 
> > kevent: standardize on the event types
> > 
> > This prevents any potential typos from happening.
> 
> [cut]
> 
> > diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > --- a/lib/kobject_uevent.c      2004-10-19 09:22:44 -07:00
> > +++ b/lib/kobject_uevent.c      2004-10-19 09:22:44 -07:00
> > @@ -19,9 +19,29 @@
> > #include <linux/skbuff.h>
> > #include <linux/netlink.h>
> > #include <linux/string.h>
> > +#include <linux/kobject_uevent.h>
> > #include <linux/kobject.h>
> > #include <net/sock.h>
> > 
> > +/* 
> > + * These must match up with the values for enum kobject_action
> > + * as found in include/linux/kobject_uevent.h
> > + */
> > +static char *actions[] = {
> > +       "add",          /* 0x00 */
> > +       "remove",       /* 0x01 */
> > +       "change",       /* 0x02 */
> > +       "mount",        /* 0x03 */
> > +};
> 
> Hi Greg,
> maybe it's just a matter of taste but I think that is better to do
> something like this:
> 
> static char *actions[] = {
>         [KOBJ_ADD]      = "add",
>         [KOBJ_REMOVE]   = "remove",
>         [KOBJ_CHANGE]   = "change",
>         [KOBJ_MOUNT]    = "mount",
> };
> 
> This would prevent the insertion of a new action in the wrong place.

See the following patches in the series, which fixes this up :)

thanks,

greg k-h

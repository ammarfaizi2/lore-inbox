Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTDKWuC (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDKWuB (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:50:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1472 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261877AbTDKWt6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:49:58 -0400
Date: Fri, 11 Apr 2003 16:03:49 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Tim Hockin <thockin@hockin.org>, sdake@mvista.com, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411230349.GG3786@kroah.com>
References: <20030411150933.43fd9a84.akpm@digeo.com> <200304112219.h3BMJMG11078@www.hockin.org> <20030411154709.379a139c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411154709.379a139c.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:47:09PM -0700, Andrew Morton wrote:
> Tim Hockin <thockin@hockin.org> wrote:
> >
> > > > A much better solution could be had by select()ing on a filehandle 
> > > > indicating when a new hotswap event is ready to be processed.  No races, 
> > > > no security issues, no performance issues.
> > > 
> > > I must say that I've always felt this to be a better approach than the
> > > /sbin/hotplug callout.
> > 
> > I've always liked this approach, too - if you look at acpid, it is designed
> > to be gereically useful for this model of kernel->userland notification.
> > 
> > With minor mods, it could become 'eventd' and handle ACPI, hotplug, netlink,
> > and any other style kernel->user notice.
> 
> It also has the advantage that events are handled in reliable and repeatable
> order.

I'm looking at making device probing a zillion different threads from
within the kernel, allowing us to probe devices much faster than we do
today (and fixes a lot of nasty problems with broken hardware that we
currently have today).  That would ensure that those events would never
be in a reliable and repeatable order :)

> It may not happen much in practice, but we have had problem with cardbus
> contact bounce causing an event storm in the past.  The daemon could just
> swallow the first 5 insert/remove pairs and process the final insert only.
> 
> The kernel would have to drop messages on the floor at some point though.

Exactly, let's not do that.  The current scheme does not do that.  Out
of order is solvable, while missing events is not simple.

thanks,

greg k-h

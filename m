Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbTEERFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTEERD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:03:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61641 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263741AbTEERDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:03:31 -0400
Date: Mon, 5 May 2003 10:17:45 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Mike Anderson <andmike@us.ibm.com>
Subject: Re: [RFC] support for sysfs string based properties for SCSI (1/3)
Message-ID: <20030505171745.GA1477@kroah.com>
References: <1051989099.2036.7.camel@mulgrave> <1051989565.2036.14.camel@mulgrave> <20030505170202.GA1296@kroah.com> <1052154516.1888.33.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052154516.1888.33.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 12:08:35PM -0500, James Bottomley wrote:
> On Mon, 2003-05-05 at 12:02, Greg KH wrote:
> > On Sat, May 03, 2003 at 02:19:23PM -0500, James Bottomley wrote:
> > > diff -Nru a/drivers/base/core.c b/drivers/base/core.c
> > > --- a/drivers/base/core.c	Sat May  3 14:18:21 2003
> > > +++ b/drivers/base/core.c	Sat May  3 14:18:21 2003
> > > @@ -42,6 +42,8 @@
> > >  
> > >  	if (dev_attr->show)
> > >  		ret = dev_attr->show(dev,buf);
> > > +	else if (dev->bus->show)
> > > +		ret = dev->bus->show(dev, buf, attr);
> > >  	return ret;
> > 
> > Can't you do this by using the class interface instead?
> 
> I don't know, I haven't digested the class interface patches yet, since
> they just appeared this morning.

I think Mike has a patch queued up that takes advantage of the class
code, which might address all of these issues.  Mike?

> > This also forces you to do a lot of string compares within the bus show
> > function (as your example did) which is almost as unwieldy as just
> > having individual show functions, right?  :)
> 
> Nothing prevents users from doing it the callback way.  However,
> callbacks aren't a scaleable interface for properties that have to be
> shared and overridden.

I don't understand the "shared and overridden" aspect.  Do you mean a
default attribute for all types of SCSI devices, with the ability for an
individual device to override the attribute with it's own values if it
wants to?  That still seems doable within the driver model today,
without having to rely on bus specific functions.

Hm, this is _really_ calling for what Pat calls "attributes".  Take a
look at the ones in the class model, and let me know if those would work
for you for devices.  If so, I'll be glad to add them, which should help
you out here.

Hope this helps,

greg k-h

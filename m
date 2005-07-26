Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVGZAcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVGZAcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGZAcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:32:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:2260 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261600AbVGZAag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:30:36 -0400
Date: Mon, 25 Jul 2005 17:30:18 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050726003018.GA24089@kroah.com>
References: <9e47339105072421095af5d37a@mail.gmail.com> <200507242358.12597.dtor_core@ameritech.net> <9e4733910507250728a7882d4@mail.gmail.com> <d120d5000507250748136a1e71@mail.gmail.com> <9e47339105072509307386818b@mail.gmail.com> <20050726000024.GA23858@kroah.com> <9e473391050725172833617aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050725172833617aca@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 08:28:10PM -0400, Jon Smirl wrote:
> On 7/25/05, Greg KH <greg@kroah.com> wrote:
> > On Mon, Jul 25, 2005 at 12:30:43PM -0400, Jon Smirl wrote:
> > > On 7/25/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > On 7/25/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > > On 7/25/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > > > On Sunday 24 July 2005 23:09, Jon Smirl wrote:
> > > > > > > I just pulled from GIT to test bind/unbind. I couldn't get it to work;
> > > > > > > it isn't taking into account the CR on the end of the input value of
> > > > > > > the sysfs attribute.  This patch will fix it but I'm sure there is a
> > > > > > > cleaner solution.
> > > > > > >
> > > > > >
> > > > > > "echo -n" should take care of this problem I think.
> > > > >
> > > > > That will work around it but I think we should fix it.  Changing to
> > > > > strncmp() fixes most cases.
> > > > >
> > > > > -       if (strcmp(name, dev->bus_id) == 0)
> > > > > +       if (strncmp(name, dev->bus_id, strlen(dev->bus_id)) == 0)
> > > > >
> > > >
> > > > This will produce "interesting results" if you have both "blah-1" and
> > > > "blah-10" devices on the bus.
> > 
> > Yes, not a good thing for USB devices specifically.
> > 
> > > Then the better solution is to fix the generic attribute set code to
> > > strip leading and trailing white space.
> > 
> > No, that might break other things as we have not been doing this from
> > day one.  I'd rather just change these two places, if it's that big of a
> > deal.  It was documented (in a lwn.net article) and the changelog entry,
> > that you should use "echo -n".
> 
> I didn't realize that echo was adding the CR, I thought that it always
> appeared on the end of a sysfs attribute set. So now I have to go add
> white space stripping to a dozen fbdev/drm sysfs attribute
> implementations. Given that the param is const I may have to allocate
> new buffers and copy. I also wonder how many other people have made
> the same mistake.

Nah, just zero out that \n character :)

> Are you sure it would break other things? These are supposed to be
> text attributes, not binary ones.

I agree, I don't know what would break.  Care to make a patch so we
could find out?

thanks,

greg k-h

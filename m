Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUKQTFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUKQTFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUKQTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:03:38 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:10822 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262460AbUKQTCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:02:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OLgQ4wlksQQMTiiZLUkgTDc0NsymydY7LtgunKJlkHL0LUzUIKl57uyERQkMA4LlpBQaBZ86SA8xA4SskHZQaPDsnZ86rf6j9AnveP9qsDhrxftdxo123zr7CNZoZrArJL5in0GvT6F66SeumWvYO9q7WebLWKpW4FYNM5qDtVU=
Message-ID: <d120d500041117110140db624e@mail.gmail.com>
Date: Wed, 17 Nov 2004 14:01:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041117175359.GD28285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109223729.GB7416@kroah.com>
	 <20041116061315.GG29574@neo.rr.com> <20041116201726.GA11069@kroah.com>
	 <200411170207.14745.dtor_core@ameritech.net>
	 <20041117175359.GD28285@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 09:53:59 -0800, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 17, 2004 at 02:07:14AM -0500, Dmitry Torokhov wrote:
> > On Tuesday 16 November 2004 03:17 pm, Greg KH wrote:
> > > > 2.) I don't like having an "unbind" file.
> > >
> > > Why?
> >
> > I do not like interfaces accepting and encouraging writing garbage data. What
> > value sould be written into "unbind"? Yes, any junk.
> 
> Ok, we restrict it to working only if you write a "1" into it.  That was
> an easy fix :)
> 
> > > So, when a device is not bound to a driver, there will be no symlink, or
> > > a "unbind" file, only a "bind" file. ?Really there is only 1 "control"
> > > type file present at any single point in time.
> >
> > Does that imply that I can not rebind device while it is bound to a driver?
> 
> Yes.  You must unbind it first.
> 
> > ("bind" would be missing it seems). And what about all other flavors of that
> > operation - rescan, reconnect? Do we want to have separate attributes for
> > them as well?
> 
> rescan is a bus specific thing, not a driver or device thing.

Yes, it is - at least when I am talking about rescan I mean that I want to
scan a bus for a specific driver for the particular device. I do not want any
other device to be affected and therefore it is a device thing.

> reconnect would be the same as "unbind" + "bind" and you can do that
> with the scheme I posted.

No quite - the point of reconnect is to be able to re-intialize the hardware
while keeping everything else intact - if I do unbind and then bind on my
touchpad while GPM and X are running it will jump from /dev/input/event0
to /dev/input/event4 and I will effectively lose it.

-- 
Dmitry

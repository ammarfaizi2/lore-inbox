Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUIPWhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUIPWhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPWhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:37:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:60842 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268282AbUIPWga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:36:30 -0400
Date: Thu, 16 Sep 2004 15:35:39 -0700
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 2/2
Message-ID: <20040916223539.GA16151@kroah.com>
References: <1095332331.3855.161.camel@laptop.cunninghams> <20040916142847.GA32352@kroah.com> <1095373127.5897.23.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095373127.5897.23.camel@laptop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 08:18:47AM +1000, Nigel Cunningham wrote:
> On Fri, 2004-09-17 at 00:28, Greg KH wrote:
> > On Thu, Sep 16, 2004 at 08:58:51PM +1000, Nigel Cunningham wrote:
> > > 
> > > This simple helper adds support for finding a class given its name. I
> > > use this to locate the frame buffer drivers and move them to the
> > > keep-alive tree while suspending other drivers.
> > > 
> > > +struct class * class_find(char * name)
> > > +{
> > > +	struct class * this_class;
> > > +
> > > +	if (!name)
> > > +		return NULL;
> > > +
> > > +	list_for_each_entry(this_class, &class_subsys.kset.list, subsys.kset.kobj.entry) {
> > > +		if (!(strcmp(this_class->name, name)))
> > > +			return this_class;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > 
> > Ick, no.  I've been over this before with the fb people, and am not going
> > to accept this patch (nevermind that it's broken...)  See the lkml
> > archives for more info on why I don't like this.
> 
> Please excuse my ignorance but I don't see how it's broken

This function, as written is very broken.  I will not accept it.  Not to
mention the fact that the functionality this function proposes to offer
is not needed either.

> (their patch just fills in a field that was left blank previously),

What patch?

> and this patch just makes use of that change. What's the point to
> device_class if we don't use it?

I don't see a use of device_class in this function.  I'm confused.

thanks,

greg k-h

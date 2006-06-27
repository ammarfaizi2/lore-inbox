Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422725AbWF0XXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422725AbWF0XXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWF0XXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:23:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56490 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422725AbWF0XXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:23:38 -0400
Date: Tue, 27 Jun 2006 16:20:02 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       Mattia Dongili <malattia@linux.it>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060627232002.GD15225@kroah.com>
References: <20060623042452.GA23232@kroah.com> <20060626235732.GE32008@kroah.com> <20060627090304.GA29199@elf.ucw.cz> <200606271038.40510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606271038.40510.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:38:39AM -0700, David Brownell wrote:
> > > > > And we also need to be able to handle devices in the device tree that do
> > > > > not have a suspend/resume function ...
> > > >
> > > > Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> > > > it because it doesn't need them, or is it because nobody has written them 
> > > > yet?  In the latter case, failing the suspend or unbinding the driver are 
> > > > the only safe courses.
> > > 
> > > No, if it's not there, just expect that it knows what it is doing, and
> > > don't fail the thing.  Unless you want to add those methods to _every_
> > > driver in the kernel, and that's going to be a lot of work...
> 
> It seems reasonable to me to require that drivers have at least
> stub "it's actually OK to do nothing here" suspend/resume methods.

No, the point is that these devices have no driver associated with them.
They are "class" devices, and as such, are virtual.

Hm, well, I guess I should go add the suspend callbacks to the class, as
Linus's core changes is going to be expecting that...

Anyway, for virtual devices, it often times makes no sense to have a
suspend function, and as such, they should not be required to provide a
null function...

thanks,

greg k-h

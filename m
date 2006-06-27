Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932806AbWF0JD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbWF0JD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932816AbWF0JD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:03:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62348 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932806AbWF0JD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:03:26 -0400
Date: Tue, 27 Jun 2006 11:03:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-pm@osdl.org
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060627090304.GA29199@elf.ucw.cz>
References: <20060623042452.GA23232@kroah.com> <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org> <20060626235732.GE32008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626235732.GE32008@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > And we also need to be able to handle devices in the device tree that do
> > > not have a suspend/resume function, or ones that are not attached to any
> > > bus, without failing the suspend, as obviously they do not care or need
> > > to worry about the whole issue.
> > 
> > Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> > it because it doesn't need them, or is it because nobody has written them 
> > yet?  In the latter case, failing the suspend or unbinding the driver are 
> > the only safe courses.
> 
> No, if it's not there, just expect that it knows what it is doing, and
> don't fail the thing.  Unless you want to add those methods to _every_
> driver in the kernel, and that's going to be a lot of work...

I believe 90% of drivers need them, anyway... Idea is that if we
refuse the suspend, user has dmesg and did not loose his work. If we
suspend but can't resume due to driver problems, it is slightly more
interesting to debug, and user lost open applications.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWA3Vi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWA3Vi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWA3Vi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:38:58 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50827
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030194AbWA3Vi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:38:58 -0500
Date: Mon, 30 Jan 2006 13:39:08 -0800
From: Greg KH <greg@kroah.com>
To: Aritz Bastida <aritzbastida@gmail.com>
Cc: Antonio Vargas <windenntw@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Message-ID: <20060130213908.GA26463@kroah.com>
References: <7d40d7190601261206wdb22ccck@mail.gmail.com> <20060127050109.GA23063@kroah.com> <7d40d7190601270230u850604av@mail.gmail.com> <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com> <7d40d7190601300323t1aca119ci@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d40d7190601300323t1aca119ci@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 12:23:14PM +0100, Aritz Bastida wrote:
> Thank you Antonio and Greg
> But I still have one question pending:
> 
> > >
> > > 3.- Actually the most difficult config I must do is to pass three
> > > values from userspace to my module. Specifically two integers and a
> > > long (it's an offset to a memory zone I've previously defined)
> > >
> > > struct meminfo {
> > >         unsigned int      id;         /* segment identifier */
> > >         unsigned int      size;     /* size of the memory area */
> > >         unsigned long   offset;   /* offset to the information */
> > > };
> > >
> > > How would you pass this information in sysfs? Three values in the same
> > > file? Note that using three different files wouldn't be atomic, and I
> > > need atomicity.
> > >
> 
> I guess I could pass three values on the same file, like this:
> $ echo "5  1000  500" > meminfo
> 
> I know that breaks the sysfs golden-rule, but how can I pass those
> values _atomically_ then? Having three different files wouldn't be
> atomic...

That's what configfs was created for.  I suggest using that for things
like this, as sysfs is not intended for it.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUBJSXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUBJSUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:20:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:30609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266165AbUBJSTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:19:36 -0500
Date: Tue, 10 Feb 2004 10:19:32 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210181932.GI28111@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210175548.GN4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210175548.GN4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ugh, and here I said I wouldn't respond.  But to be fair, he wrote me
this before I said that...

On Tue, Feb 10, 2004 at 09:55:49AM -0800, Mike Bell wrote:
> On Tue, Feb 10, 2004 at 09:01:57AM -0800, Greg KH wrote:
> > Did you read:
> > 	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs
> 
> While we're at it...
> 
> >  Problems:
> >    1) devfs only shows the dev entries for the devices in the system.
> 
> Why is that a bad thing? Why should I want to see dev entries for firewire
> drives on my 486 or LPT1 on my legacy-free laptop? 

No, I'm saying that devfs does solve this problem.  Quite well in fact.

> >    2) devfs does not handle the need for dynamic major/minor numbers
> 
> It does as well as udev does. You say it yourself, "if the kernel switches to
> dynamic major/minor". The same is true of devfs. It was designed for dynamic
> major/minors, and the static ones were for backward compatibility with static
> /devs.

But devfs never used the dynamic major/minor code.  No one used it.
It's not even present anymore in 2.6.  That shows that devfs does not
solve this problem by itself.

> >    4) devfs does provide a deamon that userspace programs can hook into
> >       to listen to see what devices are being created or removed.
> 
> How is that a problem?

It isn't.  It's saying that devfs does do this.

> >  Constraints:
> >    1) devfs forces the devfs naming policy into the kernel.  If you
> >       don't like this naming scheme, tough.
> 
> Not true at all. If you don't like the naming scheme, run devfsd. Just
> like running udev, only unlike udev at least you have device files even
> if the daemon's not running.

Heh, you haven't ever converted a driver to use devfs have you?  If so,
you would have seen the fact that you had to specify your devfs name in
the driver interface.  That's hard coding the naming scheme in the
kernel.

And how flexible does devfsd allow you to specify your own naming
scheme?  How can you get the info from devfsd that you need to provide a
proper device name?  No one I know has ever does this.  And I know some
people who tried real hard...

> >    2) devfs does not follow the LSB device naming standard.
> 
> No, but the userspace daemon attached to it could do so, just like udev.

But it doesn't.  That was the point.

udev defaults to this.  Which is the sane thing to do.

thanks,

greg k-h

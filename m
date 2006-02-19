Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWBSApA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWBSApA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWBSApA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:45:00 -0500
Received: from proof.pobox.com ([207.106.133.28]:62123 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S964776AbWBSAo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:44:59 -0500
Date: Sat, 18 Feb 2006 18:47:51 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060219004751.GE3293@localhost.localdomain>
References: <20060211220351.GA3293@localhost.localdomain> <20060211224526.GA25237@kroah.com> <20060212052751.GB3293@localhost.localdomain> <20060212053849.GA27587@kroah.com> <20060216215023.GA30417@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216215023.GA30417@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Feb 11, 2006 at 09:38:49PM -0800, Greg KH wrote:
> > On Sat, Feb 11, 2006 at 11:27:52PM -0600, Nathan Lynch wrote:
> > > Greg KH wrote:
> > > > On Sat, Feb 11, 2006 at 04:03:53PM -0600, Nathan Lynch wrote:
> > > > > If the refcnt attribute of a module is open when the module is
> > > > > unloaded, we get an oops when the file is closed.  I used ide_cd for
> > > > > this report but I don't think the oops is caused by the driver itself.
> > > > > This bug seems to be restricted to the /sys/module hierarchy; it
> > > > > doesn't happen with /sys/class etc.

<snip>

> 
> Ok, turns out the code was trying to increment the module reference
> count correctly, but it wasn't working right at all.  And we were not
> showing a few things in sysfs if module unload was not selected, which
> isn't right.
> 
> So here's a patch that fixes all of this, and your original problem.
> Bonus is that it actually removes more code than it adds :)
> 
> Can you test it out to verify that it works for you?

Sorry for the delay.

Tested against 2.6.16-rc4-ish, and it seems to do the right thing --
modprobe -r says the module is busy while the refcnt attribute is
open.  The module is allowed to unload once the file is closed.

I didn't verify the other stuff your patch changes, though.

Thanks.


Nathan


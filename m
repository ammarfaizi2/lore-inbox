Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267129AbUBGTUg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 14:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267130AbUBGTUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 14:20:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:46048 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267129AbUBGTUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 14:20:33 -0500
Date: Sat, 7 Feb 2004 11:20:28 -0800
From: Greg KH <greg@kroah.com>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc1
Message-ID: <20040207192027.GD2581@kroah.com>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <20040207025638.GW21151@parcelfarce.linux.theplanet.co.uk> <20040207172152.GA6412@arizona.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207172152.GA6412@arizona.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 12:21:52PM -0500, Kevin O'Connor wrote:
> 
> So, my question - is it really a good idea to rework much of the kernel
> object lifetime rules just to support sysfs?

At this point in time, in the stable kernel series, I say no.

That is why I created the class_simple interface, which allows
developers to be able to export data through sysfs (like the dev_t
data), without having to change their lifetime rules at all.

Now when 2.7 starts up again, that's the proper time to be changing this
kind of stuff to work "properly".  Until then, lets just live with the
lifetime rules that we have (if they work, and almost all of them seem
to).

And remember, I'm the person who really _wants_ to see all of this stuff
fixed up properly...

> And a related question - couldn't sysfs be taught to atomically drop its
> references to external kernel objects and thus obviate the need for all
> these lifetime rule changes?

See the class_simple code for an example of how this can be done.  It's
not a sysfs issue.  It's an issue of how you _use_ sysfs :)

thanks,

greg k-h

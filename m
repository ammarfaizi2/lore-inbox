Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbULJHys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbULJHys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 02:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbULJHys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 02:54:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:1702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261650AbULJHyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 02:54:46 -0500
Date: Thu, 9 Dec 2004 23:54:29 -0800
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210075429.GA30223@kroah.com>
References: <20041210005055.GA17822@kroah.com> <Pine.LNX.4.53.0412100805440.8273@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0412100805440.8273@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 08:07:20AM +0100, Jan Engelhardt wrote:
> >What if there was a in-kernel filesystem that was explicitly just for
> >putting debugging stuff?  Some place other than proc and sysfs, and that
> >was easier than both of them to use.  Yet it needed to also be able to
> >handle complex stuff like seq file and raw file_ops if needed.
> 
> As for modules, they could just wrap a variable in a module_param, don't they?

For input stuff, yes.  And for simple types that are not debug stuff,
yes, that is the proper place for them.

> I have to admit that adding another filesystem that is very like procfs or
> sysfs make some kind of redundancy.

Why?  The main issue is the discussion usually goes like this:

Me:  Hey, the /proc/driver/foo/foo_value really shouldn't be in proc.
Developer:  Ok, but it has a lot of really good debug stuff in it.  Can
I put it in sysfs?
Me:  No, sysfs is for one-value-per-file whenever possible.  It needs to
go somewhere else.
Developer:  Well, if you don't have anywhere else to put it, why are you
even bringing this up at all.  Go away and leave me alone.


Now we have a place to put this stuff.  If you look through the way
drivers use /proc these days, there is still a lot of stuff that needs
to get moved out, that can go in debugfs.

As for "another filesystem", it's tiny due to using libfs, and it will
compile away into nothing if not selected (so in the end, provides the
ability to make the final kernel image smaller.)

thanks,

greg k-h

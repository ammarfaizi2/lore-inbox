Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVGYEW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVGYEW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 00:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVGYEW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 00:22:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:38631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261674AbVGYEWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 00:22:32 -0400
Date: Sun, 24 Jul 2005 21:54:32 -0400
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_remove_file and disconnect
Message-ID: <20050725015432.GL10051@kroah.com>
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com> <42C301F7.4010309@free.fr> <20050629224235.GC18462@kroah.com> <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net> <20050630170406.GA11334@kroah.com> <42C456B0.6010706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C456B0.6010706@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 10:31:44PM +0200, matthieu castet wrote:
> >Then they should be fixed.  Any specific examples?
> >
> >
> I am a little lasy to list all, but some drivers in driver/usb should 
> have this problem : the first driver I look : ./misc/phidgetkit.c do 
> [1]. So sysfs read don't check if to_usb_interface or usb_get_intfdata 
> return NULL pointer...
> And it is a bit your fault, as many developper should have read your 
> great tutorial [2] ;)

You are correct, I'll go fix those drivers, thanks for pointing it out.
Others pointed out the same thing this week at OLS :)

> >>Also I always see driver free their privatre data in device disconnect,
> >>so if read/write from sysfs aren't serialized with device disconnect
> >>there are still a possible race like I show in my example.
> >
> >
> >Yes, you are correct.  Again, any specific drivers you see with this
> >problem?
> I believe near all drivers that use sysfs via device_create_file, as I 
> never see them use mutex in read/write in order to check there aren't in 
> the same time in their disconnect that could free there private data 
> when they do operation on it...
> 
> 
> Couldn't be possible the make device_remove_file blocking until all the 
> open file are closed ?

Hm, do we even know that those files are opened then?  I'll poke around
in sysfs and see if we could do that.

thanks,

greg k-h

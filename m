Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTIIRWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264317AbTIIRWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:22:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:62856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264314AbTIIRWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:22:14 -0400
Date: Tue, 9 Sep 2003 10:13:54 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
Message-ID: <20030909171354.GC5928@kroah.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com> <20030908155048.GA10879@kroah.com> <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com> <20030908230852.GA3320@kroah.com> <Pine.LNX.4.53.0309090739270.14426@montezuma.fsmlabs.com> <Pine.LNX.4.53.0309091142550.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309091142550.14426@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 12:38:51PM -0400, Zwane Mwaikambo wrote:
> On Tue, 9 Sep 2003, Zwane Mwaikambo wrote:
> 
> > > So an empty release() function is the wrong thing to do in 99.99% of the
> > > situations in the kernel (the one exception seems to be the mca release
> > > function that recently got added for use when the bus is doing probing
> > > logic.)
> > > 
> > > Does this help out?
> > 
> > Yes thanks, i was confused over which memory references had to be 
> > maintained.
> 
> Ok i had another look and i can see why you need a seperate release 
> function, as we don't always do the kobject_cleanup immediately.
> 
> John and myself had a look and now we have the following race on 
> ->release() function exit.
> 
> my_release_fn()
> {
> 	complete(&my_completion);
> 	<== [1] stall anywhere here, e.g. preempt/schedule
> }

Ugh.  Sure, point out the theoretical :)

Any thoughts on how to solve this?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272435AbTHNQoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272473AbTHNQoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:44:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:22491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272435AbTHNQnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:43:41 -0400
Date: Thu, 14 Aug 2003 09:41:45 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call drv->shutdown at rmmod
In-Reply-To: <m13cg4yzlk.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Assuming the device driver can get a device out of the suspend state
> when the module is loaded.  This has been one of the biggest problem areas
> with the e100 driver.  It's init code cannot bring the device out of a low
> power state.

You're assuming that a driver can always bring a device out a shutdown
state. That's one of the things we talked about at OLS, and the other half
of the justification behind such a feature, not just making sure the
device is queisced. Your argument against my suggestion are some of the
same arguments for a feature like you're introducing. 

We have similar goals - introduce device power state code paths into 
common operations (e.g module removal). Doing so gets the code paths 
tested, which will help us ultimately achieve our utopian goals. And, it 
can be done in one shot. 

> > The default would always be 'Do Nothing', but with a per-device sysfs 
> > file, a developer/user/gui app could be used to set the policy from user 
> > space. 
> 
> Possibly.  But this is getting complicated.  And while I do support things
> being complicated enough to handle the problem this part of the API feels
> like it is excessively complicated.  Which is why I was trying to simply
> it by always calling shutdown on a device before we remove it.

Eh? This is complicated? especially compared your overall goal, kexec? Let 
me explain again: 

I won't take the patch to unconditionally shutdown devices on module 
removal, so you need some sort of flag. But, you must have some way to set 
the flag, which is what sysfs is designed for. While you're at it, we 
might as well make it an integer value, rather than a pure binary one, and 
conditionally attempt to set the power state if the user says so. 

It's actually pretty simple, and if it is confusing, then sit back and 
wait, and I'll provide documentation when I submit the patch. 



	Pat


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271030AbTHNQam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272000AbTHNQam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:30:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29486 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S271030AbTHNQad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:30:33 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call drv->shutdown at rmmod
References: <Pine.LNX.4.33.0308140854000.916-100000@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2003 10:26:47 -0600
In-Reply-To: <Pine.LNX.4.33.0308140854000.916-100000@localhost.localdomain>
Message-ID: <m13cg4yzlk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> [ I'm curious as to why you didn't cc me in the first place.. ] 

My apologies, I meant to.  Somehow I got Pavel Macheck instead of
Patrick Mochel.   The names are only superficially similar but mistakes
happen.

> > At the kexec BOF at OSDL there was some discussion on calling the
> > device shutdown method at module remove time, in addition to calling
> > it during reboot.  The driver was the observation that the primary
> > source of problems in booting linux from linux are drivers with bad
> > or missing drv->shutdown() routines.  The hope is this will increase
> > the testing so people can get it right and kexec can become more
> > useful.  In addition to making normal reboots more reliable.
> > 
> > The following patch is an implementation of that idea it calls drv->shutdown()
> 
> > before calling drv->remove().  If drv->shutdown() is implemented.
> 
> I like the idea behind the patch, but we shouldn't be calling it 
> unconditionally. We're bound to run into some suprises that could really 
> kill us this late in the 2.6 game. 
> 
> I do think it should go in, as long as there is a flag telling the core 
> whether or not to call shutdown for that particular device. I think it 
> could also be extended to include a power state, so the core could suspend 
> the device before removing the module. 

Assuming the device driver can get a device out of the suspend state
when the module is loaded.  This has been one of the biggest problem areas
with the e100 driver.  It's init code cannot bring the device out of a low
power state.

> The default would always be 'Do Nothing', but with a per-device sysfs 
> file, a developer/user/gui app could be used to set the policy from user 
> space. 

Possibly.  But this is getting complicated.  And while I do support things
being complicated enough to handle the problem this part of the API feels
like it is excessively complicated.  Which is why I was trying to simply
it by always calling shutdown on a device before we remove it.

Eric

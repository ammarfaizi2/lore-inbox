Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272452AbTHNQEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272455AbTHNQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:04:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:24258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272452AbTHNQEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:04:20 -0400
Date: Thu, 14 Aug 2003 09:02:20 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call drv->shutdown at rmmod 
In-Reply-To: <m1he4kzpiy.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0308140854000.916-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I'm curious as to why you didn't cc me in the first place.. ] 

> At the kexec BOF at OSDL there was some discussion on calling the
> device shutdown method at module remove time, in addition to calling
> it during reboot.  The driver was the observation that the primary
> source of problems in booting linux from linux are drivers with bad
> or missing drv->shutdown() routines.  The hope is this will increase
> the testing so people can get it right and kexec can become more
> useful.  In addition to making normal reboots more reliable.
> 
> The following patch is an implementation of that idea it calls drv->shutdown()
> before calling drv->remove().  If drv->shutdown() is implemented.

I like the idea behind the patch, but we shouldn't be calling it 
unconditionally. We're bound to run into some suprises that could really 
kill us this late in the 2.6 game. 

I do think it should go in, as long as there is a flag telling the core 
whether or not to call shutdown for that particular device. I think it 
could also be extended to include a power state, so the core could suspend 
the device before removing the module. 

The default would always be 'Do Nothing', but with a per-device sysfs 
file, a developer/user/gui app could be used to set the policy from user 
space. 



	-pat


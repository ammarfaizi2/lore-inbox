Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUIUP44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUIUP44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUIUP44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:56:56 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:6113 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267540AbUIUP4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:56:53 -0400
Message-ID: <9e473391040921085669c2dcd7@mail.gmail.com>
Date: Tue, 21 Sep 2004 11:56:52 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921124507.GC2383@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040921124507.GC2383@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 14:45:07 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > 1) user owns graphics devices
> > 2) user sets mode with string (or similar) format using ioctl common to
> > all drivers.
> > 3) driver is locked to prevent multiple mode sets
> > 4) common code takes this string and does a hotplug event with it.
> 
> I though this was
> 
> "Driver decides to either do it itself in kernel, or call userspace
> helper if that would be too complex".

The driver almost always needs to go to user space to get the file of
mode line overrides that the user can create. But there is nothing
stopping you from building everything in the kernel.

I'd just rather not have 100K of resident code waiting around for
something that doesn't occur very often.  For the radeon sample I'm
working on I have moved everything to user space except for a couple
of small helper functions that directly play with the registers. Note
that all mode setting in X occurs completely in user space so you
can't argue that it can't be done.

 
> > How are errors going to be communicated in this scheme? I can cat the
> > sysfs mode variable to get a status. Is there a good way to do this
> > without polling?
> 
> I'd say that write() to that sysfs file can simply return error. See
> echo disk > /sys/power/state, it returns error if transition failed.
> 
>                                                                 Pavel
> --
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 



-- 
Jon Smirl
jonsmirl@gmail.com

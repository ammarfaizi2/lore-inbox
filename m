Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVC3KDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVC3KDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVC3KDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:03:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:62624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261836AbVC3KDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:03:33 -0500
Date: Wed, 30 Mar 2005 01:52:13 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050330095213.GA12632@kroah.com>
References: <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com> <20050329181831.GB8125@elf.ucw.cz> <d120d50005032911114fd2ea32@mail.gmail.com> <20050329192339.GE8125@elf.ucw.cz> <d120d50005032912051fee6e91@mail.gmail.com> <20050329205225.GF8125@elf.ucw.cz> <Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 01:23:35PM -0800, Patrick Mochel wrote:
> 
> On Tue, 29 Mar 2005, Pavel Machek wrote:
> 
> > I don't really want us to try execve during resume... Could we simply
> > artifically fail that execve with something if (in_suspend()) return
> > -EINVAL; [except that in_suspend() just is not there, but there were
> > some proposals to add it].
> >
> > Or just avoid calling hotplug at all in resume case? And then do
> > coldplug-like scan when userspace is ready...
> 
> I thought that cold-plugging only worked for devices, not all objects.

We can walk the whole sysfs tree and create "cold" hotplug events.
udevstart does that for devices that udev cares about (as an example.)

> Can we just queue up hotplug events? That way we wouldn't lose any across
> the transition, and could be used to send resume events to userspace for
> various devices that need help..

Ick, I really hate this idea, but there is a patch in the SuSE kernel to
do this at boot time.  Hopefully the author of that patch resubmitts it
again and maybe it will make it eventually into mainline...

thanks,

greg k-h

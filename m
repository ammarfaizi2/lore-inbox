Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVC2UxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVC2UxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVC2UxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:53:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7057 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261380AbVC2Uwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:52:43 -0500
Date: Tue, 29 Mar 2005 22:52:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050329205225.GF8125@elf.ucw.cz>
References: <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com> <20050329181831.GB8125@elf.ucw.cz> <d120d50005032911114fd2ea32@mail.gmail.com> <20050329192339.GE8125@elf.ucw.cz> <d120d50005032912051fee6e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005032912051fee6e91@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well, there lies a problem - some devices have to do execve because
> > > they need firmware to operate. Also, again, some buses with
> > > hot-pluggable devices will attempt to clean up unsuccessful resume and
> > > this will cause hotplug events. The point is you either resume system
> > > or you don't. We probably need a separate "unfreeze" callback,
> > > although this is kind of messy.
> > 
> > There's a better solution for firmware: You should load your firmware
> > prior to suspend and store it in RAM. Anything else just plain does
> > not work. (Because your wireless firmware might be on NFS mounted over
> > that wireless card).
> > 
> > Hotplug... I guess udev just needs to hold that callbacks before
> > system is fully up... it has to do something similar on regular boot,
> > no?
> 
> Well, I did not really look into udev but hotplug (which can iteract
> with udev) does not keep anything. If it fails its ok - that's why
> there are coldplug scripts that "recover" lost events. But here we
> block trying to start hotplug - we not getting an error - and this is
> bad. Unfortunately I am not familiar with block devices working to say
> why it hangs.
> 
> Should we pull Jens into the discussion?

I don't really want us to try execve during resume... Could we simply
artifically fail that execve with something if (in_suspend()) return
-EINVAL; [except that in_suspend() just is not there, but there were
some proposals to add it].

Or just avoid calling hotplug at all in resume case? And then do
coldplug-like scan when userspace is ready...

But we perhaps should cc linux-pm list.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

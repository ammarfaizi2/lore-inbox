Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVCYOYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVCYOYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVCYOYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:24:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24523 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261633AbVCYOYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:24:38 -0500
Date: Fri, 25 Mar 2005 15:24:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050325142414.GF23602@elf.ucw.cz>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <20050325101344.GA1297@elf.ucw.cz> <d120d500050325061963fb13db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050325061963fb13db@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > OK, anything else I should try?
> > >
> > > not really, i just wait for Vojtech and Pavel :-)
> > 
> > Try commenting out "call_usermodehelper". If that helps, Stefan's
> > theory is confirmed, and this waits for Vojtech to fix it.
> > 
> 
> This is more of a general swsusp problem I believe - the second phase
> when it blindly resumes entire system. Resume of a device can fail
> (any reason whatsoever) and it will attempt to clean up after itself,
> but userspace is dead and hotplug never completes. While I am
> interested to know why ALPS does not want to resume on ANdy's laptop
> the issue will never be completely resolved from within the input
> system.

When device fails to resume, what should I do? I think I could

	if (error)
		panic("Device resume failed\n");

, but... that does not look like what you want.

> Pavel, is it possible for swsusp to disable hotplug (probably just do
> hotplug_path[0] = 0) before resuming in suspend phase?

It feels like a hack, but yes, I probably could do that. (Do you have
patch to try?)

> A bit on tangent - you need to resume system so you can write the
> image, right? I wonder if we could add a flag to struct device that
> would mark device as "on_resume_path". The flag would be set when you
> select resume partition and propagated to the root of the system. Then
> when resume after making the image you could skip all devices that are
> not on resume path.

I'm not going to do that, see FAQ in swsusp.txt.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

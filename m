Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVCYPmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVCYPmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 10:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVCYPmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 10:42:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11662 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261673AbVCYPmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 10:42:52 -0500
Date: Fri, 25 Mar 2005 16:42:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050325154237.GB3738@elf.ucw.cz>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <20050325101344.GA1297@elf.ucw.cz> <d120d500050325061963fb13db@mail.gmail.com> <20050325142414.GF23602@elf.ucw.cz> <d120d50005032506526f6b9304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005032506526f6b9304@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is more of a general swsusp problem I believe - the second phase
> > > when it blindly resumes entire system. Resume of a device can fail
> > > (any reason whatsoever) and it will attempt to clean up after itself,
> > > but userspace is dead and hotplug never completes. While I am
> > > interested to know why ALPS does not want to resume on ANdy's laptop
> > > the issue will never be completely resolved from within the input
> > > system.
> > 
> > When device fails to resume, what should I do? I think I could
> > 
> >        if (error)
> >                panic("Device resume failed\n");
> > 
> > , but... that does not look like what you want.
> 
> Oh, always panic-happy Pavel ;). It really depends on what kind of
> device has faled to resume. If the device is really needed for writing
> image then panic is the only recourse, but if it some other device you
> resuming just ignore it, who cares...

You are right, for resume-during-suspend, we may as well risk it. We
have consistent state, and if we happen to write it on disk,
everything is okay.

For resume-during-resume, I don't really know how we can handle
that. Running with some devices non-working seems dangerous to me.

> Btw, I dont think that doing selective resume (as opposed to selective
> suspend and Nigel's partial device trees) would be so much
> complicated. You'd always resume sysdevs and then, when iterating over
> "normal" devices, just skip ones not in resume path. It can all be
> contained in driver core I believe (sorry but no patch, for now at
> least).

:-) I think we can simply make device freeze/unfreeze fast enough.
[We do not need to do full suspend/resume; freeze is enough].

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

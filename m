Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVCaWWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVCaWWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVCaWWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:22:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58271 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262026AbVCaWSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:18:38 -0500
Date: Fri, 1 Apr 2005 00:18:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050331221814.GC1802@elf.ucw.cz>
References: <20050329181831.GB8125@elf.ucw.cz> <1112135477.29392.16.camel@desktop.cunningham.myip.net.au> <20050329223519.GI8125@elf.ucw.cz> <200503310226.03495.dtor_core@ameritech.net> <Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net> <d120d50005033108321c8f4ae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005033108321c8f4ae7@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok, what do you think about this one?
> > >
> > > ===================================================================
> > >
> > > swsusp: disable usermodehelper after generating memory snapshot and
> > >         before resuming devices, so when device fails to resume we
> > >         won't try to call hotplug - userspace stopped anyway.
> > 
> > Hm, shouldn't we disable it before we start to freeze processes? We don't
> > want any more processes trying to start up after we've taken care of
> > them..
> > 
> 
> Can't a device be removed (for any reason) _while_ we are freezing
> processes? I think freeszing code will properly deal with it... What
> about suspend semantics - if suspend fails do we say the device should
> be operational or the system should attempt to re-initialize? I.e. we
> are not doing suspend after all - can we still drop messages on the
> floor? After all, we still have ability to run coldplug after failed
> suspend.

I believe we should freeze hotplug before processes. Dropping messages
on the floor should not be a problem, we should just call coldplug
after failed suspend.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

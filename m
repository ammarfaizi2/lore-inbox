Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVC2VOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVC2VOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVC2VNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:13:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18627 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261252AbVC2VM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:12:56 -0500
Date: Tue, 29 Mar 2005 23:12:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050329211239.GG8125@elf.ucw.cz>
References: <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com> <20050329181831.GB8125@elf.ucw.cz> <d120d50005032911114fd2ea32@mail.gmail.com> <20050329192339.GE8125@elf.ucw.cz> <d120d50005032912051fee6e91@mail.gmail.com> <20050329205225.GF8125@elf.ucw.cz> <d120d500050329130714e1daaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050329130714e1daaf@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't really want us to try execve during resume... Could we simply
> > artifically fail that execve with something if (in_suspend()) return
> > -EINVAL; [except that in_suspend() just is not there, but there were
> > some proposals to add it].
> > 
> > Or just avoid calling hotplug at all in resume case? And then do
> > coldplug-like scan when userspace is ready...
> > 
> 
> I am leaning towards calling disable_usermodehelper (not writtent yet)
> after swsusp completes snapshotting memory. We really don't care about
> hotplug events in this case and this will allow keeping "normal"
> resume in drivers as is. What do you think?

That would certianly do the trick.

[Or perhaps in_suspend() is slightly nicer solution? People wanted it
for other stuff (sanity checking, like BUG_ON(in_suspend())), too....]

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

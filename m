Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVC2XVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVC2XVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVC2XVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:21:50 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:16564 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261627AbVC2XV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:21:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Date: Wed, 30 Mar 2005 01:05:03 +0200
User-Agent: KMail/1.7.1
Cc: dtor_core@ameritech.net, Stefan Seyfried <seife@suse.de>,
       Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <4243252D.6090206@suse.de> <d120d500050329130714e1daaf@mail.gmail.com> <20050329211239.GG8125@elf.ucw.cz>
In-Reply-To: <20050329211239.GG8125@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503300105.03861.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 29 of March 2005 23:12, Pavel Machek wrote:
> Hi!
> 
> > > I don't really want us to try execve during resume... Could we simply
> > > artifically fail that execve with something if (in_suspend()) return
> > > -EINVAL; [except that in_suspend() just is not there, but there were
> > > some proposals to add it].
> > > 
> > > Or just avoid calling hotplug at all in resume case? And then do
> > > coldplug-like scan when userspace is ready...
> > > 
> > 
> > I am leaning towards calling disable_usermodehelper (not writtent yet)
> > after swsusp completes snapshotting memory. We really don't care about
> > hotplug events in this case and this will allow keeping "normal"
> > resume in drivers as is. What do you think?
> 
> That would certianly do the trick.
> 
> [Or perhaps in_suspend() is slightly nicer solution? People wanted it
> for other stuff (sanity checking, like BUG_ON(in_suspend())), too....]

IMHO, they are not mutually exclusive.    However, by using
disable_usermodehelper we would get rid of the reason (ie hotplug events)
instead of just curing the symptoms (ie execve() during suspend).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


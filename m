Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWHPBFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHPBFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 21:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWHPBFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 21:05:40 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16792 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750707AbWHPBFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 21:05:40 -0400
Subject: Re: peculiar suspend/resume bug.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060816003728.GA3605@redhat.com>
References: <20060815221035.GX7612@redhat.com>
	 <1155687599.3193.12.camel@nigel.suspend2.net>
	 <20060816003728.GA3605@redhat.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 11:05:44 +1000
Message-Id: <1155690344.3193.25.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave.

On Tue, 2006-08-15 at 20:37 -0400, Dave Jones wrote:
> On Wed, Aug 16, 2006 at 10:19:59AM +1000, Nigel Cunningham wrote:
>  > Hi Dave.
>  > 
>  > On Tue, 2006-08-15 at 18:10 -0400, Dave Jones wrote:
>  > > Here's a fun one.
>  > > - Get a dual core cpufreq aware laptop (Like say, a core-duo)
>  > > - Add a cpufreq monitor to gnome-panel. Configure it
>  > >   to watch the 2nd core.
>  > > - Suspend.
>  > > - Resume.
>  > > 
>  > > Watch the cpufreq monitor die horribly.
>  > > 
>  > > I believe this is because we take down the 2nd core at suspend
>  > > time with cpu hotplug, and for some reason we're scheduling
>  > > userspace before we bring that second core back up.
>  > > 
>  > > Anyone have any clues why this is happening?
>  > 
>  > If you hotunplug and replug the cpu using the sysfs interface, rather
>  > than suspending and resuming, does the same thing happen?
> 
> cpufreq-applet crashes as soon as the cpu goes offline.
> Now, the applet should be written to deal with this scenario more
> gracefully, but I'm questioning whether or not userspace should
> *see* the unplug/replug that suspend does at all.
> 
> IMO, when we shouldn't schedule userspace until the system is
> in the exact state it was before we suspended.

At the moment, the cpu hotplugging/unplugging is done outside of
freezing processes because once we've frozen processes we can't (afaik)
move ones that are tied to the cpu being unplugged to another processor,
and won't also be able to kill kernel threads that are tied to the
processor(s) being taken down.

Personally, I wouldn't mind being seeing this addressed as I see a few
other benefits to being able to hot[un]plug later, besides simplifying
life for the cpufreq-applet (although it shouldn't crash if a cpu is
offlined anyway).

Regards,

Nigel


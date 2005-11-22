Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVKVSrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVKVSrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVKVSrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:47:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63722 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965103AbVKVSrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:47:48 -0500
Date: Tue, 22 Nov 2005 19:47:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Bj?rn Mork <bjorn@mork.no>, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051122184739.GB1748@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com> <20051119234850.GC1952@spitz.ucw.cz> <200511220026.55589.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511220026.55589.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > >> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?
> > > > > >
> > > > > > Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> > > > > > know if 30 seconds timeout helps.
> > > > >
> > > > > It does.
> > > >
> > > > Ouch, yes, that's clear. It is stopping tasks during *resume*... So I
> > > > guess it gets wrong timing by design. Question is what to do with
> > > > that. Could we make keyboard driver pause the boot until it is done
> > > > resetting hardware? Or we can increase the timeout... would 10 seconds
> > > > be enough?
> > > 
> > > Well, I think 10 seconds when suspending is a nice and resonable
> > > number. For resume though I think we should wait much longer, maybe
> > > even indefinitely - the only thing that timeout achieves is makes
> > > people fsck because the system can't recover from that state.
> > 
> > I see your point, but it does not seem we need that changes this far. Your
> > patch is better, because we *could* hit that during suspend, just after 
> > keyboard hotplug... right? And it will make resume faster for affected people.
> 
> I disagree here. While my patch is a right thing to do (and as you
> know is already merged in mainline) it is not "better". Swsusp should
> not rely on the other subsystems being "nice" to it. Even with my
> patch there still could be moments when some thread is not suspended
> in 6 seconds when resuming causing unneeded resume failure and
> subsequent fsck. 
> 
> Please consider merging the patch below.

Well, I do not think this problem will surface again. It is first
failure in pretty long time. If it happens again, I'll take your
patch.
								Pavel
-- 
Thanks, Sharp!

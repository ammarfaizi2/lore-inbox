Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVKVWOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVKVWOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVKVWOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:14:39 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:25296 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030198AbVKVWOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:14:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Tue, 22 Nov 2005 23:15:30 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Bj?rn Mork <bjorn@mork.no>
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511220026.55589.dtor_core@ameritech.net> <20051122184739.GB1748@elf.ucw.cz>
In-Reply-To: <20051122184739.GB1748@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511222315.31033.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 22 of November 2005 19:47, Pavel Machek wrote:
> > > > > > >> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?
> > > > > > >
> > > > > > > Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> > > > > > > know if 30 seconds timeout helps.
> > > > > >
> > > > > > It does.
> > > > >
> > > > > Ouch, yes, that's clear. It is stopping tasks during *resume*... So I
> > > > > guess it gets wrong timing by design. Question is what to do with
> > > > > that. Could we make keyboard driver pause the boot until it is done
> > > > > resetting hardware? Or we can increase the timeout... would 10 seconds
> > > > > be enough?
> > > > 
> > > > Well, I think 10 seconds when suspending is a nice and resonable
> > > > number. For resume though I think we should wait much longer, maybe
> > > > even indefinitely - the only thing that timeout achieves is makes
> > > > people fsck because the system can't recover from that state.
> > > 
> > > I see your point, but it does not seem we need that changes this far. Your
> > > patch is better, because we *could* hit that during suspend, just after 
> > > keyboard hotplug... right? And it will make resume faster for affected people.
> > 
> > I disagree here. While my patch is a right thing to do (and as you
> > know is already merged in mainline) it is not "better". Swsusp should
> > not rely on the other subsystems being "nice" to it. Even with my
> > patch there still could be moments when some thread is not suspended
> > in 6 seconds when resuming causing unneeded resume failure and
> > subsequent fsck. 
> > 
> > Please consider merging the patch below.
> 
> Well, I do not think this problem will surface again. It is first
> failure in pretty long time. If it happens again, I'll take your
> patch.

If so, could you please make it printk() a message after the timeout has
passed?  This way the user will know what's going on at least.

Greetings,
Rafael

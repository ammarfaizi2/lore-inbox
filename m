Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUGYSLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUGYSLx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUGYSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 14:11:53 -0400
Received: from [66.35.79.110] ([66.35.79.110]:64933 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264256AbUGYSLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 14:11:51 -0400
Date: Sun, 25 Jul 2004 11:11:39 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@ximian.com>
Cc: dsaxena@plexity.net, Michael Clark <michael@metaparadigm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040725181139.GC1269@hockin.org>
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost> <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost> <20040724174636.GA29367@hockin.org> <1090693183.12088.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090693183.12088.21.camel@localhost>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 02:19:43PM -0400, Robert Love wrote:
> If some things can use the kobject path, we can use it in the argument
> field.  I am cool with that - that is exactly what I want, in fact.  But
> what we use as the naming convention needs to be something we can use
> uniformly.  Unfortunately not everything has a kobject backing it, and
> we cannot change that.

yeah.  I suppse that's true.  What's the meaning of the 'source' object,
generically?

> > This immediately strikes me as a really bad idea.  Stuff moves between
> > files.  Two files might really want to signal an event from the same
> > source.  
> 
> The signal name would be different.

I'm not sure why, yet, it just seems like a bad idea.

> I like your macro-izing idea and the notion of standardizing.  Someone
> else brought up a good example: we want _all_ disk drivers to emit the
> exact same signal for e.g. "disk full" so user-space can react to it.
> It needs to be consistent.  At least for driver error logging, we
> definitely want standards and macro-izing.  The translation point is
> another good reason for it.

So, when I was at Sun (no, I'm not at Sun anymore) there was lots of talk
of driver hardening and fault management.  At the time, the team in
question looked at the various event systems that currently exist in the
kernel or in some patches.  This list might be incomplete, but it's off
the top of my head.

- Netlink
- ACPI (/proc/acpi/event)
- hotplug
- IPMI (not merged maybe?)
- relayfs (not merged)
- evlog (last I saw, this was in big flux)

Now you're proposing netlink as the kevent subsystem.

Wouldn't it be nice if everything could converge?  Ok maybe not
EVERYTHING, but some of these?

These are the things I can see kevents being used for:

- Stateless messages which only matter if someone is listening.  Examples
  of this are "media changed" and stuff like that.

- Fault and error that matter no matter what, and can not afford to be
  dropped.  Examples are things like ECC errors, significant
  driver/subsystem errors, etc.

- System state messages, which really do want someone to be listening, but
  are otherwise discoverable.  Examples of this are "disk full" and
  similar.

So can kevents be used for all of these?  The fact that netlink does not
buffer events if there are no listeners (not saying it should..) makes it
unreliable for fault events.  Can these all be converged?

Sorry for rambling - kernel events has been on my mind for some time.

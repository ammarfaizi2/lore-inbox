Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266863AbUHRA1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUHRA1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUHRA1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:27:42 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:27264 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268532AbUHRA1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:27:31 -0400
Date: Wed, 18 Aug 2004 02:27:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040818002711.GD15046@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org> <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817161245.50dd6b96.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I can do that... but it will break compilation of every driver in the
> > tree. I can fix drivers I use and try to fix some more will sed, but
> > it will be painfull (and pretty big diff, and I'll probably miss some).
> 
> That's OK - it's just an hour's work.  I'd be more concerned about
> irritating people who are maintaining and using out-of-tree drivers.
> 
> Can you remind me why we need _any_ of this?  "enums to clear suspend-state
> confusion" sounds like something which is very optional.  I'd be opting to
> go do something else instead ;)

Okay... currently, we are passing u32 down the drivers. Some pieces
interpret it as a PCI state, and some pieces interpret it as a system
state. We really do want system state to go down to the drivers, so
they can do different thing on reboot vs. just-before-suspend-to-disk
etc.

Now, Patrick has some plans with device power managment and they
included something bigger being passed down to the drivers. I wanted
to prepare for those plans.

I can replace suspend_state_t with enum system_state, but it might
mean that enum system_state will have to be extended with things like
RUNTIME_PM_PCI_D0 in future... I guess that's easiest thing to do. It
solves all the problems we have *now*.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267733AbUHJUum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267733AbUHJUum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267735AbUHJUul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:50:41 -0400
Received: from gprs214-95.eurotel.cz ([160.218.214.95]:33153 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267733AbUHJUuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:50:23 -0400
Date: Tue, 10 Aug 2004 22:50:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810205006.GT28113@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <200408101218.25752.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101218.25752.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hmm, some of these proposals seem to relate to stuff OTHER than the
> device power management states.  While I suspect it might be a very
> handy thing to add methods to quiesce drivers (drivers have to have
> that anyway) the semantics need to be properly nailed down.

Okay, what about:

* switch system state to suspend_state_t (initialy u32)

* pass system state down to the drivers

* create helpers to convert from system state to PCI state (etc)

* create some well-known suspend_state_t's
	(like suspend_state_t prepare_for_powerdown = 3). Drivers may
	either compare state passed to them with one of well-known
	states, or call a helper

This should solve current mess. If we'll want to do runtime power
managment (etc), we can change suspend_state_t into structure /
whatever, but we will not break all the drivers this time. (=> this
approach does not solve runtime suspend, but will probably make it
easier).

I'd like to do this in 2.6.9 timeframe...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

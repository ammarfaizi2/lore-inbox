Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWENAWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWENAWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWENAWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:22:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:31655 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964827AbWENAWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:22:11 -0400
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200605120652.55658.david-b@pacbell.net>
References: <20060512100544.GA29010@elf.ucw.cz>
	 <20060512031151.76a9d226.akpm@osdl.org>
	 <200605120652.55658.david-b@pacbell.net>
Content-Type: text/plain
Date: Sun, 14 May 2006 10:21:56 +1000
Message-Id: <1147566116.21291.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think both Patrick Mochel and Alan Stern have sent patches at
> various times to let individual drivers provide a list of named
> states they support,  In some cases (like PCI) those lists could
> be delegated to bus-specific code.

I've several times expressed my opinion there that it's not bus states
that should be exposed by a driver but the actual states that the
driver/device combination supports _regardless_ of what bus state they
map to (if any). Bus states simply mean nothing at this point (Unless
you are the bus driver). Of course we need both top-down and bottom-up
dependency mecanisms to handle state changes, but at the user level, a
given PCI driver shouldn't expose something like "D1", "D2" and "D3"...
those are PCI states that don't have a well defined semantics (and may
not be all supported by the device/driver). However, it's whatever
functional states that device/driver supports that shall be exposed.
Those can be "idle" and "suspended" for example, or there could be
several levels of "suspended".

Now of course, there is the problem that while such descriptive names
might have a sense to a user (and even then, only in one language,
english) they aren't very useful to some automated power management
mecanism.

That's the whole problem that needs solving, possibly by exposing as
much as the state dependencies as possible, along eventually with
informations such as can the device automatically trigger a transition
out of this state, eventually informations relative to max power
consumed in this state (not only embedded devices but also desktop
machines nowadays have fairly strick power budgets when entering global
system suspend), etc...

That was one of the goal of the mecanisms I described more than a year
ago with bit masks exposing bus state <-> device state dependencies,
though not a complete solution, it was more like a starting point to
think from.

Due to various personal matter I haven't followed up much on what came
next on this list or during the last PM summit, but from some of the
mails I'm reading, I have the feeling that there haven't been much
progress...

Ben
 


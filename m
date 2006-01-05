Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWAEXyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWAEXyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAEXyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:54:36 -0500
Received: from digitalimplant.org ([64.62.235.95]:12447 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932189AbWAEXyf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:54:35 -0500
Date: Thu, 5 Jan 2006 15:54:15 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060105224403.GJ2095@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0601051546380.10428-100000@monsoon.he.net>
References: <20051227213439.GA1884@elf.ucw.cz>
 <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
 <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
 <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
 <20060105215528.GF2095@elf.ucw.cz> <Pine.LNX.4.50.0601051359290.10834-100000@monsoon.he.net>
 <20060105224403.GJ2095@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jan 2006, Pavel Machek wrote:

> On Čt 05-01-06 14:15:39, Patrick Mochel wrote:

> > It should be replaced with a file exported by the bus driver that exports
> > the actual states that the device supports. The parsing can easily happen
> > at this point, because the bus knows what a good value is.
>
> (1) would change core<->driver interface

It's broken anyway for runtime power management.

> (2) is quite a lot of work

In the long run, it's not.

> (3) ...with very little benefit, until drivers support >2 states

Without it, you are preventing drivers from being able to support > 2
states.

> I want to fix invalid values being passed down to drivers, not rewrite
> half of driver model.

Please don't exaggerate the issue.

> If you want to rewrite driver model for >2 states, great, but that is
> going to take at least a year AFAICS, so please let me at least fix
> the bugs in meantime.

It's a band-aid; it is not a long-term solution.

> > The userspace interface is broken. We can keep it for compatability
> > reasons, but there needs to be a new interface.
>
> I assumed we could fix the interface without actually introducing >2
> states support. That can be done in reasonable ammount of code.

The interface is irreparably broken. You can't fix it with an infinite
number of band aids.

> > I don't understand what you're saying. If I have a driver that Iwant to
>                                          ~~~~~~~~~~~~~~~~~~
> > make support another power state and I'm willing to write that code, then
> > there is a clear benefit to having the infrastructure for it to "just
> > work".
>
> I do not see such drivers around me, that's all. It seems fair to me
> that first driver author wanting that is the one who introduces >2
> states support to generic infrastructure.

Just because you personally have not seen such things does not mean they
do not exist.

> > If you want a more concrete example, consider the possibility where it may
> > be possible to reinitialize the device from D1 or D2, but not from D3. For
> > the radeon, this is true in some cases (if I understand Ben H
> > correctly).
>
> ...which seems like one more reason to only export "on" and "off" in
> radeon case. We don't want userspace to write "D3" to radeon, then
> wondering why it failed.

User application translates e.g. -EINVAL into "State not supported."

> Passing "on"/"off" down to radeon lets the driver decide what power
> state it should enter.

Driver implements power state policy? Sounds like that policy would find a
much more comfortable home in userspace.

Thanks,


	Patrick


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSGBPWr>; Tue, 2 Jul 2002 11:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSGBPWr>; Tue, 2 Jul 2002 11:22:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16400 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316797AbSGBPWq>; Tue, 2 Jul 2002 11:22:46 -0400
Date: Tue, 2 Jul 2002 11:20:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
In-Reply-To: <20020702123718.A4711@redhat.com>
Message-ID: <Pine.LNX.3.96.1020702111607.27954E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, Stephen C. Tweedie wrote:

> > 2 - restarting NICs when total reinitialization is needed. In server
> > applications it's sometimes necessary to move or clear a NIC connection,
> > force renegotiation because the blade on the switch was set wrong, etc.
> > It's preferable to take down one NIC for a moment than suffer a full
> > outage via reboot.
> 
> Again, you might want to do this even with a non-modular driver, or if
> you had one module driving two separate NICs --- the shutdown of one
> card shouldn't necessarily require the removal of the module code from
> the kernel, which is all Rusty was talking about doing.

Then you need a new ioctl to get the driver to go through the
initialization all over again, because the only time the cards are fully
probed is when the module is loaded. You can ifconfig up and down all day
and nothing improves. Oh, and reload resets the counts in the driver, that
sometimes very desirable as well.

Not that it can't be done, just that it works now, and reinventing modules
without remove seems a lot of work when we can just have some broken
modules which don't remove.

Also, as someone mentioned, it means a reboot every time you need to try
something new while doing module development. That doesn't sound like a
great idea...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


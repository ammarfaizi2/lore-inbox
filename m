Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWBTRzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWBTRzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWBTRzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:55:16 -0500
Received: from digitalimplant.org ([64.62.235.95]:19689 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1161084AbWBTRzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:55:15 -0500
Date: Mon, 20 Feb 2006 09:55:00 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power
 states in sysfs interface
In-Reply-To: <20060220004142.GI15608@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0602200938320.12708-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
 <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
 <20060220000907.GE15608@elf.ucw.cz> <Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
 <20060220002053.GF15608@elf.ucw.cz> <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
 <20060220004142.GI15608@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Pavel Machek wrote:

> On Ne 19-02-06 16:36:34, Patrick Mochel wrote:
> >
> > On Mon, 20 Feb 2006, Pavel Machek wrote:
> >
> > > On Ne 19-02-06 16:17:01, Patrick Mochel wrote:
> >
> > > > I really fail to see what your fundamental objection is. This restores
> > > > compatability, makes the core simpler, and adds the ability to use the
> > > > additional states, should drivers choose to implement them; all for
> > > > relatively little code. It seems a like a good thing to me..
> > >
> > > Compatibility is already restored.
> >
> > No, the interface is currently broken. The driver core does not
> > dictate
>
> There were two different interfaces, one accepted 0 and 2, everything
> else was invalid, and second accepted 0, 1, 2, 3.
>
> If you enter D2 on echo 2, you are breaking compatibility with 2.6.15
> or something like that.

I don't see how this is true. If a process writes "2" to a PCI device's
state file, what else are sane things to do?

You dropped the fundamental point, and I don't understand why you disagree
with it - the driver core should not be dictating policy to the downstream
drivers. It is currently doing this by filtering the power state that is
passed in via the "state" file.

> Please let this interface die and create new one. (And notice that
> this is exactly same advice you gave me month ago).

And I was sort of wrong. I think an ideal interface would allow the bus
drivers to export the states that they support, and would allow a state
name of any format to be written to that file.

One way to do that is to have each bus driver export its equivalent of a
"state" file for each device. But, a better solution is to leverage the
infrastructure that is already in place and export things through the
existing "state" file.

These patches are steps along that path. They prevent the core from
filtering the state value passed in. It's still an integer value, but it
allows any possible state to be used.

We could just as easily leave it as a string, and have the buses parse the
value to their expectations. Eventually we might want to do something like
that, or have them export a list of string states that they support.
Regardless, that is all in the future, and is completely orthogonal to
letting a device support more than just "on" or "off".

Thanks,


	Pat


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267429AbUHJFEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUHJFEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267428AbUHJFEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:04:24 -0400
Received: from digitalimplant.org ([64.62.235.95]:24210 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267429AbUHJFEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:04:15 -0400
Date: Mon, 9 Aug 2004 22:03:33 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, "" <benh@kernel.crashing.org>,
       "" <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <20040809212949.GA1120@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
 <20040809212949.GA1120@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Pavel Machek wrote:

> Well, "no DMA" needs to be part of definition, too, because some
> devices (USB) do DMA only if they have nothing to do.

I don't understand; that doesn't sound healthy.

> if something like this gets merged, it will immediately break swsusp
> because initially no drivers will have "stop" methods.
>
> Passing system state down to drivers and having special "quiesce"
> (as discussed in rather long thread) state has advantage of
> automagicaly working on drivers that ignore u32 parameter of suspend
> callback (and that's most of them). David's patches do not bring us
> runtime suspend capabilities, but do not force us to go through all
> the drivers, either...

Nothing is free. ;)

We've been talking about creating and merging a sane power management
model for 3+ years now. It's always been known that the drivers will have
to be modified to support a sane model. It's a fact of life. At some
point, we have to bite the bullet and do the work. I see that time rapidly
approaching.

I do not intend to merge a patch that will break swsusp in a stable
kernel. However, we do have this wonderful thing called the -mm tree in
which we can a) evolve the model, b) get large testing coverage and c)
solicit driver fixes.

Once the swsusp consolidation is merged upstream, I will merge a new
device power model in -mm, and we can start working on the drivers. How
does that sound?


	Pat

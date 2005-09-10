Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbVIJBs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVIJBs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVIJBs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:48:28 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:28040 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1030511AbVIJBs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:48:27 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=luvRanEGjzany1W9D15sKtxG00wyouol8JqPYG3GtZSjgOgne0+PogptWV3QXAEc8
	4LEaAvI8KxzmUOY328fsw==
Date: Fri, 09 Sep 2005 18:48:21 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com
References: <20050909103353.69687.qmail@web30311.mail.mud.yahoo.com>
In-Reply-To: <20050909103353.69687.qmail@web30311.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050910014821.62D26E9DF1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 9 Sep 2005 11:33:52 +0100 (BST)
> From: Mark Underwood <basicmark@yahoo.com>
>
> ...
> > That implies whoever is registering is actually
> > going and creating the
> > SPI devices ... and doing it AFTER the controller
> > driver is registered.
> > I actually have issues with each of those
> > implications.
>
> But how can you have a device that has no connection
> to the system (i.e. no registered adapter) :(. Why
> would you want to add SPI devices to adapters which
> aren't yet in the system?

The devices and adapters certainly are in the system;
that's hardware!  Do you maybe mean "before the driver
for an SPI adapter is bound to its device", and are
you maybe talking about driver model data structures?

The thing which exists before the SPI adapter driver is
bound to its device node is just a table.  It lists the
SPI devices, and holds information needed later to set
up the hardware.  Way simpler than ACPI or BIOS tables.


> > However, I was also aiming to support the model
> > where the controller
> > drivers are modular, and the "add driver" and
> > "declare hardware" steps
> > can go in any order.  That way things can work "just
> > like other busses"
>
> My subsystem does that. Once you have registered the
> core layer you can add SPI device drivers before or
> after registering SPI devices the only restriction is
> the you have to register a SPI adapter before
> registering any SPI devices which use that adapter.

That "only restriction" is the one I was talking about!!

It contorts the normal roles and responsiblities of the
adapter drivers; and it's not necessary.


> I think this is sensible as otherwise you have to keep a
> list of all SPI devices that have been registered and
> didn't have an adapter at that time and go through
> this list every time you register an adapter.

Lots of systems have their earliest boot code provide a
table of devices that exist (but which can't be probed).
That's how my patch approaches SPI.

As for that "every time" ... I don't know about you, but
the systems I've seen will register at most a handful of
devices and adapters; and adapters register just once.
For those numbers, even linear search is just fine.


> I have built your spi_init.c for an ARM946EJS and I
> get a .ko object of 5.1K

... but the ".text" size is MUCH less; and what I sent
was not built as a ".so", so there's other oddness too.
I got something on the order of 0x04d0 bytes with the
refresh I just posted (call it 1200 bytes text).

- Dave


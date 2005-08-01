Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVHAIDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVHAIDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVHAIDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:03:38 -0400
Received: from web30301.mail.mud.yahoo.com ([68.142.200.94]:35691 "HELO
	web30301.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbVHAICz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:02:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RUi+sLmX0tBz79fG77Q7by+cbx56QfJrnT6xpxECGxdDQ9h9RyThdyzWIaBnryazc7w2qNI7EPGh0CxAso+XX5xm9l6uOAXX3vnn+2GCNkAaYQKS/3tPsmcpTJ/n9eFpNjHI1EMxQU/jHRWUTJm3DtzHp45JT0k7dM3FkvL4/Y8=  ;
Message-ID: <20050801080246.76594.qmail@web30301.mail.mud.yahoo.com>
Date: Mon, 1 Aug 2005 09:02:46 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: How do we handle multi-function devices? [was Re: [patch] ucb1x00: touchscreen cleanups]
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1122849209.7626.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Richard Purdie <rpurdie@rpsys.net> wrote:

> On Sun, 2005-07-31 at 23:11 +0100, Mark Underwood
> wrote:
> > As this isn't the only chip of this sort (i.e. a
> > multi-function chip not on the CPU bus) maybe we
> > should store the bus driver in a common place. If
> > needed we could have a very simple bus driver
> > subsystem (this might already be in the kernel, I
> > haven't looked at the bus stuff) in which you
> register
> > a bus driver and client drivers register with the
> bus
> > driver. Just an idea :-).
> 
> This was the idea with the drivers/soc suggestion
> although I think that
> name is perhaps misleading.
> 
> How about drivers/mfd where mfd = Multi Functional
> Devices?

I was thinking of something like driver/bus into which
we might also be able to put the I2C and LL3 buses.
The only problem is that this might leave some parts
of the multi function chip homeless (if they can't
find a home in other subsystems).

> 
> I think it would be acceptable (and in keeping with
> the other drivers
> e.g. pcmcia) to seeing the arch and platform
> specific modules with the
> main driver as long as the naming reflected it (like
> the existing mcp
> and ucb code does) i.e.:
> 
> mcp-core.c
> mcp-sa1100.c
> ucb1x00-code.c
> ucb1x00-assabet.c
> ucb1x00-collie.c

Maybe, I haven't looked at pcmcia but the I2C
subsystem manages to avoid any arch dependent stuff so
couldn't we? I need to do more homework ;-), but
surely we only need a bus driver (IP block specific,
platform and arch independent), a core driver to
register busses and clients, and client drivers.

> 
> If code can be separated out into subsystems, I'm
> not so sure where they
> should go though. The existing policy would suggest
> drivers/input/touchscreen and sound/xxx for these...
> 
> ucb1x00-ts.c
> ucb1x00-audio.c

Yes, any function of a multi function device that can
live in a subsystem should do otherwise imagine the
mess, for example, with a chip that has a USB master
on it.

Mark

> 
> Opinions/Comments?
> 
> Richard
> 
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com

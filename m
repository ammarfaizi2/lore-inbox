Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUAWDOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266503AbUAWDOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:14:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:23258 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265859AbUAWDOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:14:52 -0500
Subject: Re: PATCH: Export console functions for use
	by	Software	Suspend	nice display
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@users.sourceforge.net
Cc: Daniel Jacobowitz <dan@debian.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1074827229.12773.198.camel@laptop-linux>
References: <1074757083.1943.37.camel@laptop-linux>
	 <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
	 <1074796577.12771.81.camel@laptop-linux>
	 <20040122203529.GB13377@nevyn.them.org> <1074826188.976.185.camel@gaston>
	 <1074827229.12773.198.camel@laptop-linux>
Content-Type: text/plain
Message-Id: <1074827571.974.191.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 14:12:51 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 14:07, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2004-01-23 at 15:49, Benjamin Herrenschmidt wrote:
> > Also, by using write instead of blasting the low level code,
> > you will not have to worry about locking issues. (The way
> > you tap the low level stuff should require at least the console
> > semaphore held, write to /dev/console don't)
> > 
> > Ben
> 
> Locking is not an issue. This is suspend-to-disk. Everything else is
> stopped while we're working.

No. You can still get a printk from irq... 

> By the way, am I understanding the suggestion correctly? Do you
> (collective) mean getting a fd for /dev/console from within kernel code
> and using that? I've been looking at the way printk works and wondering
> if con->write is equivalent (once I find the right console to write to)?

Yes. get an fd and write to it. grep for write to find other uses :)

You may have to be a bit careful about what context you are in, but I
suppose it's whatever userland process triggered the sleep in the
first place, no ? For load, it's probably whatever process did swapon ?

In both cases, it should be fine.

Ben.



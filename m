Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVLGWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVLGWJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVLGWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:09:13 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:64435 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030395AbVLGWJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:09:12 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Isaacson <adi@hexapodia.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206142237.GB1814@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost>
	 <20051206020626.GO22168@hexapodia.org> <1133835586.3896.33.camel@localhost>
	 <20051206142237.GB1814@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133993143.10276.257.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 08 Dec 2005 08:05:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-12-07 at 00:22, Pavel Machek wrote:
> Hi!
> 
> > Hi. Tue, 2005-12-06 at 12:06, Andy Isaacson wrote:
> > > Could we rework it to avoid writing clean pages out to the swsusp image,
> > > but keep a list of those pages and read them back in *after* having
> > > resumed?  Maybe do the /dev/initrd ('less +/once Documentation/initrd.txt'
> > > if you're not familiar with it) trick to make the list of pages available 
> > > to a userland helper.
> > 
> > The problem is that once you let userspace run, you have absolutely no
> > control over what pages are read from or written to, and if a userspace
> > app assumes that data is there in a page when it isn't, you have a
> > recipe for an oops at best, and possibly for on disk
> > corruption. Pages
> 
> No, that will not be a problem. You just resume system as you do now,
> most pages will be not there. *But kernel knows it is not there*, and
> will on-demand load them back. It will be normal userland application
> doing readback. There's absolutely no risk of corruption.

How does the kernel know the pages aren't there? I thought for a while
yesterday that I'd just misread something, but as I look at this again
this morning, I'm not so sure. For what you're talking about to work,
you'd need to mess with the page tables so that the kernel doesn't think
those pages are still there.

I can understand how you'd remember what pages to fault in, but getting
the kernel to know they're not there sounds like a rewrite of kswapd.

Regards,

Nigel

> Imagine something that saves list of needed pages before suspend, then
> does something like
> 
> cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
> 
> ...it should work pretty well. And worst thing it can do is send your
> system thrashing.
> 
> 								Pavel
-- 



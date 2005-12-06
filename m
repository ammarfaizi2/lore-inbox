Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVLFOXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVLFOXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVLFOXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:23:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10398 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932238AbVLFOXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:23:30 -0500
Date: Tue, 6 Dec 2005 15:22:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andy Isaacson <adi@hexapodia.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206142237.GB1814@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost> <20051206020626.GO22168@hexapodia.org> <1133835586.3896.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133835586.3896.33.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi. Tue, 2005-12-06 at 12:06, Andy Isaacson wrote:
> > Could we rework it to avoid writing clean pages out to the swsusp image,
> > but keep a list of those pages and read them back in *after* having
> > resumed?  Maybe do the /dev/initrd ('less +/once Documentation/initrd.txt'
> > if you're not familiar with it) trick to make the list of pages available 
> > to a userland helper.
> 
> The problem is that once you let userspace run, you have absolutely no
> control over what pages are read from or written to, and if a userspace
> app assumes that data is there in a page when it isn't, you have a
> recipe for an oops at best, and possibly for on disk
> corruption. Pages

No, that will not be a problem. You just resume system as you do now,
most pages will be not there. *But kernel knows it is not there*, and
will on-demand load them back. It will be normal userland application
doing readback. There's absolutely no risk of corruption.

Imagine something that saves list of needed pages before suspend, then
does something like

cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null

...it should work pretty well. And worst thing it can do is send your
system thrashing.

								Pavel
-- 
Thanks, Sharp!

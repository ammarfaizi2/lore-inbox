Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWG1SpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWG1SpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbWG1SpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:45:08 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15262 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751162AbWG1SpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:45:02 -0400
Date: Fri, 28 Jul 2006 22:44:45 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Zach Brown <zach.brown@oracle.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060728184445.GA10797@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru> <44CA586C.4010205@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44CA586C.4010205@oracle.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 28 Jul 2006 22:44:46 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 11:33:16AM -0700, Zach Brown (zach.brown@oracle.com) wrote:
> 
> > I completely agree that existing kevent interface is not the best, so
> > I'm opened for any suggestions.
> > Should kevent creation/removing/modification be separated too?
> 
> Yeah, I think so.

So, I'm going to create kevent_create/destroy/control and kevent_get_events()
Or any better names?

> >>> Hmm, it looks like I'm lost here...
> >> Yeah, it seems my description might not have sunk in :).  We're giving
> >> userspace a way to collect events without performing a system call.
> > 
> > And why do we want this?
> 
> So that event collection can be very efficient.
> 
> > How glibc is supposed to determine, that some events already fired and
> > such requests will return immediately, or for example how timer events
> > will be managed?
> 
> ...
> 
> That was what my previous mail was all about!

Some events are impossible to create in userspace (like timer
notification, which requires timer start and check when timer
completed).
Actually all events are part of the kernel, since glibc does not have
any knowledge about in-kernel state machines which are bound to
appropriate kevents, so each kevent takes at least two syscall (create
and get ready), and I do not see how, for exmple, glibc can avoid them
when user requested POLLIN or similar event for network dataflow?

According to syscall speed on Linux, last time I checked empty syscall 
took about 100ns on AMD Athlon 3500+.

> - z

-- 
	Evgeniy Polyakov

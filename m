Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751972AbWG1FXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbWG1FXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWG1FXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:23:33 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:17328 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751773AbWG1FXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:23:32 -0400
Date: Fri, 28 Jul 2006 09:23:12 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Zach Brown <zach.brown@oracle.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060728052312.GB11210@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44C930D5.9020704@oracle.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 28 Jul 2006 09:23:14 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 02:32:05PM -0700, Zach Brown (zach.brown@oracle.com) wrote:
> 
> >> 	int kevent_getevents(int event_fd, struct ukevent *events,
> >> 		int min_events, int max_events,
> >> 		struct timeval *timeout);
> > 
> > I used only one syscall for all operations, above syscall is
> > essentially what kevent_user_wait() does.
> 
> Essentially, yes, but the differences are important.  It's important to
> have a clear syscall interface instead of nesting through multiplexers.
>  And we should get the batching/latency inputs right.  (I'm for both
> min/max elements and arguably timeouts, but I could understand not
> wanting to go *that* far.)

I completely agree that existing kevent interface is not the best, so
I'm opened for any suggestions.
Should kevent creation/removing/modification be separated too?

> > Hmm, it looks like I'm lost here...
> 
> Yeah, it seems my description might not have sunk in :).  We're giving
> userspace a way to collect events without performing a system call.

And why do we want this?
How glibc is supposed to determine, that some events already fired and
such requests will return immediately, or for example how timer events
will be managed?

> > I especially like idea about world happinness in a week or so :)
> 
> A few weeks! :)

No matter after couple of millions of years of human evolution :)

> - z

-- 
	Evgeniy Polyakov

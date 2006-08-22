Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWHVS0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWHVS0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHVS0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:26:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31624 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932335AbWHVS0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:26:40 -0400
Date: Tue, 22 Aug 2006 22:25:33 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take12 3/3] kevent: Timer notifications.
Message-ID: <20060822182533.GB30142@2ka.mipt.ru>
References: <11561555893621@2ka.mipt.ru> <1156155589287@2ka.mipt.ru> <20060821111239.GA30945@infradead.org> <20060821111848.GB8608@2ka.mipt.ru> <1156170349.4725.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156170349.4725.29.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 22 Aug 2006 22:25:42 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 04:25:49PM +0200, Thomas Gleixner (tglx@linutronix.de) wrote:
> > Not everymachine has them 
> 
> Every machine has hrtimers - not necessarily with high resolution timer
> support, but the core code is there in any case and it is designed to
> provide fine grained timers. 
> 
> In case of high resolution time support one would expect that the "fine
> grained" timer event is actually fine grained.

Ok, I should reformulate, that currently not every machine has support
in kernel. Obviously each machine has a clock which runs faster than
jiffies.
And as a side note - kevents were created half a year ago - there were
no hrtimers in kernel in that time, btw, does kernel have high-resolutin
clock engine already in?

> > and getting into account possibility that
> > userspace can be scheduled away, it will be overkill.
> 
> If you think out your argument then everything which is fine grained or
> high responsive should be removed from userspace access for the very
> same reason. Please look at the existing users of the hrtimer subsystem
> - all of them are exposed to userspace.

Getting into account that system call gets more than 100 nsec, and one
should create kevent and then read it (with at least three rescheduling
- after two syscalls and wake up), it is not exactly the best way to
obtain nanoseconds resolution. And even one usec is good one for
userspace, and I can create an interface through kevents, but let's get
it real - if we still can not agree on other issues, should we do it
right now? I would like kevent core's issues are resolved and everyone
become happy with it before adding new kevent users.

If everyone says "yes, replace usual timers with high-resolution ones",
then ok, I will schedule it for the next patchset.

> 	tglx
> 

-- 
	Evgeniy Polyakov

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSKSM0G>; Tue, 19 Nov 2002 07:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKSM0G>; Tue, 19 Nov 2002 07:26:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51118 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264666AbSKSM0F>;
	Tue, 19 Nov 2002 07:26:05 -0500
Date: Tue, 19 Nov 2002 13:33:07 +0100
From: bert hubert <ahu@ds9a.nl>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Grant Taylor <gtaylor+lkml_cjiia111802@picante.com>,
       linux-kernel@vger.kernel.org, davidel@xmailserver.org
Subject: having indistinguishable events halves epoll utility
Message-ID: <20021119123307.GA7300@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mark Mielke <mark@mark.mielke.cc>,
	Grant Taylor <gtaylor+lkml_cjiia111802@picante.com>,
	linux-kernel@vger.kernel.org, davidel@xmailserver.org
References: <200211182204.gAIM47mU030748@habanero.picante.com> <20021118223214.GC14649@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118223214.GC14649@mark.mielke.cc>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 05:32:14PM -0500, Mark Mielke wrote:
> On Mon, Nov 18, 2002 at 05:04:07PM -0500, Grant Taylor wrote:
> > OTOH, I really hate the "user pointer in struct epollfd" thing...
> 
> An opaque field gives me, the event loop designer, freedom. No opaque
> field because a few event loop designers are convinced that it will be
> used as a data pointer, and they believe this to be wrong, is a
> limitation. epoll provides a very efficient alternative to poll. Forcing

If epoll only returns 'bald events' that like electrons are
indistinguishable, userspace will have to do expensive accounting. In fact,
work on MTasker (http://ds9a.nl/mtasker) already necessitated additional
accounting in user space in order to report events back to the right task.

Such double accounting really hurts epoll scalability benefits and means
doing work in the wrong place. It is like we now have kallsyms - the kernel
is well suited to contain that data and do the work. A weaker example is the
in-kernel module loader.

Another solution might be to have the kernel assign an id on epoll_ctl
insert time and store that in the struct. As we are unlikely to have >2^31
events in flight, 32 bits would suffice easily. 

But in any case - the cost of preventing 'malicious users' from storing a
single pointer in the kernel is massive amounts of double work. We are in
that case not offering a useful interface.

So from me as an application & library developer, please do the opaque
pointer thing. By the way, Davide, do you think the time is ripe to wrap up
the manpages now? I could finalize them if you want.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

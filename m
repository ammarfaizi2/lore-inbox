Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSKHRti>; Fri, 8 Nov 2002 12:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266850AbSKHRti>; Fri, 8 Nov 2002 12:49:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:51076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266851AbSKHRth>;
	Fri, 8 Nov 2002 12:49:37 -0500
Subject: Re: [Linux-ia64] reader-writer livelock problem
From: Stephen Hemminger <shemminger@osdl.org>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       linux-ia64@linuxia64.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au,
       dhowells@redhat.com, mingo@elte.hu,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <18894.1036776883@warthog.cambridge.redhat.com>
References: <18894.1036776883@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 09:55:39 -0800
Message-Id: <1036778139.20416.197.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 09:34, David Howells wrote:
> 
> > The normal way of solving this fairness problem is to make pending write
> > locks block read lock attempts, so that the reader count is guaranteed
> > to drop to zero as read locks are released.  I haven't looked at the
> > Linux implementation of rwlocks, so I don't know how hard this is to
> > do.  Or perhaps there's some other reason for not implementing it this
> > way?
> 
> Actually implementing a fair spinlocks and fair rwlocks on the x86 arch are
> very easy (at least, if you have XADD it is). Any arch which has CMPXCHG can
> also do it, just not so easily.
> 
> I've attached an implementation of a fair spinlock and an implementation of a
> fair rwlock (which can be compiled and played with in u-space).
> 
> David

There are a selection of similar algorithms here:
	http://www.cs.rochester.edu/u/scott/synchronization/pseudocode/rw.html#s_f

How does yours compare?




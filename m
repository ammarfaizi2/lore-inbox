Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWHWIpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWHWIpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWHWIpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:45:07 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:24284 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964789AbWHWIpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:45:05 -0400
Date: Wed, 23 Aug 2006 12:39:00 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jari Sundell <sundell.software@gmail.com>
Cc: David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823083859.GA8936@2ka.mipt.ru>
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com> <20060822231129.GA18296@ms2.inr.ac.ru> <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com> <20060822.173200.126578369.davem@davemloft.net> <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com> <20060823065659.GC24787@2ka.mipt.ru> <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 12:39:04 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 10:22:06AM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> On 8/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >void * in structure exported to userspace is forbidden.
> 
> Only void * I'm seeing belongs to the user, (udata) perhaps you are
> talking of something different?

Yes, exactly about it.

I put union {
	u32 a[2];
	void *b;
} 
epcially to eliminate that problem.

And I'm not that sure aboit stuff like uptr_t or how they call pointers
in userspace and kernelspace.

> >long in syscall requires wrapper in per-arch code (although that
> >workaround _is_ there, it does not mean that broken interface should
> >be used).
> >poll uses millisecods - it is perfectly ok.
> 
> The kernel is there to hide those ugly implementation details from the
> user, so I don't care that much about a workaround being required in
> some cases. More important, IMHO is consistency with the POSIX system
> calls.
> 
> I guess as long as you use usec, at least it won't be a pain to use.

Andrew suggested to use nanoseconds there in u64 variable.
I think it is ok.

> Rakshasa

-- 
	Evgeniy Polyakov

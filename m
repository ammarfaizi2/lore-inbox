Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWHWKVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWHWKVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWHWKVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:21:49 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:10655 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964815AbWHWKVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:21:48 -0400
Date: Wed, 23 Aug 2006 14:20:37 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jari Sundell <sundell.software@gmail.com>
Cc: David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823102037.GA23664@2ka.mipt.ru>
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com> <20060822231129.GA18296@ms2.inr.ac.ru> <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com> <20060822.173200.126578369.davem@davemloft.net> <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com> <20060823065659.GC24787@2ka.mipt.ru> <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com> <20060823083859.GA8936@2ka.mipt.ru> <b3f268590608230249q653e1dfh1d77c07f6f4e82ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b3f268590608230249q653e1dfh1d77c07f6f4e82ce@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 14:20:42 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 11:49:22AM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> >> Only void * I'm seeing belongs to the user, (udata) perhaps you are
> >> talking of something different?
> >
> >Yes, exactly about it.
> >
> >I put union {
> >        u32 a[2];
> >        void *b;
> >}
> >epcially to eliminate that problem.
> 
> It's just random data of a known maximum size appended to the struct,
> I'm sure you can find a clean way to handle it. If you mangle the
> first variable name in your union, you'll end up with something that
> should be usable instead of udata.

If there will be usual pointer, size of the whole structure will be
different in kernel and userspace.

> >And I'm not that sure aboit stuff like uptr_t or how they call pointers
> >in userspace and kernelspace.
> 
> Well, I can't find any use of pointers in your struct ukevent, nor in
> any of the kqueue events in my man page. So if this is a deficit it
> applies to both, I guess?

No, it will change sizes of the structure in kernelspace and userspace,
so they just can not communicate.

> >ukevent is aligned to 8 bytes already (it's size selected to be 40 bytes),
> >so it should not be a problem.
> >
> >> Eric
> 
> Even if it is so, wouldn't it be better to be explicit about it?

Ok, I will add a comment about it.

> Rakshasa

-- 
	Evgeniy Polyakov

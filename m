Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271618AbRIGIfg>; Fri, 7 Sep 2001 04:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRIGIf1>; Fri, 7 Sep 2001 04:35:27 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:40460 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271618AbRIGIfN>;
	Fri, 7 Sep 2001 04:35:13 -0400
Message-ID: <20010907124220.A27338@castle.nmd.msu.ru>
Date: Fri, 7 Sep 2001 12:42:20 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Julian Anastasov <ja@ssi.bg>
Cc: Wietse Venema <wietse@porcupine.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010907115416.A26786@castle.nmd.msu.ru> <Pine.LNX.4.33.0109071053390.1692-100000@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.33.0109071053390.1692-100000@u.domain.uli>; from "Julian Anastasov" on Fri, Sep 07, 2001 at 11:09:57AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 11:09:57AM +0000, Julian Anastasov wrote:
> 
> On Fri, 7 Sep 2001, Andrey Savochkin wrote:
> 
> > > 	It seems if connect() is called without bind() and the target
> > > is local address the selected source is the same (the preferred address
> > > is not used). The postfix guys simply can try this proposal (I don't
> >
> > I've just checked, you're right.
> > In the mainstream 2.4 kernels for local routes setting the source to be equal
> > to the target overrides the preferred source from the route.
> 
> 	I saw it in the 2.2 sources, so it is the same there.
> 
> > I personally consider it as a bug.
> 
> 	Agreed. OTOH, nobody plays with the preferred source in the
> local table. Now the question is whether this is a bug or a feature :)
> In any case, if the admins don't play with the prefsrc in table local
> the above assumption about connecting to local address still works
> for IP/32 (but not for targets in the 127/8 range different from

In my opinion, the priorities in address selection should be the following:
 1. always use prefsrc if it is specified
 2. then for local routes, use destination
 3. as a last resort, call that function guessing the address...

> 127.0.0.1). Hm, may be then a bind() call to the same IP will be required
> before connecting? If bind fails, then the address is not local. If
> not, connect() should succeed and getsockname should return the same
> IP (the preferred source will not be considered in this case from
> the kernel).

I would say that using of bound sockets is a bit risky.
I'm not sure whether such a connect may succeed with 2.2 kernels and
transparent proxy support, for example.

An unbound UDP connect, as autofs does, is a good solution if the mistakes are
acceptable.
The behavior of autofs in case of a mistake, as Peter explained, looks
reasonable and acceptable for me.

Using GETROUTE as Andi suggested is the other good alternative.
But it won't work without NETLINK socket support compiled in.

	Andrey

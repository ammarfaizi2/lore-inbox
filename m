Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIGJG5>; Fri, 7 Sep 2001 05:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271625AbRIGJGr>; Fri, 7 Sep 2001 05:06:47 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:42506 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S271627AbRIGJGf>;
	Fri, 7 Sep 2001 05:06:35 -0400
Date: Fri, 7 Sep 2001 12:08:05 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: Wietse Venema <wietse@porcupine.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip
 aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010907124220.A27338@castle.nmd.msu.ru>
Message-ID: <Pine.LNX.4.33.0109071140010.1692-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 7 Sep 2001, Andrey Savochkin wrote:

> In my opinion, the priorities in address selection should be the following:
>  1. always use prefsrc if it is specified
>  2. then for local routes, use destination
>  3. as a last resort, call that function guessing the address...

	So, you mean such change:

	if (!key.src)
		key.src = key.dst;
with
	if (!key.src)
		key.src = res.fi->fib_prefsrc ?: key.dst;

	key.dst is != 0, so, we don't need to call FIB_RES_PREFSRC
and inet_select_addr, we prefer key.dst as source.

> > 127.0.0.1). Hm, may be then a bind() call to the same IP will be required
> > before connecting? If bind fails, then the address is not local. If
> > not, connect() should succeed and getsockname should return the same
> > IP (the preferred source will not be considered in this case from
> > the kernel).
>
> I would say that using of bound sockets is a bit risky.
> I'm not sure whether such a connect may succeed with 2.2 kernels and
> transparent proxy support, for example.

	Oh, yes, the tproxy ... the connect call should be without bind,
so this soulution is not entirely perfect when "local networks" are
used (on lo) or when the above feature is considered a bug. Agreed for
the next part of the mail... Hm, time to go to netdev

> 	Andrey

Regards

--
Julian Anastasov <ja@ssi.bg>


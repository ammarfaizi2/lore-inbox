Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271612AbRIGIJB>; Fri, 7 Sep 2001 04:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271614AbRIGIIl>; Fri, 7 Sep 2001 04:08:41 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:46855 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S271612AbRIGIIi>;
	Fri, 7 Sep 2001 04:08:38 -0400
Date: Fri, 7 Sep 2001 11:09:57 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip
 aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010907115416.A26786@castle.nmd.msu.ru>
Message-ID: <Pine.LNX.4.33.0109071053390.1692-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 7 Sep 2001, Andrey Savochkin wrote:

> > 	It seems if connect() is called without bind() and the target
> > is local address the selected source is the same (the preferred address
> > is not used). The postfix guys simply can try this proposal (I don't
>
> I've just checked, you're right.
> In the mainstream 2.4 kernels for local routes setting the source to be equal
> to the target overrides the preferred source from the route.

	I saw it in the 2.2 sources, so it is the same there.

> I personally consider it as a bug.

	Agreed. OTOH, nobody plays with the preferred source in the
local table. Now the question is whether this is a bug or a feature :)
In any case, if the admins don't play with the prefsrc in table local
the above assumption about connecting to local address still works
for IP/32 (but not for targets in the 127/8 range different from
127.0.0.1). Hm, may be then a bind() call to the same IP will be required
before connecting? If bind fails, then the address is not local. If
not, connect() should succeed and getsockname should return the same
IP (the preferred source will not be considered in this case from
the kernel).

> Why do we have preferred source field in the routes if not to override how
> the kernel selects the source by itself?
>
> 	Andrey

Regards

--
Julian Anastasov <ja@ssi.bg>


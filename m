Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271514AbRIGHJa>; Fri, 7 Sep 2001 03:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271550AbRIGHJV>; Fri, 7 Sep 2001 03:09:21 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:47364 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S271514AbRIGHJM>;
	Fri, 7 Sep 2001 03:09:12 -0400
Date: Fri, 7 Sep 2001 10:10:01 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip
 aliasbug 2.4.9 and 2.2.19]
Message-ID: <Pine.LNX.4.33.0109070944510.1449-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Andrey Savochkin wrote:

> > > connect a datagram socket (which won't produce any actual traffic) to
> > > the remote host with INADDR_ANY as the local address, and then query
> > > the local address.  If the local address is the same as the remote
> > > address, the address is local.
> >
> > That will always work, even when you have multiple ethernet
> > interfaces??
>
> It will work almost always, except cases where administrator set different
> preffered sources in local routes.

	It seems if connect() is called without bind() and the target
is local address the selected source is the same (the preferred address
is not used). The postfix guys simply can try this proposal (I don't
know whether they tried it already). I don't expect netfilter to make
loops by connecting the both ends on same host, so such solution can
return the best actual result that is possible at the time of the request.
Any assumptions on daemon start what are the local IP addresses can be
wrong for some strange setups.

	May be someone can check whether this is a portable way to
check whether one IP is local. [We know that bind() to IP is not such
solution, at least in Linux]. If this is true, I think, it is better than
using ioctls or talking rtnetlink.

	As for the "local networks" there is no such thing. There are
trusted and non-trusted networks, gatewayed and non-gatewayed, etc. So, it
should be a user-defined setting, if used somehow at all.

> I.e. it is indeed a very good approximation, but autofs shouldn't still hang
> or do nasty things if the check with the datagram socket shows that address
> isn't local, but in reality it happens to be local.
> A subtle misbehavior or loss of efficiency are acceptable, in my opinion.

Regards

--
Julian Anastasov <ja@ssi.bg>


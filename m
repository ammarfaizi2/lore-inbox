Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEXVZ3>; Fri, 24 May 2002 17:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSEXVZ3>; Fri, 24 May 2002 17:25:29 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:30155 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S311710AbSEXVZ2>; Fri, 24 May 2002 17:25:28 -0400
Date: Fri, 24 May 2002 23:25:12 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Myrddin Ambrosius <imipak@yahoo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        tori@ringstrom.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
In-Reply-To: <20020524201715.97204.qmail@web12301.mail.yahoo.com>
Message-ID: <Pine.GSO.4.05.10205242308280.11037-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--snip/snip

> > ... but what about having all the crypto stuff in
> > question beeing handled
> > by modules (developed outside the USSA) and having
> > the networking-related
> > code in the kernel - could the hooks itself be a
> > problem?
> 
> Hmmmm. This would be an interesting idea. In theory, I
> don't see why this couldn't be done via an extension
> of the existing network hooks.
> 
> IIRC, there are hooks for adding new networking
> protocols, so it shouldn't be too difficult to extend
> this mechanism.
> 
> What you'd need is the ability to layer one transport
> mechanism over another, as well as add them in
> parallel. That way, you're not adding hooks to be used
> -for- IPSec, merely hooks that IPSec could exploit.

right - i was on the way looking into some "pluggable"
system for the datalink layer in any case - and stumbled
across other implementations: FreeBSDs netgraph, and
also SysV streams. (i don't think netgraph works on
layers >= network ... but that's another story)

> This could also be used to simplify the tunneling
> code. A tunnel would become an n-deep stack of
> transport mechanisms, each piping into the next.

well, you need also some hooks to hook into some arbitrary
points in this "chain". - for setting up the tunnel, ...
but yes, should be doable.

> Instead of having to write a new tunneling system for
> every possible combination, you'd simply write your
> transport mechanism to support a "generic" input and
> "generic" output channel. Any protocol could then be
> tunelled through any other protocol, including a
> protocol which is already being used to tunnel.

right: for the datalink layer it your be decaps and
encaps (or X_type_trans and hard_header right now)
- looks a little bit different on higher layers.

> For IPSec, this translates to the transport mode
> becoming: network protocol -> IPSec
> 
> And, for tunneling mode, you'd want something like:
> network protocol -> IPSec -> network protocol

seems to be ok (guess you just don't count DLL)

> By allowing protocol stacks, and by having a generic
> interface, it would be easy to throw the output over a
> non-IP connection.

since you should be able (at least in theory) to have
deep nested stacks of protocols - including really ugly
combinations

> At present, if you want to use IPSec over ATM, you'd
> need two tunnels. One for IPSec over IP, and one for
> IP over ATM. Each would need to be independently
> maintained, and you'd end up with a fascinating
> routing table, trying to get packets from one virtual
> device to another virtual device, through a virtual
> network space, without the router daemon deciding that
> what you REALLY want is some clam chowder.

problem is: clam chowder is really tasty - but you cannot
get it everywhere :)

> With the layering concept, you're simply wrapping one
> protocol in another, as many deep as you like, to
> produce a single, composite device, with the precice
> characteristics you want. For the IPSec over ATM,
> you've no tunnels, just the two wrappers (IP->IPSec,
> and IPSec->ATM), to produce a composite IP->IPSec->ATM
> virtual device.

yup.

> This is gettig WAAY too off-topic, at this point, but
> I could picture the protocols themselves being built
> up, LEGO-style, out of sub-components, both in
> parallel and as wrappers. The "standard" protocols
> would then be simply one way to wire the networking
> code, but there'd be a virtually infinite number of
> combinations you could do.

sure. - one thing which could get a little bit hairy are
the combinations where:
	you have to setup the connection at some layer(s)
		connection orientated
	you'd like to have different addressed at different
		layers.
but i guess you could use a userland tool for that.

there is a streams implementation for linux out there (LiS),
which could be capable of providing the above functionality
- but i'm not aware of the performance impact.

		tm

-- 
in some way i do, and in some way i don't.


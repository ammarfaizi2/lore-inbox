Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSEXURR>; Fri, 24 May 2002 16:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314957AbSEXURQ>; Fri, 24 May 2002 16:17:16 -0400
Received: from web12301.mail.yahoo.com ([216.136.173.99]:47528 "HELO
	web12301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314938AbSEXURP>; Fri, 24 May 2002 16:17:15 -0400
Message-ID: <20020524201715.97204.qmail@web12301.mail.yahoo.com>
Date: Fri, 24 May 2002 13:17:15 -0700 (PDT)
From: Myrddin Ambrosius <imipak@yahoo.com>
Subject: Re: Linux crypto?
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, tori@ringstrom.mine.nu,
        imipak@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205242028060.11037-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Thomas 'Dent' Mirlacher <dent@cosy.sbg.ac.at>
wrote:
> well probably everything which isn't plain english
> written with a pen
> on white paper would be outlawed by then ;)

Should be easy to test:

if [ cat /usa/laws | grep ban | grep written | grep -q
english ]; then
  echo "Ok, time to panic"
fi

Output:

"You're too late. That's a $1000 fine, for using
dictionary words."

> ... but what about having all the crypto stuff in
> question beeing handled
> by modules (developed outside the USSA) and having
> the networking-related
> code in the kernel - could the hooks itself be a
> problem?

Hmmmm. This would be an interesting idea. In theory, I
don't see why this couldn't be done via an extension
of the existing network hooks.

IIRC, there are hooks for adding new networking
protocols, so it shouldn't be too difficult to extend
this mechanism.

What you'd need is the ability to layer one transport
mechanism over another, as well as add them in
parallel. That way, you're not adding hooks to be used
-for- IPSec, merely hooks that IPSec could exploit.

This could also be used to simplify the tunneling
code. A tunnel would become an n-deep stack of
transport mechanisms, each piping into the next.
Instead of having to write a new tunneling system for
every possible combination, you'd simply write your
transport mechanism to support a "generic" input and
"generic" output channel. Any protocol could then be
tunelled through any other protocol, including a
protocol which is already being used to tunnel.

For IPSec, this translates to the transport mode
becoming: network protocol -> IPSec

And, for tunneling mode, you'd want something like:
network protocol -> IPSec -> network protocol

By allowing protocol stacks, and by having a generic
interface, it would be easy to throw the output over a
non-IP connection.

At present, if you want to use IPSec over ATM, you'd
need two tunnels. One for IPSec over IP, and one for
IP over ATM. Each would need to be independently
maintained, and you'd end up with a fascinating
routing table, trying to get packets from one virtual
device to another virtual device, through a virtual
network space, without the router daemon deciding that
what you REALLY want is some clam chowder.

With the layering concept, you're simply wrapping one
protocol in another, as many deep as you like, to
produce a single, composite device, with the precice
characteristics you want. For the IPSec over ATM,
you've no tunnels, just the two wrappers (IP->IPSec,
and IPSec->ATM), to produce a composite IP->IPSec->ATM
virtual device.

This is gettig WAAY too off-topic, at this point, but
I could picture the protocols themselves being built
up, LEGO-style, out of sub-components, both in
parallel and as wrappers. The "standard" protocols
would then be simply one way to wire the networking
code, but there'd be a virtually infinite number of
combinations you could do.

(Most of those combinations would be meaningless, but
could prove highly entertaining!)


__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com

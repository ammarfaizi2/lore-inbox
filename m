Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSD2OUd>; Mon, 29 Apr 2002 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSD2OUc>; Mon, 29 Apr 2002 10:20:32 -0400
Received: from elin.scali.no ([62.70.89.10]:36879 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S312316AbSD2OUb>;
	Mon, 29 Apr 2002 10:20:31 -0400
Subject: Re: Possible bug with UDP and SO_REUSEADDR.
From: Terje Eggestad <terje.eggestad@scali.com>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020429103823.AAA26425@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 16:20:29 +0200
Message-Id: <1020090029.22027.121.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-29 at 12:38, David Schwartz wrote:
> 
> >However, I still can't see any *practical* use of having one program
> >(me) bind the port, deliberately share it, and another program (you)
> >coming along and want to share it, and then all unicast datagrams are
> >passed to you. Not If I haven't subscribed to any multicast addresses,
> >and no one is sending bcasts, there is no point of me being alive.
> >
> >Can you come up with a real life situation where this make sense?
> 
> 	Absolutely. This is actually used in cases where you have a 'default' 
> handler for a protocol that is built into a larger program but want to keep 
> the option to 'override' it with a program with more sophisticated behavior 
> from time to time. In this case, the last socket should get all the data 
> until it goes away.
> 
> 	DS
> 

First of all since we're in agreement that the current behavior is NOT a
bug, this discussion is pretty pointless, however I getting worked up.

In all fairness, I've a colleague that did an implementation of TCPIP a
decade ago, and his in agreement in that the current logic this is the
way implementations worked. Thus we're less likely to break things
leaving this they way they are. 

However you logic is broken.
First of all, I asked for a case where it make sense, not where it's
moronically been done so. If you review your own argument:

> That's why if you mean to share, you should share the actual socket 
> descriptor rather than trying to reference the same transport endpoint
> with two different sockets.

The program that want to "override" shall connect the first on a
AF_UNIX, get the descriptor and be told not to read from the UDP socket
until the AF_UNIX socket to the overrider is broken/disconnected.

Since according to Stevens, what happen here is implementation specific,
the "overriding" you describe is non-portable.

If you look at you other argument: 
>        NO. When you set the SO_REUSEADDR, you are telling the 
> kernel that you intend to share your port with *someone*, but not who.
> The kernel has no way to know that two processes that bind to the same
> UDP port with SO_REUSEADDR  are the two that were intended to 
> cooperate with each other. For all it knows, one is a foo intended to
> cooperate with other foo's and the other is a bar intended to 
> cooperate with other bar's.

The logical deduction from this is that you should never, ever, use bind
to the same address for unicast since the kernel don't have the
sufficient information to route the datagram correctly. I *COULD* agree
to that it should be illegal to duplicate bind to an address.

Trouble is now that is actually legal...

TJ
 
> 
> 
> 
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________


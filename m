Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271334AbRIFQcH>; Thu, 6 Sep 2001 12:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271347AbRIFQb5>; Thu, 6 Sep 2001 12:31:57 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:62984 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271334AbRIFQbn>;
	Thu, 6 Sep 2001 12:31:43 -0400
Message-ID: <20010906203854.A23109@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 20:38:54 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906173534.A21874@castle.nmd.msu.ru> <20010906140444.75DC1BC06C@spike.porcupine.org> <20010906162124.D29583@maggie.dt.e-technik.uni-dortmund.de> <20010906193750.B22187@castle.nmd.msu.ru> <20010906180130.H29583@maggie.dt.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010906180130.H29583@maggie.dt.e-technik.uni-dortmund.de>; from "Matthias Andree" on Thu, Sep 06, 2001 at 06:01:30PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 06:01:30PM +0200, Matthias Andree wrote:
> On Thu, 06 Sep 2001, Andrey Savochkin wrote:
> 
> > Of course, SIOCGIFCONF isn't even close to provide the list of local
> > addresses.
> > Obvious example: it doesn't enlist all addresses 127.0.0.1, 127.0.0.2 etc.
> > on common systems.  If you handle 127.0.0.2 as local, you apply side
> > knowledge about properties of loopback interface.
> 
> Well, 127.0.0.2 isn't a local address on my systems. It happens to pong
> if you ping, but that's a matter of its netmask (/255.0.0.0) and the
> "bounce all traffic" feature.

Hell, how else could you define the notion of a local address as not the
address which responds to pings without external network, the address for
which
	telnet 127.0.0.2 25
will give you the greeting of your MTA if you happen to have it listening on
INADDR_ANY and so on?
It _is_ local, and there are no other IP address being "less" local than
127.0.0.2.
All 127.0.0.0/8 addresses are local to the same extent.

> > Less obvious example: routes added to `local' table.
> > SIOCGIFCONF can never show them.
> 
> We're not talking about routes and rules, we're still talking about
> network addresses and the corresponding subnet masks. Don't digress to
> complicate things.

You are missing my point.
Local addresses do not exist at all, there are no such entity in the physical
world.
The only thing that exists is rules.
The rules defining how packets are processed.
According to the rules, some packets are handled locally, i.e. for them a
socket lookup is performed, the host answers by ICMP and so on.
If a class of packets with the same destination IP address is handled locally
independently of other circumstances such as source address, incoming
interface and so on, that destination IP address is the first approximation
to what may be called "local IP address".
But I couldn't help to repeat myself: those IP addresses do not exist as
objects, there are no data structures representing local IP addresses, and so
on, the property of being local is just a conclusion from the rules.
Packet handling rules (represented in FIB rules, FIB info structures and
netfilter data structures) are the only real universe.

> > On Thu, Sep 06, 2001 at 04:17:49PM +0200, Matthias Andree wrote:
> > > I'm not sure where and why you deduce the idea this is about MTA loop
> > > detection or peer recognition.
> > 
> > All other reasons are absolutely artificial.
> 
> Well, Postfix itself uses netmasks to obtain DEFAULT values. You can
> override these, so there is absolutely no point in discussing this.

My point is that you use wrong terms to represent any security policy.

> > The language of that section is amazing:
> >          An SMTP MUST accept and recognize a domain literal for any of
> > 	 its own IP addresses.
> > What might be ``own IP addresses'' of ``an SMTP''?..
> > Does SMTP server have ``own IP addresses'' at all?
> 
> Please stop these harassments. We're talking about broken or
> non-portable SIOCGIFNETMASK behaviour and not ranting about anything
> else, particularly not about Internet Standards.

What Andi was thinking about and I continued is to bring the question whether
you looked for what you wanted and needed.

It looks like you're looking for a non-existing thing.
I still don't understand what you expect to get from SIOCGIFNETMASK if there
are multiple address/mask pairs with different masks.
I don't understand why you want to prevent mail loops and handle mail
destined to user@[127.0.0.1] and don't want even to prevent loops on
[127.0.0.2].

My advice is to re-consider your terms.
If I were involved in the development of postfix or a similar system, I would
immediately drop attempts to auto-configure local addresses and remove
"local networks" as a way to express access policy.

Being realistic, I consider the chances of you following my advice as very
low.  However, I hope that you at least understand my points and realize that
you have serious terminology problems in this area in general, and
the results of your SIOCG* calls do not have real-world sense, at least on
Linux.  SIOCG* calls just show what was previously set by SIOCS* calls, and
it has little to do with the real world, network configuration, packet
handling and so on.

	Andrey

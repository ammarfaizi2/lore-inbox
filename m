Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRIFPa6>; Thu, 6 Sep 2001 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRIFPas>; Thu, 6 Sep 2001 11:30:48 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:49672 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271278AbRIFPah>;
	Thu, 6 Sep 2001 11:30:37 -0400
Message-ID: <20010906193750.B22187@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 19:37:50 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906173534.A21874@castle.nmd.msu.ru> <20010906140444.75DC1BC06C@spike.porcupine.org> <20010906162124.D29583@maggie.dt.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010906162124.D29583@maggie.dt.e-technik.uni-dortmund.de>; from "Matthias Andree" on Thu, Sep 06, 2001 at 04:21:24PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 04:21:24PM +0200, Matthias Andree wrote:
> On Thu, 06 Sep 2001, Wietse Venema wrote:
> 
> > If Linux insists on breaking SIOCGIFCONF then so be it, even though
> > it works perfectly well on any non-Linux system that I could lay
> > my hands on.
> 
> Linux does not break SIOCGIFCONF as far as I can see, but
> SIOCGIFNETMASK. Your inet_addr_local obtains all interfaces's addresses,
> it just gets the wrong netmasks back.

Of course, SIOCGIFCONF isn't even close to provide the list of local
addresses.
Obvious example: it doesn't enlist all addresses 127.0.0.1, 127.0.0.2 etc.
on common systems.  If you handle 127.0.0.2 as local, you apply side
knowledge about properties of loopback interface.
Less obvious example: routes added to `local' table.
SIOCGIFCONF can never show them.

On Thu, Sep 06, 2001 at 04:17:49PM +0200, Matthias Andree wrote:
> I'm not sure where and why you deduce the idea this is about MTA loop
> detection or peer recognition.

Because it's the obvious reason to start to be aware about networking
configuration, and all MTAs known to me try to do it.

All other reasons are absolutely artificial.
You just complicate things without a good reason by linking policies in
different areas.
If I prefer to use wider network mask than it should be and use proxy arp
service of some of my neighbours, why should it affect SMTP?
Or, vice versa, if I use narrower mask and want to use IP gateway for
directly reachable IPs?
You don't look for .htaccess files to get the idea what other IPs have
special meaning for administrators/users of the system, right?

[snip]
> > So, the very right way of doing things is:
> >  - make admin specify the listening addresses for a mail system in the
> >    configuration and use them to check for loops;
> 
> Or just use IPADDR_ANY...

If the mailer's socket is bound to IPADDR_ANY, it's hard to find which
connection attempts will be handled locally, so the best way to handle it is
to ask the admin.
I personally do not use IPADDR_ANY, use of explicit IP addresses makes things
a lot simpler.

> >  - never try to learn anything about networking configuration.
> 
> ...which is wrong, because the MTA must know its own IP addresses to
> accept domain literals, and SIOCGIFCONF works and returns all addresses,
> it just happens that looking up the second and subsequent masks fails.
> Please see RFC-1123, section 5.2.17, for details.

The language of that section is amazing:
         An SMTP MUST accept and recognize a domain literal for any of
	 its own IP addresses.
What might be ``own IP addresses'' of ``an SMTP''?..
Does SMTP server have ``own IP addresses'' at all?
It's difficult to explain what ``own IP addresses'' of a host are, not
speaking about a server...

Are ``own IP addresses'' of ``an SMTP'' the same as ``set of IP addresses,
for which packets coming from interface eth0, for example, and destined to
port 25 on them are handled locally according to the routing policy set for
the system where SMTP server is running''?
Hmm, these 2 notions don't look identical...

Hey, may be its ``own IP addresses'' are just what is specified in the
configuration file as ``own IP addresses''?
That looks like the real answer.

Best regards
		Andrey

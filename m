Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRIFRbH>; Thu, 6 Sep 2001 13:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRIFRa5>; Thu, 6 Sep 2001 13:30:57 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:26633 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271537AbRIFRap>;
	Thu, 6 Sep 2001 13:30:45 -0400
Message-ID: <20010906213757.A23679@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 21:37:57 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906203854.A23109@castle.nmd.msu.ru> <605440607.999799530@[10.132.112.53]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <605440607.999799530@[10.132.112.53]>; from "Alex Bligh - linux-kernel" on Thu, Sep 06, 2001 at 06:05:30PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

On Thu, Sep 06, 2001 at 06:05:30PM +0100, Alex Bligh - linux-kernel wrote:
> 
> --On Thursday, September 06, 2001 8:38 PM +0400 Andrey Savochkin 
> <saw@saw.sw.com.sg> wrote:
> 
> > Hell, how else could you define the notion of a local address as not the
> > address which responds to pings without external network, the address for
> > which
> 
> So the remote end of a looped /30 serial line is now a local address?

If it's looped, i.e. the remote end is plugged in my own port, its address is
local, isn't it?
In any case, such a serial line, or an Ethernet cable

> Can you bind() to 127.0.0.2? In any case, all you've found is a

Of course, anyone can bind, why not?

> peculiarity of the loopback driver. So send a patch.

It's not a peculiarity, it's a regular case.
127.0.0.0/8 is a local network.
If the other entry in the local routing table says `192.168.1.217/32',
it just happens to be /32, not any other prefix length.

And what should I patch?  Postfix?

>             (2)  An application MUST be able to explicitly specify the
>                  source address for initiating a connection or a
>                  request.
> 
> How can (2) be usefully true if the application cannot determine
> what the list of valid local addresses are? Or is your argument
> that all such addresses should be configured manually, rather
> than by the application? Which would not only be a rather
> odd point of view, but makes implementing things like
> BGP, which depends on being able to get the outbound interface
> address used for a session up to the higher layers, rather hard.
[snip]

If the application doesn't know which address to bind to, or it doesn't
matter, it uses INADDR_ANY.
If it matters, user specifies one.
Application may also use the same address as the address of incoming TCP
connection.  That's fine.

For really odd cases, like with routing daemons, application has knowledge
about the routing or may bind to interface (not address), but it's not for
regular use.

	Andrey

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRIFUwh>; Thu, 6 Sep 2001 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272591AbRIFUwc>; Thu, 6 Sep 2001 16:52:32 -0400
Received: from mail.zmailer.org ([194.252.70.162]:43532 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S272592AbRIFUwS>;
	Thu, 6 Sep 2001 16:52:18 -0400
Date: Thu, 6 Sep 2001 23:51:57 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Wietse Venema <wietse@porcupine.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010906235157.D11046@mea-ext.zmailer.org>
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010906173948.502BFBC06C@spike.porcupine.org>; from wietse@porcupine.org on Thu, Sep 06, 2001 at 01:39:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 01:39:48PM -0400, Wietse Venema wrote:
> Andrey Savochkin:
> > > That is not practical. Surely there is an API to find out if an IP
> > > address connects to the machine itself. If every UNIX system on
> > > this planet can do it, then surely Linux can do it.
> > 
> > Let me correct you: you need to recognize not addresses that result in
> > connecting to the _machine_ itself, but connecting to the same _MTA_.
> 
> The SMTP RFC requires that user@[ip.address] is correctly recognized
> as a final destination.  This requires that Linux provides the MTA
> with information about IP addresses that correspond with INADDR_ANY.

	[ This is one of (at least) three different things that
	  have been mentioned in this thread, but lets limit
	  into only this one thing in this email ...  ]


	Why that needs a list of all addresses in the system ?

	Reception can query with standard BSD API what is
	the local address of the socket _at_the_moment_ at
	receiving side.  (  getsockname()  )

	Is there, really, any reason to detect locally anything else ?
	At the receiver all you do is to detect that the IP address
	literal matches the incoming connection, and you strip away
	the literal.


	Of course if the connection is coming in via some NAT box
	somewhere causing your SMTP server to show up with other
	address than what it knows about itself, things get complicated,
	and no matter of what you code into automagic self-address
	detection, you won't get that case solved with it.


> I am susprised that it is not possible to ask such information up
> front (same with netmasks), and that an application has to actually
> query a complex oracle, again and again, for every IP address.

	Of course it can be asked for, and ZMailer does it all
	the time when it considers contacting remote servers.
	If IP address of the remote server appears to be any
	of the local ones (or an invalidone), the message gets
	rejected with "a configuration error detected, this
	must be looping"...

> 	Wietse

/Matti Aarnio

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271498AbRIFRQR>; Thu, 6 Sep 2001 13:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271502AbRIFRQH>; Thu, 6 Sep 2001 13:16:07 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:21769 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271498AbRIFRPu>;
	Thu, 6 Sep 2001 13:15:50 -0400
Message-ID: <20010906212303.A23595@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 21:23:03 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Wietse Venema <wietse@porcupine.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906204423.B23109@castle.nmd.msu.ru> <20010906165051.7EA29BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010906165051.7EA29BC06C@spike.porcupine.org>; from "Wietse Venema" on Thu, Sep 06, 2001 at 12:50:51PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 12:50:51PM -0400, Wietse Venema wrote:
> Andrey Savochkin:
> > > I welcome suggestions, maybe even code fragments, that will allow
> > > an MTA to correctly recognize user@[ip.address] as local, as required
> > > by the SMTP RFC.
> > 
> > The question was which ip.address in user@[ip.address] should be treated as
> > local.
> > My comment was that the only reasonable solution on Linux is to treat this
> > way addresses explicitly specified in the configuration file.
> > Postfix may show its guess at the installation time.
> 
> That is not practical. Surely there is an API to find out if an IP
> address connects to the machine itself. If every UNIX system on
> this planet can do it, then surely Linux can do it.

Let me correct you: you need to recognize not addresses that result in
connecting to the _machine_ itself, but connecting to the same _MTA_.

Let's put it this way:
trying to find those "local" IP addresses automatically,
1. you have high rate of false negatives:
   checking networking configuration by SIOCGIFCONF, you misses almost entire
   127.0.0.0/8 network, and all routes in `local' table;
2. you have potentially high rate of false positives:
   you won't work in any reasonable way if someone puts more than one MTA on
   a single system, even if he sets dedicated IP addresses for them;
   proper recognition of local mail addresses is absolutely necessary for
   mail traffic inside one system but across several MTAs.

You cannot always guess right automatically.
You can walk routing tables (looking for local routes, routes without a
gateway or whatever else) and get much better approximation.
But you can never have it right in 100% cases.

My suggestion is just not to try to be too smart.
You can't know the right configuration for everybody.
Make a right guess in 90% cases.
Always ask administrator what _he_ really wants.

	Andrey

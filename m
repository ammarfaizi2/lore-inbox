Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317940AbSFNPw3>; Fri, 14 Jun 2002 11:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317941AbSFNPw2>; Fri, 14 Jun 2002 11:52:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19726 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317940AbSFNPw0>;
	Fri, 14 Jun 2002 11:52:26 -0400
Subject: Re: RFC: per-socket statistics on received/dropped packets
From: Stephen Hemminger <shemminger@osdl.org>
To: Lincoln Dale <ltd@cisco.com>
Cc: jamal <hadi@cyberus.ca>, Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>,
        Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <5.1.0.14.2.20020614100914.01adca48@mira-sjcm-3.cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Jun 2002 08:51:15 -0700
Message-Id: <1024069878.20676.1.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds like what you want is socket accounting which works like
process accounting.  I.e when a socket lifetime ends, put out a record
with number of packets/bytes sent/received.

On Thu, 2002-06-13 at 17:24, Lincoln Dale wrote:
> At 09:00 AM 12/06/2002 -0400, jamal wrote:
> > > > > i know of many many folk who use transaction logs from HTTP caches for
> > > > > volume-based billing.
> > > > > right now, those bills are anywhere between 10% to 25% incorrect.
> > > > >
> > > > > you call that "extremely limited"?
> > > >
> > > >Surely, you must have better ways to do accounting than this -- otherwise
> > > >you deserve to loose money.
> > >
> > > many people don't have better ways to do accounting than this.
> >
> >Then they dont care about loosing money.
> >There's nothing _more important_ to a service provider than ability to do
> >proper billing. Otherwise, they are a charity organization.
> 
> on this side of the planet (Australia), just about *all* service-providers 
> offer differentiated-billing baed on a volume-usage basis.
> that includes Worldcom, Telstra, Optus (SingTel), connect.com.au (AAPT).
> some of these differentiate themselves by using caching to provide faster 
> access and/or mitigate the latency overhead of simplex satellite.
> this has been ongoing for many many many years now.  please just accept 
> that HTTP caching is almost a necessity with the pricing models in use!
> 
> >There's nothing _more important_ to a service provider than ability to do
> >proper billing. Otherwise, they are a charity organization.
> 
> we're almost talking about the same thing here -- and this is my point!  i 
> agree that is is important - hence why i've added a getsockopt() option to 
> provide octet counters from the ip+tcp level!
> 
> > > in the case of Squid and Linux, they're typically using it because its
> > > open-source and "free".
> >
> >I am hoping you didnt mean to say squid was only good because it has
> >these perks.
> 
> not at all.  they're using it because it meets their requirements.
> once again, this is not a discussion about religion or politics!
> 
> > > they want to use HTTP Caching to save bandwidth (and therefore save money),
> > > but they also live in a regime of volume-based billing.  (not everywhere on
> > > the planet is fixed-$/month for DSL).
> > >
> > > the unfortunate solution is to use HTTP Transaction logs, which count
> > > payload at layer-7, not payload+headers+retransmissions at layer-3.
> >
> >Look at your own employers eqpt if you want to do this right.
> >And then search around freshmeat so you dont reinvent the wheel.
> 
> once again, i respectfully disagree.  while there are numerous technologies 
> for accounting out there (e.g. netflow), they all break down when you have 
> things like HTTP Persistent connections which may share a single 
> [server-side] connection with multiple [client-side] connections.
> 
> >And until you prove it is worth it and useful to other people then
> >forever thats where it belongs. I now of nobody serious about billing
> >who is using sockets stats as the transaction point.
> 
> you live in a country where the billing regeme is different.
> 
> > > lawn-mower support sounds like a userspace application to me.
> >
> >But we need a new system call support
> 
> (yes, i did take that comment as humerous before :-)).
> 
> if what i was proposing involved a new system-call then i agree that there 
> would be signficant pushback.  what i have is a new getsockopt() 
> option.  ie. in reality, no worse than getsockopt(..,TCP_INFO).
> 
> 
> cheers,
> 
> lincoln.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278395AbRJSNSW>; Fri, 19 Oct 2001 09:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278396AbRJSNSN>; Fri, 19 Oct 2001 09:18:13 -0400
Received: from dsl-64-129-199-125.telocity.com ([64.129.199.125]:20494 "HELO
	descola.net") by vger.kernel.org with SMTP id <S278395AbRJSNR6>;
	Fri, 19 Oct 2001 09:17:58 -0400
Date: Fri, 19 Oct 2001 06:18:30 -0700
From: Darrell A Escola <darrell-sg@descola.net>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
Message-ID: <20011019061830.A8087@descola.net>
Mail-Followup-To: Darrell A Escola <darrell-sg@descola.net>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <1002646705.2177.9.camel@aurora> <Pine.LNX.4.33.0110091005540.209-100000@desktop> <20011010135503.4f5c06b9.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010135503.4f5c06b9.rusty@rustcorp.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been running 2.4.10-ac11 for 7 days now with
TCP_CONNTRACK_CLOSE_WAIT set to 120 seconds - this has stopped nearly
all firewall activity on established connections.

I use "mc" extensively for ftp, and previously would get numerous blocks
after closing a session or starting another ftp session with the same
instance of "mc".

What would we need to do to make these values tuneable either via
insmod/modprobe or /proc?

Darrell

On Wed, Oct 10, 2001 at 01:55:03PM +1000, Rusty Russell wrote:

> On Tue, 9 Oct 2001 10:07:05 -0700 (PDT)
> "Jeffrey W. Baker" <jwbaker@acm.org> wrote:

> > On 9 Oct 2001, Trever L. Adams wrote:

> > > I am seeing messages such as:
> > > Oct  9 12:52:51 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
> > > SRC=64.152.2.36 DST=MY_IP_ADDRESS LEN=52 TOS=0x00 PREC=0x00 TTL=246
> > > ID=1093 DF PROTO=TCP SPT=80 DPT=33157 WINDOW=34752 RES=0x00 ACK FIN
> > > URGP=0
> > >
> > > In my firewall logs.  I see them for ACK RST as well.  These are valid
> > > connections.  My rules follow for the most part (a few allowed
> > > connections to the machine in question have been removed from the
> > > list).  This often leaves open connections in a half closed state on
> > > machines behind this firewall.  It also some times kills totally open
> > > connections and I see packets rejected that should be allowed through.
> > 
> > I see this too.  iptables is refusing packets on locally-initiated TCP
> > connections when the RELATED,ESTABLISHED rule should be letting them
> > through.
> 
> Yes, but it has forgotten them.  Play with the TCP timeout numbers in
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c.  Especially the 60 seconds for
> TCP_CONNTRACK_CLOSE_WAIT for the ACK FIN case.  These numbers were stolen
> from the 2.0 and 2.2 masq code, which had real world testing (but didn't
> report failures, so...)
> 
> Given some actual feedback on appropriate numbers, this can be fed as a
> patch to Linus...
> 
> Hope that helps,
> Rusty.

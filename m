Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274611AbRJJD72>; Tue, 9 Oct 2001 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274627AbRJJD7S>; Tue, 9 Oct 2001 23:59:18 -0400
Received: from [202.135.142.195] ([202.135.142.195]:31240 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S274611AbRJJD7N>; Tue, 9 Oct 2001 23:59:13 -0400
Date: Wed, 10 Oct 2001 13:55:03 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: trever_adams@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
Message-Id: <20011010135503.4f5c06b9.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0110091005540.209-100000@desktop>
In-Reply-To: <1002646705.2177.9.camel@aurora>
	<Pine.LNX.4.33.0110091005540.209-100000@desktop>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 10:07:05 -0700 (PDT)
"Jeffrey W. Baker" <jwbaker@acm.org> wrote:

> On 9 Oct 2001, Trever L. Adams wrote:
> 
> > I am seeing messages such as:
> >
> > Oct  9 12:52:51 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
> > SRC=64.152.2.36 DST=MY_IP_ADDRESS LEN=52 TOS=0x00 PREC=0x00 TTL=246
> > ID=1093 DF PROTO=TCP SPT=80 DPT=33157 WINDOW=34752 RES=0x00 ACK FIN
> > URGP=0
> >
> > In my firewall logs.  I see them for ACK RST as well.  These are valid
> > connections.  My rules follow for the most part (a few allowed
> > connections to the machine in question have been removed from the
> > list).  This often leaves open connections in a half closed state on
> > machines behind this firewall.  It also some times kills totally open
> > connections and I see packets rejected that should be allowed through.
> 
> I see this too.  iptables is refusing packets on locally-initiated TCP
> connections when the RELATED,ESTABLISHED rule should be letting them
> through.

Yes, but it has forgotten them.  Play with the TCP timeout numbers in
net/ipv4/netfilter/ip_conntrack_proto_tcp.c.  Especially the 60 seconds for
TCP_CONNTRACK_CLOSE_WAIT for the ACK FIN case.  These numbers were stolen
from the 2.0 and 2.2 masq code, which had real world testing (but didn't
report failures, so...)

Given some actual feedback on appropriate numbers, this can be fed as a
patch to Linus...

Hope that helps,
Rusty.


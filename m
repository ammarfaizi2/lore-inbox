Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSJJAQC>; Wed, 9 Oct 2002 20:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJJAQB>; Wed, 9 Oct 2002 20:16:01 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:5262 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S262692AbSJJAPx>; Wed, 9 Oct 2002 20:15:53 -0400
Date: Thu, 10 Oct 2002 01:21:09 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: Yuji Sekiya <sekiya@sfc.wide.ad.jp>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021010012108.E8102@edi-view1.cisco.com>
References: <20021010002902.A3803@edi-view1.cisco.com> <20021009.162438.82081593.davem@redhat.com> <uu1jv9o3j.wl@sfc.wide.ad.jp> <20021009.164504.28085695.davem@redhat.com> <ur8ez9n8d.wl@sfc.wide.ad.jp> <20021010010439.C8102@edi-view1.cisco.com> <uptuj9mkq.wl@sfc.wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <uptuj9mkq.wl@sfc.wide.ad.jp>; from sekiya@sfc.wide.ad.jp on Thu, Oct 10, 2002 at 09:14:45AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 09:14:45AM +0900, Yuji Sekiya wrote:
> At Thu, 10 Oct 2002 01:04:39 +0100,
> Derek Fawcus <dfawcus@cisco.com> wrote:
> 
> > Turn on 'debug ipv6 nd',  'debug ipv6 icmp',  'debug ipv6 pack d'
> > 
> > Then do 'ping ipv6' specify a link local of say fe80:1910::10 and
> > an egress interface,  and watch what happens.
> 
> OK.
> 
> Oct 10 09:09:15: ICMPv6-ND: DELETE -> INCMP: FE80:1910::10
> Oct 10 09:09:15: ICMPv6-ND: Sending NS for FE80:1910::10 on FastEthernet4/1
> Oct 10 09:09:15: IPV6: source FE80::201:64FF:FEA3:ED55 (local)
> Oct 10 09:09:15:       dest FF02::1:FF00:10 (FastEthernet4/1)
> Oct 10 09:09:15:       traffic class 224, flow 0x0, len 72+8, prot 58, hops 255, originating
> Oct 10 09:09:15: IPv6: Sending on FastEthernet4/1
> Oct 10 09:09:15: IPv6: Encapsulation failed
> 
> Encapsulation failed ... ??? :-)

Well there was no one to respond to the NS,  so it couldn't figure out
what dest MAC address to shove in the ethernet packet.  Hence the
ethernet encap failed.

Say if you sent such a packet over the link to the router,  and it
tried to forward it without the neighbour being there,  you should
get an ICMP error generated.

But anyway it was trying to resolve a neighbour entry,  if someone
responded,  it'd have sent the packet.

Now try it with a box on the link which will respond to the NS for that
address.

DF

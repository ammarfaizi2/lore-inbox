Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSJIRFw>; Wed, 9 Oct 2002 13:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSJIRFw>; Wed, 9 Oct 2002 13:05:52 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:6298 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S261848AbSJIRFt>; Wed, 9 Oct 2002 13:05:49 -0400
Date: Wed, 9 Oct 2002 18:11:11 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021009181111.A23231@edi-view1.cisco.com>
References: <20021008.000559.17528416.yoshfuji@linux-ipv6.org> <20021009170018.H29133@edinburgh.cisco.com> <20021010.015432.63506989.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021010.015432.63506989.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Thu, Oct 10, 2002 at 01:54:32AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 01:54:32AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <20021009170018.H29133@edinburgh.cisco.com> (at Wed, 9 Oct 2002 17:00:18 +0100), Derek Fawcus <dfawcus@cisco.com> says:
> 
> > All link local's are currently supposed to have those top bits
> > ('tween 10 and 64) zero'd,  however any address within the link local
> > prefix _is_ on link / connected and should go to the interface.
> > 
> > i.e. it's perfectly valid for me to assign a link local of fe80:1910::10
> >      to an interface and expect it to be work,  likewise for a packet
> >      destined to any link local address to trigger ND.
> 
> First of all, please don't use such addresses.

Why not,  they are perfectly legal?

> By spec, auto-configured link-local address is fe80::/64
> and connected route should be /64.

Yes auto-configured have fe80:0:0:0: in their upper 64 bits,  but that
is just for autoconfigured addessses.  That is a seperate issue to which
prefix desinates link local.

Connected routes don't have to be /64,  things work correctly even if
one picks any other value.  

> If you do really want to use such addresses (like fe80:1920::10),
> you can put another route by yourself, at your own risk.

No - what I'm saying is that all link locals should go to the link.

There is no risk inherent in using such an address or link local prefix.

If a mechanism is required such that autoconfig generates the correct
type of address,  then add it.  But that doesn't _require_ that
the connected route be /64.

I happen to use link locals like the quite often,  since it makes
testing and reading packet traces a hell of a lot easier.

> We should not configure in such way by default.
> and, we should even have to add "discard" route for them 
> by default for safe.

Why.  In what way is it not 'safe' to have any link local address
sent onto the link?  They'll either reach a destination or not,
but given that they'll never leave the link,  they can't be inherently
unsafe.

DF

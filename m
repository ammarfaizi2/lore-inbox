Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbSJIPyz>; Wed, 9 Oct 2002 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSJIPyz>; Wed, 9 Oct 2002 11:54:55 -0400
Received: from edinburgh.cisco.com ([144.254.112.76]:39299 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S261824AbSJIPyx>;
	Wed, 9 Oct 2002 11:54:53 -0400
Date: Wed, 9 Oct 2002 17:00:18 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021009170018.H29133@edinburgh.cisco.com>
References: <20021008.000559.17528416.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021008.000559.17528416.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Tue, Oct 08, 2002 at 12:05:59AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 12:05:59AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> Hi,
> 
> Prefix length for link-local address should be 64, not 10.
> This patch fixes prefix length of link-local address.
> 
> Following patch is against 2.4.19.

Huh?

Without reading the kernel routing table code a bit more,  I'm not certain
what that change does,  but it looks as if it might be changing the
connected route for a link local from fe80::/10 to fe80::/64.

I'd actually say that is wrong.

All link local's are currently supposed to have those top bits
('tween 10 and 64) zero'd,  however any address within the link local
prefix _is_ on link / connected and should go to the interface.

i.e. it's perfectly valid for me to assign a link local of fe80:1910::10
     to an interface and expect it to be work,  likewise for a packet
     destined to any link local address to trigger ND.

DF

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbSJJBGn>; Wed, 9 Oct 2002 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSJJBGn>; Wed, 9 Oct 2002 21:06:43 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:58017 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S262879AbSJJBGm>; Wed, 9 Oct 2002 21:06:42 -0400
Date: Thu, 10 Oct 2002 02:11:54 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: Yuji Sekiya <sekiya@sfc.wide.ad.jp>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021010021154.G8102@edi-view1.cisco.com>
References: <20021009.162438.82081593.davem@redhat.com> <uu1jv9o3j.wl@sfc.wide.ad.jp> <20021009.164504.28085695.davem@redhat.com> <ur8ez9n8d.wl@sfc.wide.ad.jp> <20021010010439.C8102@edi-view1.cisco.com> <uptuj9mkq.wl@sfc.wide.ad.jp> <20021010012108.E8102@edi-view1.cisco.com> <uofa39lm9.wl@sfc.wide.ad.jp> <20021010014237.F8102@edi-view1.cisco.com> <un0pn9knb.wl@sfc.wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <un0pn9knb.wl@sfc.wide.ad.jp>; from sekiya@sfc.wide.ad.jp on Thu, Oct 10, 2002 at 09:56:24AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 09:56:24AM +0900, Yuji Sekiya wrote:
> 
> I can underdtand there is no interoperability issue with cisco box
> (with /10 link-local prefix ?) and USAGI kernel(with /64 link-local
> prefix). :-)

Mind it's interesting that the above currently works.  I suspect that
this is because the ping was originated on the cisco box,  and hence
ND was triggered,  with the linux box probably gleaning info from the
NS to create a STALE entry.  That STALE entry would then probably have
been probed to get a REACHABLE entry.

What happens if you clear the ND entries (on both boxes),  swap the
link local addresses,  then ping from the Linux box to the cisco box?

I suspect that the ping will fail.  As ND will never be triggered,  and
hence the host routes will not be created.

Another alternative would be if one was say fe80:1910::10 and the other
say fe80:2010::20,  that would probably fail with the ping originated
from the linux end,  but I'm not sure if the linux box would respond
when the ping was originated from the cisco end.  Assuming my guess
about the gleaning above is correct,  it probably will.

DF

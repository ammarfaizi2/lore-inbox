Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318967AbSH1U6m>; Wed, 28 Aug 2002 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSH1U6m>; Wed, 28 Aug 2002 16:58:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29173 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318961AbSH1U6k>; Wed, 28 Aug 2002 16:58:40 -0400
Importance: Normal
Sensitivity: 
Subject: Re: IPv6 PMTU/MTU related patch for 2.5.31 kernel
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF8DA779DB.E7BE1739-ON88256C23.0072CBDB@boulder.ibm.com>
From: "Shirley Ma" <xma@us.ibm.com>
Date: Wed, 28 Aug 2002 14:01:03 -0700
X-MIMETrack: Serialize by Router on D03NM037/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/28/2002 03:02:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

I think it needs to be RFC conformance for PMTU to avoid unnecessary
probing PMTU network traffics. For UDP and ICMP which doesn't have any
reference on this kind of route, the route needs to be around for a while
instead of being delete within a very short time even immediately.

Thanks
Shirley Ma



Andi Kleen <ak@muc.de>@averell.firstfloor.org on 08/28/2002 02:44:34 AM

Sent by:    andi@averell.firstfloor.org


To:    Shirley Ma/Beaverton/IBM@IBMUS
cc:    linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, LTC IPv6
Subject:    Re: IPv6 PMTU/MTU related patch for 2.5.31 kernel



"Shirley Ma" <xma@us.ibm.com> writes:

> +           /* If there is no reference to this route, this route will be
> +              deleted by fib6_run_gc() within 30 secs. The cached
decreased
> +              PMTU will be gone. It's possible to be deleted before any
> +              other protocol using it. Then the old larger pmtu will be
used,
> +              which against RFC1981: detect an increase MUST NOT be done
> +              less than 5 minutes after a Packet Too Big Messages has
> +              been received for the given path.
> +            */
> +           dst_hold(&nrt->u.dst);

This seems overkill and could potentially tie up quite a of dst
entries for dubious purposes. This RFC requirement clearly cannot be
followed in all cases, e.g. when you run out of memory for the
destination cache. This is one such case too.

I think only following it when there is still another reference to the
dst entry (e.g. from a socket) is reasonably near the spirit of the
specification.

-Andi





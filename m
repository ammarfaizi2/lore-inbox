Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTHTWNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTHTWNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:13:12 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:54231 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S262267AbTHTWNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:13:05 -0400
Date: Thu, 21 Aug 2003 10:12:40 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Connection tracking for IPSec
Message-ID: <1710000.1061417560@ijir>
In-Reply-To: <1061388988.3804.8.camel@teapot.felipe-alfaro.com>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>	
 <23600000.1061383792@ijir>
 <1061388988.3804.8.camel@teapot.felipe-alfaro.com>
X-Mailer: Mulberry/3.1.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, August 20, 2003 04:16:28 PM +0200 Felipe Alfaro Solana 
<felipe_alfaro@linuxmail.org> wrote:


> Well, I'm using IPSec on two machines and both of them are end hosts.
> They are *not* working as routers. My netfilter rules are:

Ah.  OK.  You want to do that *inside* the tunnels.

> Chain INPUT (policy DROP)
> target     prot opt source      destination
> ACCEPT     all  --  anywhere    anywhere   state RELATED,ESTABLISHED
> ACCEPT     all  --  localhost.localdomain  anywhere
>
> Chain FORWARD (policy DROP)
> target     prot opt source               destination
>
> Chain OUTPUT (policy ACCEPT)
> target     prot opt source               destination
>
> The problem is that if I enable IPSec on both machines by using manual,
> preshared keys, no traffic will pass through both firewalls, as I need
> to open up protocols 50 and 51 (AH and ESP).

Which makes sense so far.

> The problem here is that opening up protocols 50 and 51, makes *any*
> IPSec-protected traffic to pass the firewall, but I still want that any
> traffic (IPSec-protected or not) be applied the connection-track
> filters. For normal (no IPSec) traffic, an incoming packet is only
> accepted if it belongs to a connection that was initiated locally. For
> IPSec traffic, I just want the same. I don't want any kind of
> IPSec-protected traffic to be able to pass through the firewall, only
> traffic that belongs to a connection that was initiated locally on the
> machine receiving it.

It doesn't make sense for this configuration to fail in this way, I agree.

Essentially, the ESP and AH transforms should be a magic netfilter rule, so 
you can insert them in a netfilter chain and do this sort of thing.  If 
they aren't, we should at least have the input and output chains traversed 
by packets both before and after the transforms.

The issue exists, I'm convinced.  Dang, I'm going to run into it too one 
day soon.  Another thing that needs looking at, in case noone else fixes it 
first.

> End note: an incoming packet should be accepted by the firewall if and
> only if there is a corresponding connection (let it be TCP, UDP or ICMP)
> that was first initiated locally on that machine. For example, for any
> incoming TCP packet to traverse the firewall, first there must have been
> a packet with the SYN flag that travelled in the opposite direction. I
> want this to work for normal traffic (it does work now) and for
> IPSec-protected traffic.
>
> Did I explain it clearly?

Yes, you did.

> Thanks again!

You're welcome,

Andrew





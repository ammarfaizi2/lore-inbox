Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269540AbUICQ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269540AbUICQ63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUICQ6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:58:14 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:60546 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269466AbUICQxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:53:35 -0400
Date: Fri, 3 Sep 2004 17:53:23 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: lkml@einar-lueck.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
In-Reply-To: <200409031007.29467.elueck@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0409031747580.23011@fogarty.jakma.org>
References: <200409011441.10154.elueck@de.ibm.com> <200409021858.38338.elueck@de.ibm.com>
 <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org> <200409031007.29467.elueck@de.ibm.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Einar Lueck wrote:

> I just set up the loopback interface via ZEBRA/OSPF as You 
> described it and checked via tcpdump the source IP address of the 
> related NFS packets. The kernel chooses the IP address of the NIC 
> he routes the packets over as the source IP address and not the 
> Source VIPA configured for loopback.

Ah, I didnt say adding an address to loopback would make everything 
use it. Merely that loopback already exists as an interface to which 
from which you can 'hang' your VIPA - no need for a new interface.

You could try:

 	ip route change default via <gateway> src <vipa>

Presuming the NFS clients are behind a gateway. If also onlink, you 
need to modify the connected routes and change the src there too.

> You are right, it would be one option to have a "bind to address" 
> in KNFSD.

It might even already exist.. who knows. ;)

> But our idea was to implement a feature well known from other 
> operating systems like AIX to Linux because this feature is quite 
> popular and liked especially by large customers.

Right, but Linux can already do it. The configuration might not be 
the same as AIX, but that's not a good reason.. if it were, you 
should also be porting smit to Linux to satisfy your customers ;)

Linux can already do what you want I think. Just a matter of 
configuring it.

> We would win a facility allowing for a Source VIPA for all kinds of 
> servers not offering an explicit bind option. So: Due to the 
> feature port idea mentioned above.

Have you tried playing with ip route?

 	ip route <destination> ...... src <source address>

> If we focus for a moment just on the NIC-fail-over issue (not 
> caring about layers, virtual IPs, etc.) then bonding offers the 
> desired failover with some restriction. This is the reason why I 
> mentioned it in this context.

Ah.

> Again, thanks for Your suggestions and maybe we should continue our
> discussion privately.

Sure.

> Regards
>
> Einar.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
kernel panic: write-only-memory (/dev/wom0) capacity exceeded.

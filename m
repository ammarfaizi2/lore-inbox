Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267580AbRHAQys>; Wed, 1 Aug 2001 12:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbRHAQy3>; Wed, 1 Aug 2001 12:54:29 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:7178 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267516AbRHAQxw>;
	Wed, 1 Aug 2001 12:53:52 -0400
Message-Id: <200107312322.DAA00541@mops.inr.ac.ru>
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: samudrala@us.ibm.COM (Sridhar Samudrala)
Date: Wed, 1 Aug 2001 03:22:45 -2000 (MSD)
Cc: thiemo@sics.se, dmfreim@us.ibm.COM, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.21.0107300035490.22748-100000@w-sridhar2.des.sequent.com> from "Sridhar Samudrala" at Jul 30, 1 00:40:43 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I am not sure how much overhead is involved in maintaining the the no. of
> slots left for each priority class. Also what should be the ratio of slots 
> that need to reserved for each class? 

It is an experimental value like total size of accept queue,
which is also unknown apriori. No differences.


> Do you think that the existing PAQ patch with SYN policing is a reasonable
> way for prioritizing incoming connection requests?

I still did not look at this patch, I have just got some url from netdev.
(that blamed by Jamal. :-) Guys, tell your managers they should reserve
a bit of money for admins to replace bogus firewalls. ibm site is really
not accessible, it is not a joke. :-)). I will look at it tonight.


> Preempting existing low priority connections in acceptq with high priority 
> ones may not be good idea as we need to abort them by sending a RST.

Of course. It is _very_ bad idea. :-)

Actually, true preemption can be relaized here with moving socket
back to SYN-RECV state, converting it to open_request. We just pretend
that we did not receive ACK, it is fully legal. 

But in this case we also have room for effective preemption,
stopping process SYN_RECV->ESTABLISHED for low priorities.
I.e. exactly, which SYN policing makes.

Alexey

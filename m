Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbRHBRUb>; Thu, 2 Aug 2001 13:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbRHBRUV>; Thu, 2 Aug 2001 13:20:21 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:2275 "EHLO e24.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266941AbRHBRUH>;
	Thu, 2 Aug 2001 13:20:07 -0400
Date: Thu, 2 Aug 2001 10:17:11 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: thiemo@sics.se, dmfreim@us.ibm.com, hadi@cybeus.ca,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        diffserv-general@lists.sourceforge.net, rusty@rustcorp.com.au
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
In-Reply-To: <200107312322.DAA00541@mops.inr.ac.ru>
Message-ID: <Pine.LNX.4.21.0108020956320.25553-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Alexey Kuznetsov wrote:

> > Do you think that the existing PAQ patch with SYN policing is a reasonable
> > way for prioritizing incoming connection requests?
> 
> I still did not look at this patch, I have just got some url from netdev.
> (that blamed by Jamal. :-) Guys, tell your managers they should reserve
> a bit of money for admins to replace bogus firewalls. ibm site is really
> not accessible, it is not a joke. :-)). I will look at it tonight.

We have escalated the ECN issue and we are expecting this to be fixed by 
sometime next week. IBM is a big distributed company and sometimes it takes a
long time to get things done, even simple things like this.
I am looking forward to your feedback on the patch. 
The URL is http://oss.software.ibm.com/qos

> > Preempting existing low priority connections in acceptq with high priority 
> > ones may not be good idea as we need to abort them by sending a RST.
> 
> Of course. It is _very_ bad idea. :-)
> 
> Actually, true preemption can be relaized here with moving socket
> back to SYN-RECV state, converting it to open_request. We just pretend
> that we did not receive ACK, it is fully legal. 

This looks like an elegant way of prioritizing without penalizing low priority
connections in the absence of high priority ones.
There may be an issue with sockets in accept queue which have received data.
Is it OK to move a socket which has already received some data back to SYN-RECV 
state and expect the data to be resent?

Thanks
-Sridhar


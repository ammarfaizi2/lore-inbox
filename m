Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315330AbSDWUIy>; Tue, 23 Apr 2002 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315332AbSDWUIx>; Tue, 23 Apr 2002 16:08:53 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:2201 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315330AbSDWUIw>; Tue, 23 Apr 2002 16:08:52 -0400
Message-ID: <3CC5B3CC.22366C2B@nortelnetworks.com>
Date: Tue, 23 Apr 2002 15:19:40 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Guffens <guffens@auto.ucl.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be> <3CC55D62.1501C94A@nortelnetworks.com> <20020423172051.A22111@auto.ucl.ac.be> <3CC58DF3.A6AB95B1@nortelnetworks.com> <20020423225432.A9021@auto.ucl.ac.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guffens wrote:

> ok, I see, so both interfaces are replying to the arp request but this time, the first interface to reply, eth0, will have its
> arp reply filtered by the arp_filter as ip_route_output will indicate eth1 as the outgoing interface for a packet that has its
> source set to the ip to resolve, which has a source route policy entry to point to eth1, is it ?

Correct.  Both NICs receive the arp request, only one of them actually sends a
reply.

> But then, by curiosity, is there some reasons why two different interfaces shouldn't be in the same subnet ? I was in this
> impression having configured some cisco routers which don't even accept this configuration. Is it possible on other network
> devices ? Is there any theoretical justification ?

I don't think there are any theoretical objections.  I'm pretty sure windows
will let you do it, but they don't give you nearly as much control over the
routing.

Without source routing or arp filter, traffic to any of the interfaces on the
same subnet can go through any of the interfaces on that subnet--whichever arp
reply gets there last is the winner.  This can be useful for quasi-redundant
type communications, but causes big problems if you're trying to monitor the
state of your network communications paths.  This is where the more strict
behaviour becomes useful.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbUAZALo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAZALn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:11:43 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:50098 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S265433AbUAZALE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:11:04 -0500
Date: Mon, 26 Jan 2004 03:11:02 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] IMQ port to 2.6
Message-ID: <20040126001102.GA12303@usr.lcm.msu.ru>
References: <20040125152419.GA3208@penguin.localdomain> <20040125164431.GA31548@louise.pinerecords.com> <1075058539.1747.92.camel@jzny.localdomain> <20040125202148.GA10599@usr.lcm.msu.ru> <1075074316.1747.115.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1075074316.1747.115.camel@jzny.localdomain>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.24
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 06:45:16PM -0500, jamal wrote:
> On Sun, 2004-01-25 at 15:21, Vladimir B. Savkin wrote:
> > On Sun, Jan 25, 2004 at 02:22:19PM -0500, jamal wrote:
> 
> > Think multiple clients connected via PPP. I want to shape traffic,
> > so ingress is out of question. I want different clients in a same
> 
> Ok, 
> a) why do you want to shape on ingress instead of policing?

With typical internet traffic patterns, policing will drop many packets,
and shaping will not.

> OR
> b) Why cant you achieve the same results by marking on ingress and
> shaping on egress? 

Well, as I understand it, there's no "real" ingress and "real" egress.
Look at this:
Any forwarded packet
  1) comes from one interface
  2) receives some treatment (filtering, routing decision, maybe
    delaying if we shape, mangling etc.)
  and
  3) goes away via some other interface

step (1) is "ingress"
step (3) is "egress"
qdiscs work at step (2), so all of them are intermediate in this sense

Well, ok, if a qdisc receives a feedback from egress interface
on when to dequeue a packet (when interface is ready to send),
we can say that it is an egress qdisc.

But in my case, PPP connections are really PPTP or PPPoE.
Internal network bandwidth is not a premium, so all internal
interfaces are always ready to send.

So, I don't shape at ingress or at egress, I shape passing-through
traffic.

> > htb class, so using qdisc on each ppp interface is out of
> > question. It seems to me that IMQ is the only way to achieve my goals.
> 
> By multiple clients i believe you mean you want to say "-i ppp+"?
> We had a long discussion on this a while back (search netdev) 
> and i think it is a valid point for dynamic devices like ppp. 

Well, I don't really care whether those interfaces are dynamic or
static. They could be multiple vlans, and nothing would
change in marking or shaping. I use clients' IPs for marking,
and routing table cares about interfaces.

> We need to rethink how we do things. Theres a lot of valu in having per
> device tables (scalability being one).
> IMO, this alone does not justify the existence of IMQ. 

I just can't think of a better abstraction that would handle my case.

> We should do this (and other things) right, maybe a sync with the
> netfilter folks will be the right thing to do. 
> 

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 


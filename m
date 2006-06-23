Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751997AbWFWTsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWFWTsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWFWTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:48:53 -0400
Received: from web33308.mail.mud.yahoo.com ([68.142.206.123]:38547 "HELO
	web33308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751997AbWFWTsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:48:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aporFy668F9n3sUmPXdRsKCWlFN35tlNOt72Jhi2A0Xwh6OyxHy90+TsFNzYGn3jfzEhZTUnH+lqhpGC7ZMUkXAEJo9c9nCZwjEOyHjXKo71x/6BUtY5iV+fnDYknpKJNMN+X2QKnm91KD7s8vuIsBZlJ46IF86TTII7dHEEqWs=  ;
Message-ID: <20060623194839.88713.qmail@web33308.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 12:48:39 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Dropping Packets in 2.6.17
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449B4038.3040101@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Robert Hancock <hancockr@shaw.ca> wrote:

> Danial Thom wrote:
> >>
> >> I didn't use ITR, I used NAPI.
> >>
> > 
> > If thats the case then your "system" would
> have
> > the same problem that I'm encountering, since
> > polling results in buckets of packets being
> > dropped with heavy userland activity.
> 
> This is to some extent by design. If you
> processed all packets purely in 
> interrupt context, at some point you can start
> receiving so many packets 
> that you never leave interrupt context to
> perform any other useful work, 
> no matter if your adapter can avoid generating
> an interrupt for every 
> packet. Packet floods can completely hang the
> machine. Pushing the work 
> into a softirq and disabling NIC interrupts in
> the interim allows the 
> machine to continue performing other useful
> work.

You guys keep talking about generating an int for
every packet, and like no controller designed
after 1998 does it, so why are you still talking
about it?

Yes, this is the "design" thats flawed. Apps like
MySQL and compilers always try to use all of the
cpu, and if it results in the system *thinking*
that its being flooded then its not working
properly. A network stream that is using less
that 20% of the cpu should *never* drop any
packets. 

> If you want to give more priority to processing
> network packets at the 
> expense of user processes then you likely need
> to increase the priority 
> of the ksoftirqd thread(s). These compete for
> CPU time like any other 
> processes.

I've tried this and it doesn't do much in terms
of alleviate the problem. It makes a marginal
difference.

I think much of the problem is that the network
guys are spending so much time on frivilous
things like polling that they have no interest in
getting the hardware to work the way its supposed
to. Ironically, if the harware worked properly
there would be no reason to have polling.

Detecting a livelock condition is easy. There's
no reason to drop packets randomly. Additionally
a workload tunable would deflect the argument
against allowing near-livelock conditions.
Dropping packets should be a last resort; not the
norm.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

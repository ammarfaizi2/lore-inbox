Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUDCWyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUDCWyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:54:16 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:29378 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S262014AbUDCWyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:54:14 -0500
Subject: Re: [RFC, PATCH] netlink based mq_notify(SIGEV_THREAD)
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Manfred Spraul <manfred@colorfullife.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Michal Wronski <wrona@mat.uni.torun.pl>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
In-Reply-To: <406F21FB.4010502@colorfullife.com>
References: <406F13A1.4030201@colorfullife.com>
	 <1081023487.2037.19.camel@jzny.localdomain>
	 <406F21FB.4010502@colorfullife.com>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1081029667.2037.55.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Apr 2004 17:01:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-03 at 15:43, Manfred Spraul wrote:

> Thus the kernel interface for mq_notify with sigev_notify==SIGEV_THREAD 
> is an asynchroneous interface: the initial syscall just registers 
> something and if a message arrives in the queue, then a notice is sent 
> to user space. glibc must then create a SuS compatible interface on top 
> of that.

The above is a good description of the challenge i think.

[..]

> I'm looking for the simplest interface to send 32 byte cookies from 
> kernel to user space. The final send must be non-blocking, setup can 
> block. Someone recommended that I should look at netlink. 
> netlink_unicast was nearly perfect, except that I had to split setup and 
> sending into two functions.

Your split of netlink_unicast seems fine ; 
I guess the bigger question is whether this interface could be a
speacilized netlink protocol instead? It doesnt seem too nasty as is
right now, just tending towards cleanliness.
It seems that user space must first open a netlink socket for this to
work but somehow the result skb is passed back to userspace using the
mq_notify and not via the socket interface opened? Why should user space
even bother doing this? The kernel could on its behalf, no? Are you sure
there will always be one and only one message outstanding always?

cheers,
jamal




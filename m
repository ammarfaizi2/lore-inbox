Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUDCUSw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUDCUSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:18:51 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:39389 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261925AbUDCUSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:18:48 -0500
Subject: Re: [RFC, PATCH] netlink based mq_notify(SIGEV_THREAD)
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Manfred Spraul <manfred@colorfullife.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Michal Wronski <wrona@mat.uni.torun.pl>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
In-Reply-To: <406F13A1.4030201@colorfullife.com>
References: <406F13A1.4030201@colorfullife.com>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1081023487.2037.19.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Apr 2004 15:18:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2004-04-03 at 14:42, Manfred Spraul wrote:
> mq_notify(SIGEV_THREAD) must be implemented in user space. If an event 
> is triggered, the kernel must send a notification to user space, and 
> then glibc must create the thread with the requested attributes for the 
> notification callback.

I am ignorant about SIGEV_THREAD but from what i gathered above: 

- something (from user space??) attempts to create a thread in the
kernel
- the kernel sends notification to user space when said thread is
created or done doing something it was asked
- something (in glibc/userspace??) is signalled by the kernel to do
something with the result

Is the above correct?

>  The current implementation in Andrew's -mm tree 
> uses single shot file descriptor - it works, but it's resource hungry.

Essentially you attempt to open only a single fd via netlink as opposed
to open/close behavior you are alluding to, is that correct? 
then all events are unicast to this fd. I am assuming you dont need to
have more than one listener to these events? example, could one process
create such a event which multiple processes may be interested in?

> Attached is a new proposal:
> - split netlink_unicast into separate substeps
> - use an AF_NETLINK socket for the message queue notification

I am trying to frob why you mucked around with AF_NETLINK; maybe your
response will shed some light.

cheers,
jamal



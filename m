Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFSXwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTFSXwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:52:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16649 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261994AbTFSXvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:51:55 -0400
Date: Thu, 19 Jun 2003 17:05:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Dake <sdake@mvista.com>
cc: Werner Almesberger <wa@almesberger.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <3EF24A70.4010608@mvista.com>
Message-ID: <Pine.LNX.4.44.0306191700010.1987-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jun 2003, Steven Dake wrote:
>
> A serialization methodology can be built on /sbin/hotplug, but it has 
> all of the problems that Linus previously talked about for a kernel 
> event queue.  The difference is that the problem is moved to userland.

Having event ordering is a trivial matter, and I'm not against adding a
sequence number to /sbin/hotplug as part of the environment, for example. 

What I worry about is the situation where one big deamon handles 
everything, which makes it impossible to "hook in" to the thing without 
understanding the one big thing.

The thing that makes /sbin/hotplug so wonderful is that it's stateless,
and if you want to hook into it, it's absolutely _trivial_.  Look at the 
default script there in redhat-9 for example, and it's obvious how to hook 
up to certain events etc.

And why do people care about serialization anyway? Really? The whole 
notion is ludicrous. /sbin/hotplug _shouldn't_ be serialized. 
Serialization is bad. You should look at whatever problems you have with 
it now, and ask yourself whether maybe it should be done some other way 
entirely.

		Linus


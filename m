Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbUK0AuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUK0AuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbUKZX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:56:03 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263111AbUKZTox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:44:53 -0500
To: linux-kernel@vger.kernel.org
Cc: d507a@cs.aau.dk
Subject: Re: Isolating two network processes on same machine
References: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
	<Pine.LNX.4.61.0411241113090.19813@chaos.analogic.com>
From: Ole Laursen <olau@cs.aau.dk>
Date: 25 Nov 2004 11:44:45 +0100
In-Reply-To: <Pine.LNX.4.61.0411241113090.19813@chaos.analogic.com>
Message-ID: <tv8k6saw6le.fsf@homer.cs.aau.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:

> I was going to say, set the netmask small enough so that both
> machines are on different networks and set default routes to
> your gateway....

Yeah, but that part of it is actually working as long as our processes
are running on different machines. The problem is that on the same
machine e.g. with this configuration

> >  ifconfig eth0:0 10.0.0.2 netmask 255.255.255.0 broadcast 10.0.0.255
> >  ifconfig eth0:1 10.0.1.2 netmask 255.255.255.0 broadcast 10.0.1.255

then the kernel somehow shortcircuits the routing table and doesn't
forward the packets to the default gateway, even though the two
addresses are on different subnets. It probably somehow knows that it
possesses both IPs itself, and then skip any further routing.

So basically, our problem is that the kernel is being too clever. If
we could just dumb it down or trick it somehow...


Thanks for your input,

-- 
Ole Laursen
http://www.cs.aau.dk/~olau/

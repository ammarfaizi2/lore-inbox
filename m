Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTI0UWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 16:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTI0UWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 16:22:13 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:50185
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S262164AbTI0UWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 16:22:07 -0400
Date: Sat, 27 Sep 2003 22:22:01 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: bridge@osdl.org
Subject: bridge breaks loopback on 2.4.22
Message-ID: <20030927202200.GA612@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since the change to 2.4.22 I've been experimenting problems here, after
many tests I have seen what I think is the problem that is causing this.

The problem I'm seing is the loopback starts loosing packages, I don't know
if this could also happen on other interfaces. I'm testing this by starting
a:
	tcpdump -n -i lo port
then a:
	nc -n -l port >/dev/null
and a:
	nc localhost port </dev/zero

If everything is fine my cpu goes to 100% and I see the packages all the way
in my tcpdump screen, great. But there are sometimes when this doesn't go
smooth and the tcpdump starts to show only one or two packages each N
seconds, till it ends up showing the resend of the last package which is
never acknowledged, you can even see that the timings of this packages that
are being repeated match those of tcp backoff, my cpu charge is then really
really low, nc disconnects after a while, ...

When does this happen?

It took me a while to find this out, but it happens when you have a bridge
interface and one of the ports of the bridge is told to drop packages, like
when they detect a loop in the net and an interface is set to a blocking
state.

Of course that the loopback is not a part of any bridge in any of my setups,
and I've seen this in a couple of machines, one SMP and the other one single
micro, 2.4.21 worked ok, at least I could not reproduce this on that one. If
the interfaces have been in a forwarding state all the time since the bridge
was setup, without being in a blocking state, then this problem does not
seem to happen.

I believe that the changes the bridge went through from 2.4.21 to 2.4.22 are
to blame on this one, but this is just a guess.

Hope we can find a fix for this so that it is integrated in 2.4.23 kernel,
I'll be happy to make any tests you want to track this farther down.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
